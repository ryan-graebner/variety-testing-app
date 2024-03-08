import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:variety_testing_app/utilities/ui_config.dart';
import 'package:variety_testing_app/views/variety_page.dart';
import 'package:variety_testing_app/views/about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Navigation Var
  int currentPageIndex = 0;

  final List<Widget> _pages = [
    const VarietyPage(),
    const AboutPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Don't show Top Bar in Landscape.
      appBar: 
      MediaQuery.of(context).orientation == Orientation.landscape 
        ? null
        : AppBar(
        backgroundColor: context.read<UIConfig>().primaryColor,
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        title: Text(context.read<UIConfig>().pageTitles[currentPageIndex]),
        centerTitle: true,
      ),
      // Body is shifted between pages based on bottom pressed button
      body: _pages[currentPageIndex],
      // Bottom Nav bar with 2 icons.
      // Don't show Nav bar in landscape
      bottomNavigationBar: 
      MediaQuery.of(context).orientation == Orientation.landscape 
        ? null
        : BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics, size: 30),
              label: "Overview "),
            BottomNavigationBarItem(
              icon: Icon(Icons.dvr, size: 30),
              label: "About",),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation: 5.0,
          currentIndex: currentPageIndex,
          selectedLabelStyle: Theme.of(context).textTheme.titleSmall,
          unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
          backgroundColor: Colors.black,
          // On tap updates the state to the new currentPageIndex on tap.
          onTap: (index){
            setState(() {
              currentPageIndex = index;
            });
          },
        )
    );
  }
}
