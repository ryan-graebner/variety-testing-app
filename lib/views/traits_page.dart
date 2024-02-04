import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:csv/csv.dart';



class TraitsPage extends StatefulWidget {
  @override
  State<TraitsPage> createState() => _TraitsPageState();
}

class _TraitsPageState extends State<TraitsPage> {
  List<List<dynamic>> _traitData = [];

  @override
  void initState() {
    super.initState();
    // Get data from storage to app state.
    processCsv();
  }

  // Function to read the CSV data and assign it to the App State
  void processCsv() async {
      // TODO: Replace call from csv to either  sql query or perm csv file.
      final result = await rootBundle.loadString("dummy_data/traits.csv");
      List<List<dynamic>> traitData = const CsvToListConverter().convert(result, eol: "\n");
      setState(() {
        _traitData = traitData;
      });

    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataTable2(
        dataRowHeight: 80.0,
        columns: <DataColumn2>[
          DataColumn2(label: Text("Traits", style: Theme.of(context).textTheme.bodyLarge), fixedWidth: 100.0),
          DataColumn2(label: Text("Description", style: Theme.of(context).textTheme.bodyLarge)),
        ],
        rows: List<DataRow>.generate(_traitData.length, (index) => DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (index.isEven) {
                return Colors.grey.withOpacity(0.3);
              }
          
              return null;
          }),
          cells: 
            <DataCell>[
              DataCell(Text(_traitData[index][0], style: Theme.of(context).textTheme.bodyLarge)),
              DataCell(Text(_traitData[index][1], style: Theme.of(context).textTheme.bodyMedium)),
            ])
        )
      )
    );
  }
}