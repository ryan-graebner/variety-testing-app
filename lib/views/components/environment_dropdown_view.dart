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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Environment",
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'openSans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(width: 8.0),
              // Create the dropdown based off the list of environments
              Expanded(
                child: DropdownMenu<String>(
                  menuStyle: MenuStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>((
                        Set<MaterialState> states) => Colors.white,),
                    visualDensity: VisualDensity.compact,
                  ),
                  initialSelection: state.dropdownValues.firstWhere((name) => name == state.currentDataSetName),
                  inputDecorationTheme: const InputDecorationTheme(
                    constraints: BoxConstraints(maxHeight: 40.0),
                    contentPadding: EdgeInsets.only(left: 8.0),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                  ),
                  expandedInsets: EdgeInsets.zero,
                  dropdownMenuEntries: state.dropdownValues.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                        labelWidget: Text(value, softWrap: true, overflow: TextOverflow.ellipsis,)
                    );
                  }).toList(),
                  onSelected: onSelected,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          );
        }
    );
  }
}
