import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test/expect.dart';
import 'package:test/test.dart' as test;
import 'package:variety_testing_app/models/data_set.dart';
import 'package:variety_testing_app/state/csv_manager.dart';
import 'package:variety_testing_app/state/data_repository.dart';
import 'package:variety_testing_app/state/local_storage_service.dart';

@GenerateMocks([CSVManager])
import 'data_repository_test.mocks.dart';

void main() {

  test.group('initializeData', () {
    test.test('Can\'t retrieve data from internet', () async {

    });
    test.test('Can\'t parse index CSV', () async {

    });
    test.test('Successful but gets data from LocalStorage', () async {

    });
    test.test('Successful but needs to - and cannot - get data from LocalStorage', () async {

    });
    test.test('Successful and needs to update from internet, but gets back empty DataSet list', () async {

    });
    test.test('Successful and gets valid update from internet', () async {
      final csvManager = MockCSVManager();

      when(csvManager.getIndexFileData())
          .thenAnswer((_) async => [
            "1-30-2024",
            "2023",
            "https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/hrs_low.csv",
            ""
          ]);
      when(csvManager.getLastUpdated()).thenAnswer((_) => "1-30-2024");
      when(csvManager.getDataYear()).thenAnswer((_) => "2023");
      when(csvManager.parseDataSets()).thenAnswer((_) async => MockDataSet.mockData());

      final dataRepository = DataRepository(csvManager, LocalStorageService());

      await dataRepository.initializeData();

      final expected = MockDataSet.mockData();
      final actual = dataRepository.dataSets;

      expect(jsonEncode(actual), jsonEncode(expected));
    });
  });
}