import 'package:flutter/material.dart';


class SoftwarePage extends StatelessWidget {
  const SoftwarePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            // Acknowledgment
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Data Source"),
                    Row(children: [
                      Flexible(
                        child: Text("""Dummy Text"""),
                      )
                    ],)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Publication"),
                    Row(children: [
                      Flexible(
                        child: Text("""Dummy Text"""),
                      )
                    ],)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Github Link"),
                    Row(children: [
                      Flexible(
                        child: Text("""Dummy Text"""),
                      )
                    ],)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Acknowledgment"),
                    Row(children: [
                      Flexible(
                        child: Text("""Dummy Text"""),
                      )
                    ],)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("App Citation"),
                    Row(children: [
                      Flexible(
                        child: Text("""Dummy Text"""),
                      )
                    ],)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}