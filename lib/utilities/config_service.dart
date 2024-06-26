import 'dart:ui';

import 'package:flutter/material.dart';

class Configuration {
  Map<String, dynamic> configString;
  String indexUrl;
  Color primaryColor;
  Color dividerColor;
  List<String> pageTitles;
  String dataSummaryURL;
  String dataSummaryText;
  String dataTraitDescriptions;

  factory Configuration.fromMap(Map<String, dynamic> configString) {
    final indexUrl = configString['indexURL'] ?? "https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/index.csv";

    Color primaryColor = const Color(0xFFD73F09),
        dividerColor = const Color(0xFF8E8E8E);

    if (configString['primaryColor'] != null) {
      primaryColor = Color(
          int.parse(configString['primaryColor'], radix: 16) + 0xFF000000);
    }
    if (configString['dividerColor'] != null) {
      dividerColor = Color(
          int.parse(configString['dividerColor'], radix: 16) + 0xFF000000);
    }
    print(dividerColor);

    List<String> titles = [];
    titles.add(configString['varietyPageTitle'] ?? "Wheat and Barley Variety Data");
    titles.add(configString['aboutPageTitle'] ?? "Software Information");

    String dataSummaryURL = configString['dataSummaryURL'] ?? "https://cropandsoil.oregonstate.edu/wheat/osu-wheat-variety-trials";
    String dataSummaryText = configString['dataSummaryText'] ?? """Every year, the Oregon State University Cereal Extension Program conducts wheat and barley variety trials across the state.
                    These trials serve as the final testing ground for varieties developed by universities, the USDA, and private breeding breeding programs.\n\n
                    The data within this app is from the OSU cereal variety testing regional summaries and disease summaries, which are available online at:""";
    String dataTraitDescriptions = configString['dataTraitDescriptions'] ?? """Disease Resistance Scores:\nR - Resistant\nMR - Moderately Resistant\nI - Intermediate\nMS - Moderately Susceptible\n
                    S - Susceptible\n\nQuality Scores:\nMD - Most Desirable\nD - Desirable\nA - Acceptable\nLD - Least Desirable""";

    return Configuration(configString, indexUrl, primaryColor, dividerColor, titles, dataSummaryURL, dataSummaryText, dataTraitDescriptions);
  }

  Configuration(this.configString, this.indexUrl, this.primaryColor, this.dividerColor, this.pageTitles, this.dataSummaryURL, this.dataSummaryText, this.dataTraitDescriptions);
}
