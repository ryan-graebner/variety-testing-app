import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart' as fluttertest;
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test/expect.dart';
import 'package:test/test.dart' as test;
import 'package:variety_testing_app/models/column_visibility.dart';
import 'package:variety_testing_app/models/data_set.dart';
import 'package:variety_testing_app/models/observation.dart';
import 'package:variety_testing_app/models/trait.dart';
import 'package:variety_testing_app/state/csv_manager.dart';

@GenerateMocks([Client])
import 'csv_manager_test.mocks.dart';

Future<String> readFile(String filename) async {
  final file = File('${Directory.current.path}/test/mock_data/$filename').openRead();
  final result = file.transform(utf8.decoder);
  return result.first;
}

void main() {
  fluttertest.TestWidgetsFlutterBinding.ensureInitialized();
  String mockIndexUrl = "https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/index.csv";

  test.group('indexFileParsing', () {
    test.test('CSVManager should correctly parse a valid index file', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('index.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);
      final expected = [
        '1-30-2024',
        '2023',
        'https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/hrs_low.csv',
        ''
      ];
      final actual = await csvManager.getIndexFileData();

      expect(actual, expected);
    });

    test.test('CSVManager should throw exception for a too-short index file', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('bad_index.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);

      expect(csvManager.getIndexFileData(), throwsA(isA<Exception>()));
    });

    test.test('CSVManager should throw exception for a bad response code', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('bad_index.csv'), 400)
      );

      final csvManager = CSVManager(mockIndexUrl, client);

      expect(csvManager.getIndexFileData(), throwsA(isA<Exception>()));
    });
  });
  test.group('indexFileMetaData', () {
    test.test('CSVManager should get last updated', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('index.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);
      await csvManager.getIndexFileData();
      const expected = '1-30-2024';
      final actual = csvManager.getLastUpdated();
      expect(actual, expected);
    });
    test.test('CSVManager should get data year', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('index.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);
      await csvManager.getIndexFileData();
      const expected = '2023';
      final actual = csvManager.getDataYear();
      expect(actual, expected);
    });
  });
  test.group('parseEachFileFromIndex', () {
    test.test('CSVManager should parse each file from a valid index', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('index.csv'), 200)
      );
      when(client.get(Uri.parse('https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/hrs_low.csv')))
          .thenAnswer((_) async =>
          Response(await readFile('HRS_Low.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);
      await csvManager.getIndexFileData();

      final expected = [
        DataSet(
            order: 0,
            name: 'HRS Low Rainfall (<20" Precip.)',
            traits: [
              Trait(order: 0, name: 'Entry', columnVisibility: ColumnVisibility.neverShown),
              Trait(order: 1, name: 'Variety', columnVisibility: ColumnVisibility.alwaysShown),
              Trait(order: 2, name: 'Released', columnVisibility: ColumnVisibility.releasedColumn),
              Trait(order: 3, name: 'Traits', columnVisibility: ColumnVisibility.shownByDefault),
              Trait(order: 4, name: 'Quality', columnVisibility: ColumnVisibility.shownByDefault),
              Trait(order: 5, name: 'Class', columnVisibility: ColumnVisibility.shownByDefault),
              Trait(order: 6, name: 'Yield', columnVisibility: ColumnVisibility.alwaysShown),
              Trait(order: 7, name: 'Test Weight', columnVisibility: ColumnVisibility.shownByDefault),
              Trait(order: 8, name: 'Protein', columnVisibility: ColumnVisibility.shownByDefault),
            ],
            observations: [
              Observation(order: 0, traitOrdersAndValues: HashMap.from({
                0: "137",
                1: "WA8355",
                2: "0",
                3: "",
                4: "",
                5: "HRS",
                6: "43.8",
                7: "61.3",
                8: "11.9"
              })),
              Observation(order: 1, traitOrdersAndValues: HashMap.from({
                0: "128",
                1: "Lanning",
                2: "1",
                3: "",
                4: "",
                5: "HRS",
                6: "41.6",
                7: "60.5",
                8: "12.6"
              })),
            ]
        )
      ];
      final actual = await csvManager.parseDataSets();

      expect(jsonEncode(actual), jsonEncode(expected));
    });
    test.test('CSVManager should parse a flipped CSV', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('index.csv'), 200)
      );
      when(client.get(Uri.parse('https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/hrs_low.csv')))
          .thenAnswer((_) async =>
          Response(await readFile('flipped_HRS_Low.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);
      await csvManager.getIndexFileData();

      final expected = [
        DataSet(
            order: 0,
            name: 'HRS Low Rainfall (<20" Precip.)',
            traits: [
              Trait(order: 0, name: 'Entry', columnVisibility: ColumnVisibility.neverShown),
              Trait(order: 1, name: 'Variety', columnVisibility: ColumnVisibility.alwaysShown),
              Trait(order: 2, name: 'Released', columnVisibility: ColumnVisibility.releasedColumn),
              Trait(order: 3, name: 'Traits', columnVisibility: ColumnVisibility.shownByDefault),
              Trait(order: 4, name: 'Quality', columnVisibility: ColumnVisibility.shownByDefault),
              Trait(order: 5, name: 'Class', columnVisibility: ColumnVisibility.shownByDefault),
              Trait(order: 6, name: 'Yield', columnVisibility: ColumnVisibility.alwaysShown),
            ],
            observations: [
              Observation(order: 0, traitOrdersAndValues: HashMap.from({
                0: "137",
                1: "WA8355",
                2: "0",
                3: "",
                4: "",
                5: "HRS",
                6: "43.8"
              })),
              Observation(order: 1, traitOrdersAndValues: HashMap.from({
                0: "128",
                1: "Lanning",
                2: "1",
                3: "",
                4: "",
                5: "HRS",
                6: "41.6"
              })),
            ]
        )
      ];
      final actual = await csvManager.parseDataSets();

      expect(jsonEncode(actual), jsonEncode(expected));
    });
    test.test('CSVManager should discard a CSV with no traits', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('index.csv'), 200)
      );
      when(client.get(Uri.parse('https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/hrs_low.csv')))
          .thenAnswer((_) async =>
          Response(await readFile('no_traits_HRS_Low.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);
      await csvManager.getIndexFileData();

      final expected = [];
      final actual = await csvManager.parseDataSets();

      expect(jsonEncode(actual), jsonEncode(expected));
    });
    test.test('CSVManager should discard a CSV with no observations', () async {
      final client = MockClient();

      when(client.get(Uri.parse(mockIndexUrl)))
          .thenAnswer((_) async =>
          Response(await readFile('index.csv'), 200)
      );
      when(client.get(Uri.parse('https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/hrs_low.csv')))
          .thenAnswer((_) async =>
          Response(await readFile('bad_HRS_Low.csv'), 200)
      );

      final csvManager = CSVManager(mockIndexUrl, client);
      await csvManager.getIndexFileData();

      final expected = [];
      final actual = await csvManager.parseDataSets();

      expect(jsonEncode(actual), jsonEncode(expected));
    });
  });
}