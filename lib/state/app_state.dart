import 'package:flutter/material.dart';
import 'package:variety_testing_app/state/data_repository.dart';
import '../models/data_set.dart';
import '../models/trait.dart';
import 'csv_manager.dart';

class AppState extends ChangeNotifier {
  DataRepository dataRepository = DataRepository(CSVManager());
  List<String> dropdownValues = [];
  DataSet? _currentDataSet;
  List<Trait> _currentTraits = [];
  bool isLoading = true;

  get currentDataSet => _currentDataSet;
  get currentTraits => _currentTraits;

  AppState() {
    initializeData();
  }

  Future<void> initializeData() async {
    await dataRepository.initializeData();
    dropdownValues = dataRepository.dataSets?.map((ds) => ds.name).toList() ?? [];
    isLoading = false;
    notifyListeners();
  }

  void changeDataSet(String? name) {
    DataSet? dataSet = dataRepository.dataSets?.firstWhere((set) => set.name == name);
    _currentDataSet = dataSet;
    _currentTraits = dataSet?.traits ?? [];
    notifyListeners();
  }
}