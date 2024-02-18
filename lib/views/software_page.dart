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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Data Source", style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("Every year, the Oregon State University Cereal Extension Program conducts wheat and barley variety trials across the state. These trials serve as the final testing ground for varieties developed by universities, the USDA, and private breeding breeding programs.\n "),
                      )
                    ],),
                    const Row(children: [
                      Flexible(
                        child: Text("The data within this app is from the OSU cereal variety testing regional summaries and disease summaries, which are available online at:"),
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
            // Github Card
            //TODO: Add Public Repository with stripped down Data
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Acknowledgment", style: Theme.of(context).textTheme.bodyLarge,),
                    const Row(children: [
                      Flexible(
                        child: Text("This app was produced by Anna Level and Andrew Wallace as a Capstone Project at Oregon State University. This project was mentored by Dr. Ryan Graebner.\n"),
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