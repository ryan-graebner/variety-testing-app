import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:variety_testing_app/utilities/ui_config.dart';
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
  Color _releasedToggleColor = UIConfig.dividerGrey;
  bool _filtersVisible = false;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _hScrollController = ScrollController();

  double calcColSize(int size) {
    if (20.0 * size > 170.0) {
      return 170.0;
    } else if (20.0 * size < 120){
      return 120.0;
    } else {
      return 20.0 * size;
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
            decoration: BoxDecoration(
              color: UIConfig.secondaryGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
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
                              context.read<AppState>().changeDataSet(value);
                              _filtersVisible = false;
                              _showDataIcon = Icons.chevron_right;
                            },
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // Handles changing the App icon and showing/hiding the filter panel
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
                              color: UIConfig.primaryOrange
                          ),
                        ),
                        Icon(_showDataIcon, size: 24, color: UIConfig.primaryOrange),
                      ],
                    ),
                  ),

                  // Visibility for Checkboxes.
                  Visibility(
                      visible: _filtersVisible,
                      child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Handles changing the App icon and showing/hiding the filter panel
                                setState(() {
                                  if (_releasedToggle == Icons.toggle_off) {
                                    _releasedToggle = Icons.toggle_on;
                                    _releasedToggleColor = UIConfig.primaryOrange;
                                    context.read<AppState>().toggleReleased();
                                  } else {
                                    _releasedToggle = Icons.toggle_off;
                                    _releasedToggleColor = UIConfig.dividerGrey;
                                    context.read<AppState>().toggleReleased();
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(_releasedToggle, size: 30, color: _releasedToggleColor),
                                  Text("Released Only",
                                    style: Theme.of(context).textTheme.bodyMedium
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).orientation == Orientation.landscape
                                  ? 100.0
                                  : 200.0,
                              child: ListView.builder(
                                  itemCount: context.watch<AppState>().currentTraits.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        context.read<AppState>().toggleCheckbox(index);
                                      },
                                      child: Row(
                                          children: [
                                            Checkbox(
                                                value: context.watch<AppState>().currentTraits[index].isChecked,
                                                onChanged: (bool? checked) {
                                                  context.read<AppState>().toggleCheckbox(index);
                                                },
                                              visualDensity: VisualDensity.compact,
                                            ),
                                            Expanded(
                                                child: Text(context.watch<AppState>().currentTraits[index].traitName)
                                            )
                                      ]),
                                    );
                                  }),
                            )
                          ]
                      )
                  )
                ],
              ),
            ),
          ),

          // TODO: Figure out a better way than all of the context.watch statements
          // DATA Table Widget
          ScrollConfiguration(
            behavior: const ScrollBehavior()
                .copyWith(physics: const ClampingScrollPhysics()),
            child:
            Flexible(
                child: Visibility(
                  visible: !context.watch<AppState>().isLoading,
                  child:
                  Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.green,
                        ),
                        child: DataTable2(
                            columnSpacing: 8,
                            fixedColumnsColor: Colors.grey.withOpacity(0.3),
                            horizontalMargin: 8,
                            fixedLeftColumns: 1,
                            fixedTopRows: 1,
                            minWidth: 3000,
                            scrollController: _scrollController,
                            horizontalScrollController: _hScrollController,
                            isVerticalScrollBarVisible: false,
                            isHorizontalScrollBarVisible: false,
                            headingRowDecoration: const BoxDecoration(border: Border(bottom: BorderSide(color: UIConfig.dividerGrey))),
                            dividerThickness: 1,
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.green))),
                            empty: const Text("Empty"),
                            dataRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) => UIConfig.secondaryGrey),
                            columns: List<DataColumn2>.generate(context.watch<AppState>().visibleDataSet.traits.length, (index) =>
                                DataColumn2(
                                  label: Center(
                                    child: Text(context.watch<AppState>().visibleDataSet.traits[index].name ?? "",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      softWrap: true,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  fixedWidth: calcColSize(context.watch<AppState>().visibleDataSet.traits[index].name.length ?? 0),
                                ),
                            ),
                            rows: List<DataRow2>.generate(context.watch<AppState>().visibleDataSet.observations.length, (rowIndex) =>
                                DataRow2(
                                  color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                    if (!rowIndex.isEven) {
                                      return UIConfig.secondaryGrey;
                                    }
                                    return null;
                                  }),
                                  cells: List<DataCell>.generate(context.watch<AppState>().visibleDataSet.observations[rowIndex].traitOrdersAndValues.length, (cellIndex) =>
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '${context.watch<AppState>().visibleDataSet.observations[rowIndex].traitOrdersAndValues[cellIndex] ?? ""}',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                      )
                                  ),
                                )
                            )
                        ),
                      )
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}