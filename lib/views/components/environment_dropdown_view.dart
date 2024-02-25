import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class EnvironmentDropdownView extends StatelessWidget {
  const EnvironmentDropdownView({super.key, required this.onSelected});
  final Function(String?) onSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
        builder: (BuildContext context, AppState state, Widget? child) {
          return Row(
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
                    initialSelection: state.dropdownValues.firstOrNull,
                    dropdownMenuEntries: state.dropdownValues.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value,
                          label: value
                      );
                    }).toList(),
                    onSelected: onSelected,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
