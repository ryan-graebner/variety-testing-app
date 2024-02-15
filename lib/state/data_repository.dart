import 'package:flutter/foundation.dart';
import 'package:variety_testing_app/state/csv_manager.dart';
import 'package:variety_testing_app/state/local_storage_service.dart';
import '../models/data_set.dart';
import '../models/observation.dart';
import '../models/trait.dart';

class DataRepository extends ChangeNotifier {
  final CSVManager csvManager;
  final LocalStorageService localStorageService;
  String? lastUpdated = '2022'; // TODO: get this from local storage
  String? dataYear = '2022'; // TODO: get from local storage

  List<DataSet> dataSets = [];

  DataRepository(this.csvManager, this.localStorageService);

  // DataRepository will initialize and coordinate all of the data fetching.
  Future<void> initializeData() async {
    try {
      await csvManager.getIndexFileData();
      String newLastUpdated = csvManager.getLastUpdated();
      String newDataYear = csvManager.getDataYear();
      if (newLastUpdated == lastUpdated && newDataYear == dataYear) {
        // TODO: Load from Local Storage
        // TODO: If can't load, throw an exception
        return;
      }
      lastUpdated = newLastUpdated;
      dataYear = newDataYear;

      dataSets = await csvManager.parseDataSets();
      // TODO: load datasets into local storage
    } catch (error) {
      // TODO: Display the error in the UI if this happens
      if (kDebugMode) {
        print(error.toString());
      }
      //  If can't connect and there is data in LocalStorage:
      //    - Get stored AppState from Local storage and deserialize
      //  If can't connect and no data in LocalStorage:
      //    - Throw exception that should be handled at app top level. The user has to be connected at first sync
    }
  }

  Future<void> saveStateToLocalStorage() async {
    // TODO: after figuring out how to store the entire app state.
  }

  Future<String?> retrieveStateFromLocalStorage() async {
    return await localStorageService.retrieveData();
  }

  static void debugPrint(List<DataSet> data) {
    if (kDebugMode) {
      for (DataSet d in data) {
        print('DataSet ${d.order} - ${d.name}');
        print('Traits:');
        for (Trait trait in d.traits) {
          print('${trait.order} ${trait.name} ${trait.columnVisibility}');
        }
        print('Observations:');
        for (Observation observation in d.observations) {
          print('${observation.order} ${observation.traitOrdersAndValues}');
        }
        print('\n');
      }
    }
  }
}