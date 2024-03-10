import 'package:flutter/material.dart';

class UIConfig {
  final Color primaryColor;
  final Color secondaryColor;
  final Color dividerColor;
  final Color fixedColumnColor;
  final Color appBarTextColor;
  final ThemeData appTheme;
  final List<String> pageTitles;
  final String dataSummaryURL;
  final String dataSummaryText;

  UIConfig(this.primaryColor, this.secondaryColor, this.dividerColor, this.fixedColumnColor, this.appBarTextColor, this.pageTitles, this.dataSummaryURL, this.dataSummaryText)
      : appTheme = ThemeData(
    primaryColor: primaryColor,
    dividerTheme: DividerThemeData(color: dividerColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColor,
    ),
    textTheme: TextTheme(
      // Used for the APP BAR
        titleLarge: TextStyle(
            color: appBarTextColor,
            fontFamily: 'openSans',
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
        // Used for the NAV BAR
        titleSmall: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'openSans',
          fontWeight: FontWeight.bold,
          fontSize: 12.0, ),
        bodyLarge: const TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'openSans',
            fontWeight: FontWeight.bold,
            fontSize: 14.0
        ),
        bodyMedium: const TextStyle(
          color: Color(0xFF000000),
          fontFamily: 'openSans',
          fontSize: 14.0,
        )
    ),
    useMaterial3: false,
  );
}