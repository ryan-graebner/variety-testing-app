import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../state/app_state.dart';
import '../utilities/ui_config.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [

            // Dataset Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("${context.read<AppState>().dataRepository.dataYear} Trial Data", style: Theme.of(context).textTheme.bodyLarge),
                    Text("Last updated: ${context.read<AppState>().dataRepository.lastUpdated}", style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
              ),
            ),
            
            // Trait Descriptions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Trait Descriptions", style: Theme.of(context).textTheme.bodyLarge,),
                    Text(context.read<UIConfig>().dataTraitDescriptions, textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
            
            // DATA source card and link to OSU Variety Testing Homepage
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Data Source", style: Theme.of(context).textTheme.bodyLarge,),
                    Text(context.read<UIConfig>().dataSummaryText),
                    // Inkwell and url_launcher added to make hyperlink clickable
                    Row(children: [
                      Flexible(
                        child: 
                        InkWell(
                          onTap: () => launchUrl(Uri.parse(context.read<UIConfig>().dataSummaryURL)),
                          child: Text(
                            context.read<UIConfig>().dataSummaryURL,
                            style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                        )
                      )
                    ],)
                  ],
                ),
              ),
            ),
            
            // Github Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                          onTap: () => launchUrl(Uri.parse('https://github.com/ryan-graebner/variety-testing-app/')),
                          child: const Text(
                            "Mobile App for Wheat and Barley Variety Testing",
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Acknowledgment", style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("This app was produced by Anna Level and Andrew Wallace for a Capstone Project at Oregon State University. This project was mentored by Dr. Ryan Graebner.\n"),
                      )
                    ],),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
