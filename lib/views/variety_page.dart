import 'package:flutter/material.dart';
import 'package:variety_testing_app/models/column_visibility.dart';
import 'package:variety_testing_app/models/data_set.dart';
import 'package:provider/provider.dart';
import 'package:variety_testing_app/state/data_repository.dart';
import 'package:data_table_2/data_table_2.dart';


class VarietyPage extends StatefulWidget {
  @override
  State<VarietyPage> createState() => _VarietyPageState();
}

class _VarietyPageState extends State<VarietyPage> {
      // Pulls mock Data sets into page.
    List<DataSet> _dataSets = MockDataSet.mockData();
    List<String> _environments = [];
    DataSet? _selectedDataSet = null;
    String _selectedEnvironment = "";
    List<TraitsFilter> _traitsFilters = [];
    IconData _showDataIcon = Icons.chevron_right;
    IconData _releasedToggle = Icons.toggle_off;
    Color _releasedToggleColor = Colors.grey;
    bool _filtersVisibile = false;
    bool _tableVisible = false;


    // Helper List to create traits per environment
List<TraitsFilter> getTraits() {
  List<TraitsFilter> traits = [];
  _dataSets.forEach((set) {
    if (set.name == _selectedEnvironment) {
      _selectedDataSet = set;
      set.traits.forEach((trait) {
      if (trait.columnVisibility == ColumnVisibility.shownByDefault) {
        traits.add(TraitsFilter(trait.name, true));
      } else if (trait.columnVisibility == ColumnVisibility.hiddenByDefault){
        traits.add(TraitsFilter(trait.name, false));
      } else {
        
      }
      });
    }
  });
  return traits;  
}

  double calcColSize(int size) {
    if (17.5 * size > 200.0) {
        return 200.0;
    } else {
      return 17.5 * size;
    }

  }

    
      @override
  void initState() {
    super.initState();
    // Get data from storage to app state.
    extractEnvironments();
    _traitsFilters = getTraits();
  }

    // Extracts all the environments for the dropdown.
    void extractEnvironments() {
      _dataSets.forEach((element) {
        _environments.add(element.name);
      });
      // Updated selected environment to be the first in the list
      _selectedEnvironment = _environments[0];
      _selectedDataSet = _dataSets[0];
    }

  @override
  Widget build(BuildContext context) {
    //final dataRepProvider = Provider.of<DataRepository>(context);
    
    
    return Scaffold(
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
                )),
                  // Create the dropdown based off the list of environments.
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: DropdownMenu<String>(
                        width: MediaQuery.of(context).size.width - 116.0,
                          initialSelection: _environments.first,
                          dropdownMenuEntries: _environments.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value, 
                              label: value 
                              );
                          }).toList(),
                          onSelected: (String? value) {
                            setState(() {
                              _selectedEnvironment = value!;
                              _traitsFilters = getTraits();
                              _tableVisible = false;
                            });
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
                          _filtersVisibile = true;
                        } else {
                          _showDataIcon = Icons.chevron_right;
                          _filtersVisibile = false;
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
                        Icon(_showDataIcon, size: 24, color:Color.fromARGB(255, 215, 64, 9)),
                      ],
                    ),
                    ),
                  SizedBox(
                    width: 120.0,
                    child: FloatingActionButton(
                      // TODO: Link to show data when show data is pressed
                      onPressed: () {
                        setState(() {
                          // Hide the traits filters, reset the button and make the table visible.
                          _filtersVisibile = false;
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
            visible: _filtersVisibile,
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
                      Container(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: _traitsFilters.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              value: _traitsFilters[index].isChecked, 
                              title: Text(_traitsFilters[index].traitName),
                              onChanged: (val) {
                                setState(() {
                                  _traitsFilters[index].isChecked = val!;
                                });
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

          // DATA Table Widget
          Flexible(
            child: Visibility(
              visible: _tableVisible,
              child: DataTable2(
                dataRowHeight: 80.0,
                minWidth: 3000.0,
                fixedLeftColumns: 1,
                fixedTopRows: 1,
                dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {return Colors.grey.withOpacity(0.3); }),
                columns: List<DataColumn2>.generate(_selectedDataSet!.traits.length, (index) => 
                  DataColumn2(
                    label: Text(_selectedDataSet!.traits[index].name,
                    style: Theme.of(context).textTheme.bodyLarge,
                    softWrap: true,
                    ),
                    fixedWidth: calcColSize(_selectedDataSet!.traits[index].name.length),
                  )
                ),
                rows: List<DataRow2>.generate(_selectedDataSet!.observations.length, (rowIndex) => DataRow2(
                  cells: List<DataCell>.generate(_selectedDataSet!.observations[rowIndex].traitOrdersAndValues.length, (cellIndex) => 
                    DataCell(
                      Text(
                        '${_selectedDataSet!.observations[rowIndex].traitOrdersAndValues[cellIndex + 1]}',
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


// Helper class for traits Filter
class TraitsFilter {
  TraitsFilter(
    this.traitName,
    [this.isChecked = false]
  );
  String traitName;
  bool isChecked;
}

