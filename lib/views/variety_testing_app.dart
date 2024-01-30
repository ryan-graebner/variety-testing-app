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
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(title: 'Flutter Demo Home Page'),
        ),
    );
  }
}