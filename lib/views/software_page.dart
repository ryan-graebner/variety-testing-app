import 'package:flutter/material.dart';


class SoftwarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            // Ackoledgment
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