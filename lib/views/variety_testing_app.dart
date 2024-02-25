import 'package:flutter/material.dart';
import 'package:variety_testing_app/utilities/ui_config.dart';
import 'home_page.dart';

class VarietyTestingApp extends StatelessWidget {
  const VarietyTestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Variety Testing Data',
      theme: UIConfig.appTheme,
      home: const HomePage(),
    );
  }
}
