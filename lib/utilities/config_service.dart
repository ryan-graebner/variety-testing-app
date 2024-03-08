import 'dart:ui';

import 'package:flutter/material.dart';

class Configuration {
  Map<String, dynamic> configString;
  String indexUrl;
  Color primaryColor;
  Color secondaryColor;
  Color dividerColor;
  Color fixedColumnColor;
  Color appBarTextColor;
  List<String> pageTitles;
  String dataSummaryURL;
  String dataSummaryText;

  factory Configuration.fromMap(Map<String, dynamic> configString) {
    final indexUrl = configString['indexURL'] ?? "https://cropandsoil.oregonstate.edu/sites/agscid7/files/cbarc/variety-testing/index.csv";

    Color primaryColor = const Color(0xFFD73F09),
        secondaryColor = const Color(0xFFEEEEEE),
        dividerColor = const Color(0xFF8E8E8E),
        fixedColumnColor = Colors.grey.withOpacity(0.3),
        appBarTextColor = const Color(0xFFFFFFFF);

    if (configString['primaryColor'] != null) {
      primaryColor = Color(
          int.parse(configString['primaryColor'], radix: 16) + 0xFF000000);
    }
    if (configString['secondaryColor'] != null) {
      secondaryColor = Color(
          int.parse(configString['secondaryColor'], radix: 16) + 0xFF000000);
    }
    if (configString['dividerColor'] != null) {
      dividerColor = Color(
          int.parse(configString['dividerColor'], radix: 16) + 0xFF000000);
    }
    if (configString['fixedColumnColor'] != null) {
      fixedColumnColor = Color(
      int.parse(configString['fixedColumnColor'], radix: 16) + 0xFF000000);
    }
    if (configString['appBarTextColor'] != null) {
      appBarTextColor = Color(
          int.parse(configString['appBarTextColor'], radix: 16) + 0xFF000000);
    }
    print(dividerColor);

    List<String> titles = [];
    titles.add(configString['varietyPageTitle'] ?? "Wheat and Barley Variety Data");
    titles.add(configString['aboutPageTitle'] ?? "Software Information");

    String dataSummaryURL = configString['dataSummaryURL'] ?? "https://cropandsoil.oregonstate.edu/wheat/osu-wheat-variety-trials";
    String dataSummaryText = configString['dataSummaryText'] ?? """Every year, the Oregon State University Cereal Extension Program conducts wheat and barley variety trials across the state.
                    These trials serve as the final testing ground for varieties developed by universities, the USDA, and private breeding breeding programs.\n\n
                    The data within this app is from the OSU cereal variety testing regional summaries and disease summaries, which are available online at:""";

    return Configuration(configString, indexUrl, primaryColor, secondaryColor, dividerColor, fixedColumnColor, appBarTextColor, titles, dataSummaryURL, dataSummaryText);
  }

  Configuration(this.configString, this.indexUrl, this.primaryColor, this.secondaryColor, this.dividerColor, this.fixedColumnColor, this.appBarTextColor, this.pageTitles, this.dataSummaryURL, this.dataSummaryText);
}
