import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../utilities/ui_config.dart';

class TraitsFilterView extends StatefulWidget {
  const TraitsFilterView({super.key, required this.isVisible});
  final bool isVisible;

  @override
  State<TraitsFilterView> createState() => _TraitsFilterViewState();
}

class _TraitsFilterViewState extends State<TraitsFilterView> {
  IconData _releasedToggle = Icons.toggle_off;
  Color _releasedToggleColor = UIConfig.dividerGrey;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.isVisible,
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
                child: Consumer<AppState>(
                  builder: (BuildContext context, AppState state, Widget? child) {
                    return ListView.builder(
                        itemCount: state.currentTraits.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.read<AppState>().toggleCheckbox(index);
                            },
                            child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: UIConfig.primaryOrange,
                                    value: state.currentTraits[index].isChecked,
                                    onChanged: (bool? checked) {
                                      context.read<AppState>().toggleCheckbox(
                                          index);
                                    },
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  Expanded(
                                      child: Text(
                                          state.currentTraits[index].traitName)
                                  )
                                ]),
                          );
                        }
                    );
                  }
                ),
              )
            ]
        )
    );
  }
}
