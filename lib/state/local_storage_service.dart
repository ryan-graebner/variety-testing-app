import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> storeData(String appState) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('appState', appState);
  }

  Future<String?> retrieveData() async {
    final prefs = await SharedPreferences.getInstance();
    final appState = prefs.getString('appState');
    return appState;
  }

  void eraseData() {

  }
}