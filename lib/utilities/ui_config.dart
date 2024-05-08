import 'package:flutter/material.dart';

class UIConfig {
  final Color primaryColor;
  final Color dividerColor;
  final ThemeData appTheme;
  final List<String> pageTitles;
  final String dataSummaryURL;
  final String dataSummaryText;
  final String dataTraitDescriptions;

  UIConfig(this.primaryColor, this.dividerColor, this.pageTitles, this.dataSummaryURL, this.dataSummaryText, this.dataTraitDescriptions)
      : appTheme = ThemeData(
    primaryColor: primaryColor,
    dividerTheme: DividerThemeData(color: dividerColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColor,
    ),
    textTheme: TextTheme(
      // Used for the APP BAR
        titleLarge: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: 'openSans',
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
        // Used for the NAV BAR
        titleSmall: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'openSans',
          fontWeight: FontWeight.bold,
          fontSize: 12.0, 
        ),
        //Used for column names
        bodyLarge: const TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'openSans',
            fontWeight: FontWeight.bold,
            fontSize: 14.0
        ),
        //Used for table cells
        bodyMedium: const TextStyle(
          color: Color(0xFF000000),
          fontFamily: 'openSans',
          fontSize: 14.0,
        )
    ),
    useMaterial3: false,
  );
}
