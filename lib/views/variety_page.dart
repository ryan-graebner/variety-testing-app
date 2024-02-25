import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:variety_testing_app/utilities/ui_config.dart';
import 'package:variety_testing_app/views/components/variety_data_table.dart';
import '../state/app_state.dart';
import 'components/environment_dropdown_view.dart';
import 'components/show_traits_button.dart';
import 'components/traits_filter_view.dart';
import 'error_view.dart';
import 'loading_view.dart';

class VarietyPage extends StatefulWidget {
  const VarietyPage({super.key});

  @override
  State<VarietyPage> createState() => _VarietyPageState();
}

class _VarietyPageState extends State<VarietyPage> {
  IconData _showDataIcon = Icons.chevron_right;
  bool _filtersVisible = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState state, Widget? child) {
        return state.error != null
            ? ErrorView(message: state.error!)
            : state.isLoading
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
                      EnvironmentDropdownView(
                        onSelected: (String? value) {
                          context.read<AppState>().changeDataSet(value);
                          _filtersVisible = false;
                          _showDataIcon = Icons.chevron_right;
                        },
                      ),

                      ShowTraitsButton(
                        icon: _showDataIcon,
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
                      ),

                      TraitsFilterView(isVisible: _filtersVisible,),
                    ],
                  ),
                ),
              ),

              // DATA Table Widget
              ScrollConfiguration(
                behavior: const ScrollBehavior()
                    .copyWith(physics: const ClampingScrollPhysics()),
                child:
                Flexible(
                    child: Visibility(
                      visible: !state.isLoading,
                      child:
                      const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: VarietyDataTable()
                      ),
                    )
                ),
              )
            ],
          ),
        );
      },
    );
  }
}