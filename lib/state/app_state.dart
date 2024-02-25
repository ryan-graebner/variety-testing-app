import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:variety_testing_app/models/observation.dart';
import 'package:variety_testing_app/state/csv_manager.dart';
import 'package:variety_testing_app/state/data_repository.dart';
import 'package:variety_testing_app/state/local_storage_service.dart';
import '../models/column_visibility.dart';
import '../models/data_set.dart';
import '../models/trait.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

class AppState extends ChangeNotifier {
  DataRepository dataRepository = DataRepository(CSVManager(Client()), LocalStorageService());
  List<String> dropdownValues = [];
  DataSet _currentDataSet = DataSet(order: 1, name: 'No Data', traits: [], observations: []); // TODO: Handle this better
  DataSet _visibleDataSet = DataSet(order: 1, name: 'No Data', traits: [], observations: []);
  List<TraitsFilter> _currentTraits = [];
  bool isLoading = true;
  bool releasedToggle = false;
  String? error;

  get currentDataSet => _currentDataSet;
  get currentTraits => _currentTraits;
  get visibleDataSet => _visibleDataSet;

  AppState() {
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await dataRepository.initializeData();
      dropdownValues = dataRepository.dataSets.map((ds) => ds.name).toList();
      _currentDataSet = dataRepository.dataSets.firstOrNull ?? DataSet(order: 1, name: 'No Data', traits: [Trait(order: 0, name: 'none', columnVisibility: ColumnVisibility.alwaysShown)], observations: []);
      _currentTraits = await initializeTraits();
      _visibleDataSet = await createVisibleDataset(_currentDataSet);
      isLoading = false;
      notifyListeners();
    } catch(e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<List<TraitsFilter>> initializeTraits() async {
    List<TraitsFilter> traitFilters = [];
    for (Trait trait in _currentDataSet.traits) {
      if (trait.columnVisibility == ColumnVisibility.shownByDefault) {
        traitFilters.add(TraitsFilter(trait.name, true));
      } else if (trait.columnVisibility == ColumnVisibility.hiddenByDefault){
        traitFilters.add(TraitsFilter(trait.name, false));
      } 
    }
    return traitFilters;
  }

  Future<void> changeDataSet(String? name) async {
    DataSet dataSet = dataRepository.dataSets.firstWhere((set) => set.name == name);
    _currentDataSet = dataSet;
    _currentTraits = await initializeTraits();
    _visibleDataSet =  await createVisibleDataset(_currentDataSet);
    notifyListeners();
  }

  toggleCheckbox(int index) async {
    currentTraits[index].isChecked = !currentTraits[index].isChecked;
    _visibleDataSet = await createVisibleDataset(_currentDataSet);
    notifyListeners();
  }

  toggleReleased() async {
    releasedToggle = !releasedToggle;
    _visibleDataSet = await createVisibleDataset(_currentDataSet);
    notifyListeners();
  }

  // This function adjusts the data in the app to show only what we want.
  Future<DataSet> createVisibleDataset(DataSet aSet) async {
    // Create a blank dataset to show
    DataSet visibleDataSet = DataSet(order: 1, name: aSet.name, traits: [], observations: []);
    List<Trait> hiddenColumns = [];
    List<int> shownColumns = [];
    Trait? releasedTrait;
    int traitOrderHeaders = 0;
    // Loop through and add columns which are shown.
    for (int x = 0; x < aSet.traits.length; x++) {
      // Add always shown columns
      if(aSet.traits[x].columnVisibility == ColumnVisibility.alwaysShown) {
        visibleDataSet.traits.add(
          Trait(
            order: traitOrderHeaders, 
            name: aSet.traits[x].name, 
            columnVisibility: aSet.traits[x].columnVisibility));
            traitOrderHeaders = traitOrderHeaders + 1;
        shownColumns.add(aSet.traits[x].order);
        
      // Add Shown by Default if not set to false in trait filter.
      } else if (aSet.traits[x].columnVisibility == ColumnVisibility.shownByDefault) {
        if (_currentTraits.any((element) => element.traitName == aSet.traits[x].name && element.isChecked == true)) {
          visibleDataSet.traits.add(
          Trait(
            order: traitOrderHeaders, 
            name: aSet.traits[x].name, 
            columnVisibility: aSet.traits[x].columnVisibility));
            traitOrderHeaders = traitOrderHeaders + 1;
          shownColumns.add(aSet.traits[x].order);
        } else if (_currentTraits.any((element) => element.traitName == aSet.traits[x].name && element.isChecked == false)) {
          hiddenColumns.add(aSet.traits[x]);
        }
      // Add Hidden by default if not set to false in trait filter
      } else if (aSet.traits[x].columnVisibility == ColumnVisibility.hiddenByDefault) {
        if (_currentTraits.any((element) => element.traitName == aSet.traits[x].name && element.isChecked == true)) {
          visibleDataSet.traits.add(
          Trait(
            order: traitOrderHeaders, 
            name: aSet.traits[x].name, 
            columnVisibility: aSet.traits[x].columnVisibility));
            traitOrderHeaders = traitOrderHeaders + 1;
          shownColumns.add(aSet.traits[x].order);
        } else if (_currentTraits.any((element) => element.traitName == aSet.traits[x].name && element.isChecked == false)) {
          hiddenColumns.add(aSet.traits[x]);
        }
      // Never show Released Column
      } else if (aSet.traits[x].columnVisibility == ColumnVisibility.releasedColumn){
        hiddenColumns.add(aSet.traits[x]);
        releasedTrait = aSet.traits[x];
      } else {
        hiddenColumns.add(aSet.traits[x]);
      }
    }
    int orderCounter = 0;
    int traitOrder = 0;
    List<(int, String)> obTraits = [];
    // Extract traits to a list - sort by the key and then add as observations to the blank data set
    for (Observation obs in aSet.observations) {
      HashMap<int, String> updatedTraits = HashMap<int, String>();
      // Filter out released
      if (releasedToggle == true) {
        if (obs.traitOrdersAndValues[releasedTrait!.order] == "0") {
          // Skip adding this trait because it isn't released.
          continue;
        }
      }
      // Extract the keys and values - adding them to a list to be sortable
      for (int key in obs.traitOrdersAndValues.keys) {
        if (shownColumns.contains(key)) {
          obTraits.add((key, obs.traitOrdersAndValues[key]!.toString()));      
        }
      }
      
      // Sort the Keys to match to the correct columns and re order.
      obTraits.sort((a, b) => a.$1.compareTo(b.$1));
      for (int x = 0; x < obTraits.length; x++) {
        updatedTraits[traitOrder] = obTraits[x].$2; 
        traitOrder = traitOrder + 1;
      }
      // Add the data set to the observations.
      visibleDataSet.observations.add(Observation(order: orderCounter, traitOrdersAndValues: updatedTraits));
      orderCounter = orderCounter + 1;
      traitOrder = 0;
      obTraits = [];
    }

    
    // if (kDebugMode) {
    //   print('DataSet ${visibleDataSet.order} - ${visibleDataSet.name}');
    //   print('Traits:');
    //   for (Trait trait in visibleDataSet.traits) {
    //       print('${trait.order} ${trait.name} ${trait.columnVisibility}');
    //   }
    //   print('Observations:');
    //   for (Observation observation in visibleDataSet.observations) {
    //     print('${observation.order} ${observation.traitOrdersAndValues}');
    //   }
    //   print("HIDDEN");
    //   for (Trait x in hiddenColumns) {
    //     print(x.name);
    //   }
    //   print("VISIBLE");
    //   for (Trait y in visibleDataSet.traits) {
    //     print(y.name);
    //   }
    // }
    
    return visibleDataSet;
    }

}



// Helper class for traits Filter
class TraitsFilter {
  TraitsFilter(
      this.traitName,
      [this.isChecked = false]
      );
  String traitName;
  bool isChecked;
}

