import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> storeDataYear(String dataYear) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataYear', dataYear);
  }

  Future<String?> retrieveDataYear() async {
    final prefs = await SharedPreferences.getInstance();
    final dataYear = prefs.getString('dataYear');
    return dataYear;
  }

  Future<void> storeLastUpdated(String lastUpdated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastUpdated', lastUpdated);
  }

  Future<String?> retrieveLastUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdated = prefs.getString('lastUpdated');
    return lastUpdated;
  }

  Future<void> storeData(String appState) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('appState', appState);
  }

  Future<String?> retrieveData() async {
    final prefs = await SharedPreferences.getInstance();
    final appState = prefs.getString('appState');
    return appState;
  }

  Future<void> storeColumnState(String columnState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('columnState', columnState);
  }

  Future<String?> retrieveColumnState() async {
    final prefs = await SharedPreferences.getInstance();
    String? columnState = prefs.getString('columnState');
    return columnState;
  }

  Future<void> voidColumnState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('columnState');
  }

  Future<void> storeCurrentDataSet(String dataSetName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataSetName', dataSetName);
  }

  Future<String?> retrieveCurrentDataSet() async {
    final prefs = await SharedPreferences.getInstance();
    String? dataSetName = prefs.getString('dataSetName');
    return dataSetName;
  }

  Future<void> voidCurrentDataSet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('dataSetName');
  }
}