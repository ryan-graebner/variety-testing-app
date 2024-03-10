import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../utilities/ui_config.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(message),
            MaterialButton(
              onPressed: context.read<AppState>().retryDataLoad,
              child: Text("Try Again",
                style: TextStyle(
                    color: context.read<UIConfig>().primaryColor,
                    fontFamily: 'openSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
