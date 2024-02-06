import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class SoftwarePage extends StatelessWidget {
  const SoftwarePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // DATA source card and link to Crop and Soil homepage
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Data Source", style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("Every year, the Oregon State University Cereal Extension Program conducts wheat and barley variety trials across the state. These trials serve as the final testing ground for varieties developed by land grant universities, the USDA, and private breeding companies.\n "),
                      )
                    ],),
                    const Row(children: [
                      Flexible(
                        child: Text("The trials serve as a crucial resource to help farmers know which varieties will work best in their system, increasing the efficiency of agriculture in Oregon.\n"),                       
                        )
                    ],),
                    const Row(children: [
                      Flexible(
                        child: Text("The Data within this app is available online at:"),
                      )
                    ],),
                    // Inkwell and url_launcher added to make hyperlink clickable
                    Row(children: [
                      Flexible(
                        child: 
                        InkWell(
                          onTap: () => launchUrl(Uri.parse('https://cropandsoil.oregonstate.edu/wheat/osu-wheat-variety-trials')),
                          child: const Text(
                            "https://cropandsoil.oregonstate.edu/wheat/osu-wheat-variety-trials",
                            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                        )
                      )
                    ],)
                  ],
                ),
              ),
            ),
            // Publication Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Publication", style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("A Publication on this App may be coming Soon!"),
                      )
                    ],)
                  ],
                ),
              ),
            ),
            // Github Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Github Link" , style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("The source code for this application is available at the following link:\n"),
                      )
                    ],),
                    // Inkwell and url_launcher added to make hyperlink clickable
                    Row(children: [
                      Flexible(
                        child: 
                        InkWell(
                          onTap: () => launchUrl(Uri.parse('https://github.com/annalevel/variety-testing-app')),
                          child: const Text(
                            "OSU Mobile App for OSU Wheat and Barley Variety Testing",
                            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                        )
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
                    Text("Acknowledgment", style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("This app was produced as a Capstone Project for the Orgeon State School of Computer Science by the following team:\n"),
                      )
                    ],),
                    const Row(children: [
                      Flexible(
                        child: Text("Dr. Ryan Greabner - School of Agricultural Sciences"),
                      )
                    ],),
                    const Row(children: [
                      Flexible(
                        child: Text("Anna Level - Computer Science Student"),
                      )
                    ],),
                    const Row(children: [
                      Flexible(
                        child: Text("Andrew Wallace - Computer Science Student"),
                      )
                    ],),
                  ],
                ),
              ),
            ),
            // APP CITATION card - add updated ciation once publishing is solidifed
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("App Citation", style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("The citation for this app if you use it in your own work is below:\n"),
                      )
                    ],),
                    const Row(children: [
                      Flexible(
                        child: Text("Oregon State Univeristy. (2024) OSU Wheat and Barley Variety Testing (Version 1.0.0)[Mobile App]"),
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