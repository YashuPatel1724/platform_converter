import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalTheme {
  static final ThemeData themeDark = ThemeData(
    tabBarTheme: const TabBarTheme(
      dividerColor: Colors.grey,
      indicatorColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    datePickerTheme: const DatePickerThemeData(),
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onSurface: Colors.white,
    ),
  );

  static final ThemeData themeLight = ThemeData(
    tabBarTheme: const TabBarTheme(
      dividerColor: Colors.grey,
      indicatorColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    datePickerTheme: const DatePickerThemeData(),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onSurface: Colors.black,
    ),
  );

  static const  CupertinoThemeData cupertinoThemeDark = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.white,
  );
  static const CupertinoThemeData cupertinoThemeLight =
      CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.black,
  );
}
