import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'loading_view.dart';


class VarietyPage extends StatefulWidget {
  const VarietyPage({super.key});

  @override
  State<VarietyPage> createState() => _VarietyPageState();
}

class _VarietyPageState extends State<VarietyPage> {

  @override
  Widget build(BuildContext context) {
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
                              width: 300.0,
                                initialSelection: context.watch<AppState>().dropdownValues.first,
                                dropdownMenuEntries: context.watch<AppState>().dropdownValues.map<DropdownMenuEntry<String>>((String value) {
                                  return DropdownMenuEntry<String>(
                                    value: value,
                                    label: value
                                    );
                                }).toList(),
                                onSelected: (String? value) => context.read<AppState>().changeDataSet(value),
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
                        SizedBox(
                          width: 80.0,
                          child: FloatingActionButton(
                            // TODO: Link to show data when show data is pressed
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

                // TODO: the data table
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Your currently selected environment is: ${context.watch<AppState>().currentDataSet?.name ?? "None"}"),
                      Text("Your currently selected traits are: ${context.watch<AppState>().currentTraits.map( (t) => t.name )}"),
                    ]
                  ),
                ),
              ],
            ),
          );
  }
}