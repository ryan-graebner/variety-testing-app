import 'package:flutter/material.dart';

class UIConfig {
  static const primaryOrange = Color.fromARGB(255, 215, 63, 9);
  static const secondaryGrey = Color.fromARGB(255, 238, 238, 238);
  static const dividerGrey = Color(0xFF8E8E8E);

  static final appTheme = ThemeData(
    primaryColor: UIConfig.primaryOrange,
    dividerTheme: const DividerThemeData(color: dividerGrey),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: UIConfig.primaryOrange,
    ),
    textTheme: textTheme,
    useMaterial3: false,
  );

  static const textTheme = TextTheme(
    // Used for the APP BAR
      titleLarge: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'openSans',
          fontWeight: FontWeight.bold,
          fontSize: 20.0),
      // Used for the NAV BAR
      titleSmall: TextStyle(
        color: Color(0xFFFFFFFF),
        fontFamily: 'openSans',
        fontWeight: FontWeight.bold,
        fontSize: 12.0, ),
      bodyLarge: TextStyle(
          color: Color(0xFF000000),
          fontFamily: 'openSans',
          fontWeight: FontWeight.bold,
          fontSize: 14.0
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF000000),
        fontFamily: 'openSans',
        fontSize: 14.0,
      )
  );
}