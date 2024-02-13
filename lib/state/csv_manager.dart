import 'dart:collection';
import 'dart:core';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:variety_testing_app/models/column_visibility.dart';
import 'package:variety_testing_app/models/observation.dart';
import '../models/data_set.dart';
import '../models/trait.dart';
import '../utilities/config.dart';

class CSVManager {
  List<String> indexFileRows = [];
  List<List<String>> csvRows = [];

  CSVManager();

  Future<List<String>> getIndexFileData() async {
    http.Response indexData = await _fetchCSV(Config.indexUrl);
    indexFileRows = indexData.body.split('\n');

    if (indexFileRows.length < 3) {
      throw Exception(
          'Could not parse index CSV. Make sure it has at least 3 rows.');
    }
    return indexFileRows;
  }

  String getLastUpdated() {
    // Row 0: last updated
    return indexFileRows[0].trim();
  }

  String getDataYear() {
    // Row 1: year of data
    return indexFileRows[1].trim();
  }

  Future<List<DataSet>> parseDataSets() async {
    for (String indexRow in indexFileRows.sublist(2)) {
      indexRow = indexRow.trim();
      if (!indexRow.startsWith('http')) continue;
      http.Response sheetData = await _fetchCSV(indexRow);
      List<String> sheetRows = sheetData.body.split('\n');

      if (sheetRows.length < 4) continue;

      List<String> currentSheetList = [];
      for (String sheetRow in sheetRows) {
        String trimmed = sheetRow.trim();
        if (trimmed != '') {
          currentSheetList.add(sheetRow.trim());
        }
      }

      csvRows.add(currentSheetList);
    }

    return _parseCSVData(csvRows);
  }

  //region Private methods
  Future<http.Response> _fetchCSV(String url) {
    return http.get(Uri.parse(url));
  }

  List<DataSet> _parseCSVData(List<List<String>> data) {
    List<DataSet> dataSets = [];
    
    for (int i = 0; i < data.length; i++) {
      List<String> dataSetRows = data[i];
      dataSets.add(_parseSingleDataSet(order: i, dataRows: dataSetRows));
    }

    return dataSets;
  }

  // TODO: Should probably discard a data set without any associated traits (due to file error)
  // Or try parsing visibility first and trait name first if possible
  DataSet _parseSingleDataSet({required int order, required List<String> dataRows}) {

    // Row 0: DataSet name
    String name = dataRows[0].split(',')[0];
    name = name.replaceAll(RegExp(r'^"|"$'), '');
    name = name.replaceAll('""', '"');

    List<Trait> traits = [];
    List<Observation> observations = [];

    // Row 1 and 2: DataSet columnVisibilities and Trait names
    List<String> columnVisibilities = _getCellValues(dataRows[1]);
    List<String> traitNames = _getCellValues(dataRows[2]);
    int columnCount = min(columnVisibilities.length, traitNames.length);

    for (int i = 0; i < columnCount; i++) {
      int? visibility = int.tryParse(columnVisibilities[i].trim());
      if (visibility != null) {
        traits.add(Trait(order: i,
            name: traitNames[i],
            columnVisibility: ColumnVisibility.fromNumber(visibility)));
      }
    }

    List<String> obsDataRows = dataRows.sublist(3);

    // Rows 3+: Observations
    for (int i = 0; i < obsDataRows.length; i++) {
      String observationRow = obsDataRows[i];
      List<String> observationValues = _getCellValues(observationRow);

      Map<int, String> observationTraits = {};
      for (int i = 0; i < observationValues.length; i++) {
        observationTraits[i] = observationValues[i];
      }
      observations.add(Observation(order: i, traitOrdersAndValues: HashMap.from(observationTraits)));
    }

    return DataSet(order: order, name: name, traits: traits, observations: observations);
  }

  List<String> _getCellValues(String row) {
    return row.split(',');
  }
  //endregion
}