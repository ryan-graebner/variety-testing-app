import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(message),
          MaterialButton(
            onPressed: () {
              context.read<AppState>().error = null;
              context.read<AppState>().isLoading = true;
              context.read<AppState>().retryDataLoad();
            },
            child: const Text("Try Again"),
          )
        ],
      ),
    );
  }
}
