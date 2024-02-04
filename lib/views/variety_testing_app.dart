import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:variety_testing_app/state/data_repository.dart';
import 'package:variety_testing_app/state/database_service.dart';
import 'home_page.dart';

class VarietyTestingApp extends StatelessWidget {
  const VarietyTestingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => DatabaseService()),
          ProxyProvider<DatabaseService, DataRepository>(
            update: (context, db, previousRepo) => DataRepository(db),
          ),
        ],
        child: MaterialApp(
          title: 'Variety Testing Data',
          theme: ThemeData(
            // Added OSU Orange as the Primary Color Scheme of the App
            colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 215, 64, 9)),
            textTheme: const TextTheme(
              // Used for the APP BAR
              titleLarge: TextStyle(
                color: Color(0xFFFFFFFF), 
                fontFamily: 'openSans', 
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
              // Used for the NAV BAR
              titleSmall: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'openSans',
                fontWeight: FontWeight.bold,
                fontSize: 14.0, ),
              bodyLarge: TextStyle(
                color: Color(0xFF000000),
                fontFamily: 'openSans',
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF000000),
                fontFamily: 'openSans',
                fontSize: 14,
              ) 
              
              ),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
    );
  }
}
