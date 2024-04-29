import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:variety_testing_app/state/app_state.dart';
import 'package:variety_testing_app/utilities/ui_config.dart';
import 'package:variety_testing_app/views/variety_testing_app.dart';
import 'package:variety_testing_app/utilities//config_service.dart';
import 'package:flutter/services.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final configString = await rootBundle.loadString('config/config.json');
  final Map<String, dynamic> config = await jsonDecode(configString);
  final Configuration finalConfig = Configuration.fromMap(config);

  runApp(
    MultiProvider(
        providers: [
          Provider<UIConfig>(
            create: (context) => UIConfig(
                finalConfig.primaryColor,
                finalConfig.secondaryColor,
                finalConfig.dividerColor,
                finalConfig.pageTitles,
                finalConfig.dataSummaryURL,
                finalConfig.dataSummaryText
            )
          ),
          ChangeNotifierProvider<AppState>(
              create: (context) => AppState(finalConfig.indexUrl)
          )
        ],
        child: const VarietyTestingApp()
    )
  );
}
