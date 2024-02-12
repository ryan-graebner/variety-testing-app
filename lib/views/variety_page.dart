import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_table_2/data_table_2.dart';
import '../state/app_state.dart';
import 'loading_view.dart';

// TODO: Split different pieces out into separate widgets for ease of code maintenance
class VarietyPage extends StatefulWidget {
  const VarietyPage({super.key});

  @override
  State<VarietyPage> createState() => _VarietyPageState();
}

class _VarietyPageState extends State<VarietyPage> {
  IconData _showDataIcon = Icons.chevron_right;
  IconData _releasedToggle = Icons.toggle_off;
  Color _releasedToggleColor = Colors.grey;
  bool _filtersVisible = false;
  bool _tableVisible = false;

  double calcColSize(int size) {
    if (17.5 * size > 200.0) {
      return 200.0;
    } else {
      return 17.5 * size;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Catch exceptions here that are thrown when parsing data?
    return context.watch<AppState>().isLoading
        ? const LoadingView()
        : Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Rows to hold environment label and dropdown
          Container(
            color: Colors.grey.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Environment",
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'openSans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  // Create the dropdown based off the list of environments.
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: DropdownMenu<String>(
                        width: MediaQuery.of(context).size.width - 116.0,
                        initialSelection: context.watch<AppState>().dropdownValues.firstOrNull,
                        dropdownMenuEntries: context.watch<AppState>().dropdownValues.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value,
                              label: value
                          );
                        }).toList(),
                        onSelected: (String? value) {
                          _tableVisible = false;
                          context.read<AppState>().changeDataSet(value);
                        },
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],),
            ),
          ),

          // Container for Show/Hide Traits button and show Data FAB
          Container(
            color: Colors.grey.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Handles changing the App icon and showing/hding the filter panel
                        setState(() {
                          if (_showDataIcon == Icons.chevron_right) {
                            _showDataIcon = Icons.expand_more;
                            _filtersVisible = true;
                          } else {
                            _showDataIcon = Icons.chevron_right;
                            _filtersVisible = false;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          const Text("Show/Hide Traits",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 215, 64, 9)),
                          ),
                          Icon(_showDataIcon, size: 24, color: const Color.fromARGB(255, 215, 64, 9)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120.0,
                      child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              // Hide the traits filters, reset the button and make the table visible.
                              _filtersVisible = false;
                              _showDataIcon = Icons.chevron_right;
                              _tableVisible = true;
                            });
                          },
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          child: const Text("Show Data", style: TextStyle(fontSize: 14.0),)
                      ),
                    )
                  ]),
            ),
          ),

          // Visibility for Checkboxes.
          Visibility(
              visible: _filtersVisible,
              child: Container(
                  color: Colors.grey.withOpacity(0.3),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Handles changing the App icon and showing/hding the filter panel
                                setState(() {
                                  // TODO: Link toggle to actually only filter released.
                                  if (_releasedToggle == Icons.toggle_off) {
                                    _releasedToggle = Icons.toggle_on;
                                    _releasedToggleColor = const Color.fromARGB(255, 215, 64, 9);
                                  } else {
                                    _releasedToggle = Icons.toggle_off;
                                    _releasedToggleColor = Colors.grey;
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(_releasedToggle, size: 30, color: _releasedToggleColor),
                                  const Text("Released Only",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                  itemCount: context.watch<AppState>().currentTraits.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      value: context.watch<AppState>().currentTraits[index].isChecked,
                                      title: Text(context.watch<AppState>().currentTraits[index].traitName),
                                      onChanged: (bool? checked) {
                                        context.read<AppState>().toggleCheckbox(index);
                                      },
                                      controlAffinity: ListTileControlAffinity.leading,
                                    );
                                  }),
                            )
                          ]
                      )
                  )
              )
          ),

          // TODO: Figure out a better way than all of the context.watch statements
          // TODO: Fix this crashing app when there are no traits or observations (or catch that way earlier)
          // DATA Table Widget
          Flexible(
            child: Visibility(
                visible: !context.watch<AppState>().isLoading && _tableVisible,
                child: DataTable2(
                    dataRowHeight: 80.0,
                    minWidth: 3000.0,
                    fixedLeftColumns: 1,
                    fixedTopRows: 1,
                    empty: const Text("Empty"),
                    dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {return Colors.grey.withOpacity(0.3); }),
                    columns: List<DataColumn2>.generate(context.watch<AppState>().currentDataSet.traits.length, (index) =>
                        DataColumn2(
                          label: Text(context.watch<AppState>().currentDataSet.traits[index].name ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                            softWrap: true,
                          ),
                          fixedWidth: calcColSize(context.watch<AppState>().currentDataSet.traits[index].name.length ?? 10),
                        ),
                    ),
                    rows: List<DataRow2>.generate(context.watch<AppState>().currentDataSet.observations.length, (rowIndex) => DataRow2(
                        cells: List<DataCell>.generate(context.watch<AppState>().currentDataSet.observations[rowIndex].traitOrdersAndValues.length, (cellIndex) =>
                            DataCell(
                                Text(
                                  '${context.watch<AppState>().currentDataSet.observations[rowIndex].traitOrdersAndValues[cellIndex + 1] ?? ""}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  softWrap: true,
                                )
                            )
                        )
                    )
                    )
                )
            ),
          )
        ],
      ),
    );
  }
}