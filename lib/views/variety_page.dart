import 'package:flutter/material.dart';
import 'package:variety_testing_app/models/data_set.dart';


class VarietyPage extends StatefulWidget {
  @override
  State<VarietyPage> createState() => _VarietyPageState();
}

class _VarietyPageState extends State<VarietyPage> {
      // Pulls mock Data sets into page.
    List<DataSet> _dataSets = MockDataSet.mockData();
    List<String> _environments = [];
    String _selectedEnvironment = "";

    
      @override
  void initState() {
    super.initState();
    // Get data from storage to app state.
    extractEnvironments();
  }

    // Extracts all the environments for the dropdown.
    void extractEnvironments() {
      _dataSets.forEach((element) {
        _environments.add(element.name);
      });
      // Updated selected environment to be the first in the list
      _selectedEnvironment = _environments[0];
    }

  @override
  Widget build(BuildContext context) {
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
                        width: 300.0,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 80.0,
                    child: FloatingActionButton(
                      // TODO: Link to show data when dhow data is pressed
                      onPressed: null,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      child: const Text("Show Data", style: TextStyle(fontSize: 14.0),)
                      
                      ),
                  )
                ]),
            ),
          ),
        ],
      ),
    );
  }
}