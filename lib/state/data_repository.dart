import 'package:variety_testing_app/state/csv_manager.dart';
import '../models/data_set.dart';

class DataRepository {
  final CSVManager csvManager;
  String? lastUpdated = '2022'; // TODO: get this from local storage
  String? dataYear = '2022'; // TODO: get from local storage

  List<DataSet>? dataSets;

  DataRepository(this.csvManager) {
    initializeData();
  }

  // DataRepository will initialize and coordinate all of the data fetching.
  void initializeData() async {
    try {
      await csvManager.getIndexFileData();
      String newLastUpdated = csvManager.getLastUpdated();
      String newDataYear = csvManager.getDataYear();
      if (newLastUpdated == lastUpdated && newDataYear == dataYear) {
        // No need to load new data. Load from Local Storage
        // If can't load, throw an exception
        return;
      }
      lastUpdated = newLastUpdated;
      dataYear = newDataYear;

      dataSets = await csvManager.parseDataSets();
      // load datasets into local storage
    } catch (error) {
      // TODO: Display the error in the UI if this happens
      //  If can't connect and there is data in LocalStorage:
      //    - Get stored AppState from Local storage and deserialize
      //  If can't connect and no data in LocalStorage:
      //    - Throw exception that should be handled at app top level. The user has to be connected at first sync
    }
  }

  static void debugPrint(List<DataSet> data) {
    for (DataSet d in data) {
      print('DataSet ${d.order} - ${d.name}');
      print('Traits:');
      d.traits.forEach((t) => print('${t.order} ${t.name} ${t.columnVisibility}'));
      print('Observations:');
      d.observations.forEach((o) => print('${o.order} ${o.traitOrdersAndValues}'));
      print('\n');
    }
  }
}