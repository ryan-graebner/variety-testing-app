import 'dart:collection';
import 'dart:core';
import 'dart:math';
import 'package:http/http.dart';
import 'package:variety_testing_app/models/column_visibility.dart';
import 'package:variety_testing_app/models/observation.dart';
import '../models/data_set.dart';
import '../models/trait.dart';

class CSVManager {
  Client httpClient;
  String indexUrl;
  List<String> indexFileRows = [];
  List<List<String>> csvRows = [];

  CSVManager(this.indexUrl, this.httpClient);

  Future<List<String>> getIndexFileData() async {
    try {
      final indexData = await fetchCSV(indexUrl);
      indexFileRows = indexData.split(RegExp(r'(\r\n|\r|\n)'));

      if (indexFileRows.length < 4) {
        throw Exception('Could not parse index CSV. Please ensure it has at least 3 rows.');
      }
      return indexFileRows;
    } catch (error) {
      return [];
    }
  }

  String getLastUpdated() {
    // Row 0: last updated
    return indexFileRows.isNotEmpty ? indexFileRows[0].trim() : "";
  }

  String getDataYear() {
    // Row 1: year of data
    return indexFileRows.isNotEmpty ? indexFileRows[1].trim() : "";
  }

  Future<List<DataSet>> parseDataSets() async {
    for (String indexRow in indexFileRows.sublist(2)) {
      indexRow = indexRow.trim();
      if (!indexRow.startsWith('http')) continue;
      String sheetData = await fetchCSV(indexRow);
      List<String> sheetRows = sheetData.split(RegExp(r'(\r\n|\r|\n)'));

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

    return parseCSVData(csvRows);
  }

  //region Utility methods
  Future<String> fetchCSV(String url) async {
    Response response = await httpClient.get(Uri.parse(url));
    return response.body;
  }

  List<DataSet> parseCSVData(List<List<String>> data) {
    List<DataSet> dataSets = [];
    
    for (int i = 0; i < data.length; i++) {
      List<String> dataSetRows = data[i];
      DataSet? maybeDataSet = parseSingleDataSet(order: i, dataRows: dataSetRows);
      if (maybeDataSet != null) {
        dataSets.add(maybeDataSet);
      }
    }

    return dataSets;
  }

  DataSet? parseSingleDataSet({required int order, required List<String> dataRows}) {

    // Row 0: DataSet name
    String name = dataRows[0].split(',')[0];
    name = name.replaceAll(RegExp(r'^"|"$'), '');
    name = name.replaceAll('""', '"');

    List<Trait> traits = [];
    List<Observation> observations = [];

    // Row 1 and 2: DataSet columnVisibilities and Trait names
    List<String> columnVisibilities = getCellValues(dataRows[1]).map((e) => e.trim()).toList();
    List<String> traitNames = getCellValues(dataRows[2]).map((e) => e.trim()).toList();

    if (!columnVisibilities.every((visibility) => int.tryParse(visibility) != null)) {
      // Maybe the visibilities are row 2 instead of row 1?
      bool isRow2Visibilities = traitNames.every((visibility) => int.tryParse(visibility) != null);
      if (isRow2Visibilities) {
        List<String> temp = columnVisibilities;
        columnVisibilities = traitNames;
        traitNames = temp;
      } else {
        // Discard malformed dataset
        return null;
      }
    }

    if (columnVisibilities.length != traitNames.length) {
      return null;
    }
    int columnCount = traitNames.length;

    for (int i = 0; i < columnCount; i++) {
      int? visibility = int.tryParse(columnVisibilities[i]);
      if (visibility == null) {
        return null;
      }

      traits.add(Trait(order: i,
            name: traitNames[i],
            columnVisibility: ColumnVisibility.fromNumber(visibility)));
    }

    List<String> obsDataRows = dataRows.sublist(3);

    // Rows 3+: Observations
    for (int i = 0; i < obsDataRows.length; i++) {
      String observationRow = obsDataRows[i];
      List<String> observationValues = getCellValues(observationRow);

      Map<int, String> observationTraits = {};
      for (int i = 0; i < min(columnCount, observationValues.length); i++) {
        observationTraits[i] = observationValues[i];
      }
      observations.add(Observation(order: i, traitOrdersAndValues: HashMap.from(observationTraits)));
    }

    if (traits.isNotEmpty && observations.isNotEmpty) {
      return DataSet(order: order, name: name, traits: traits, observations: observations);
    }
    return null;
  }

  List<String> getCellValues(String row) {
    return row.split(',');
  }
  //endregion
}