import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:variety_testing_app/state/app_state.dart';
import 'package:variety_testing_app/views/variety_testing_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: const VarietyTestingApp()
    )
  );
}
