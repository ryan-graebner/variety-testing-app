import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:variety_testing_app/state/csv_manager.dart';
import 'package:variety_testing_app/state/data_repository.dart';
import '../models/column_visibility.dart';
import '../models/data_set.dart';
import '../models/trait.dart';

class AppState extends ChangeNotifier {
  DataRepository dataRepository = DataRepository(CSVManager(Client()));
  List<String> dropdownValues = [];
  DataSet _currentDataSet = DataSet(order: 1, name: 'No Data', traits: [], observations: []); // TODO: Handle this better
  List<TraitsFilter> _currentTraits = [];
  bool isLoading = true;
  String? error;

  get currentDataSet => _currentDataSet;
  get currentTraits => _currentTraits;

  AppState() {
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await dataRepository.initializeData();
      dropdownValues = dataRepository.dataSets.map((ds) => ds.name).toList();
      _currentDataSet = dataRepository.dataSets.firstOrNull ?? DataSet(order: 1, name: 'No Data', traits: [Trait(order: 0, name: 'none', columnVisibility: ColumnVisibility.alwaysShown)], observations: []);
      _currentTraits = await initializeTraits();
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
      } else {
        // TODO: ?
      }
    }
    return traitFilters;
  }

  Future<void> changeDataSet(String? name) async {
    DataSet dataSet = dataRepository.dataSets.firstWhere((set) => set.name == name);
    _currentDataSet = dataSet;
    _currentTraits = await initializeTraits();
    notifyListeners();
  }

  toggleCheckbox(int index) {
    currentTraits[index].isChecked = !currentTraits[index].isChecked;
    notifyListeners();
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
