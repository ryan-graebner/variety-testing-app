import 'package:flutter/material.dart';
import 'package:variety_testing_app/state/data_repository.dart';
import '../models/column_visibility.dart';
import '../models/data_set.dart';
import '../models/trait.dart';
import 'csv_manager.dart';

class AppState extends ChangeNotifier {
  DataRepository dataRepository = DataRepository(CSVManager());
  List<String> dropdownValues = [];
  DataSet _currentDataSet = DataSet(order: 1, name: 'No Data', traits: [], observations: []);
  List<TraitsFilter> _currentTraits = [];
  bool isLoading = true;

  get currentDataSet => _currentDataSet;
  get currentTraits => _currentTraits;

  AppState() {
    initializeData();
  }

  Future<void> initializeData() async {
    await dataRepository.initializeData();
    dropdownValues = dataRepository.dataSets.map((ds) => ds.name).toList();
    _currentDataSet = dataRepository.dataSets.first;
    _currentTraits = await initializeTraits();
    isLoading = false;
    notifyListeners();
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
