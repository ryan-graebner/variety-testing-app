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
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.isVisible,
        child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                      context.read<AppState>().toggleReleased();
                  });
                },
                child: Row(
                  children: [
                    Icon(context.read<AppState>().releasedToggle ? Icons.toggle_on : Icons.toggle_off, size: 30, color: context.read<AppState>().releasedToggle ? context.read<UIConfig>().primaryColor : context.read<UIConfig>().dividerColor),
                    Text("Released Only",
                        style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).orientation == Orientation.landscape
                    ? 110.0
                    : 220.0,
                child: Consumer2<AppState, UIConfig>(
                  builder: (BuildContext context, AppState state, UIConfig uiConfig, Widget? child) {
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
                                    activeColor: uiConfig.primaryColor,
                                    value: state.currentTraits[index].isChecked,
                                    onChanged: (bool? checked) {
                                      state.toggleCheckbox(index);
                                    },
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  Expanded(
                                      child: Text(state.currentTraits[index].traitName)
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
