import 'package:variety_testing_app/state/database_service.dart';

class DataRepository {
  /*
  On app startup, connect to remote file/directory
  - If can connect and data is new:
    - Tell LocalStorageService to erase the stored state on the user device
    - Remove old data, add new data to DB
    - Fetch data from DB and deserialize
  If can connect and data is old:
    - Get stored AppState from Local storage
    - Fetch data from DB and deserialize
  If can't connect and there is data in the DB:
    - Get stored AppState from Local storage
    - Fetch data from DB and deserialize
  If can't connect and no data in DB:
    - Throw exception that should be handled at app top level. The user has to be connected at first sync

  Holds all of the current data’s model classes.
   */

  final DatabaseService dbService;
  final String testProvider = "String from the DataRepository";

  DataRepository(this.dbService);
}