import 'package:flutter/material.dart';
import 'package:variety_testing_app/views/variety_page.dart';
import 'package:variety_testing_app/views/software_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});
  

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Navigation Var
  int currentPageIndex = 0;
  

  final List<String> _titles = [
    "Wheat and Barley Variety Data",
    "Software Information"
  ];

  final List<Widget> _pages = [
    const VarietyPage(),
    const SoftwarePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Add White Color to overall style
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        title: Text(_titles[currentPageIndex]),
        centerTitle: true,
      ),
      // Body is shifted between pages based on bottom pressed button
      body: _pages[currentPageIndex],
      // Bottom Nav bar with 3 icons.
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics, size: 30),
              label: "Overview "),
            BottomNavigationBarItem(
              icon: Icon(Icons.dvr, size: 30),
              label: 'Software',),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
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
