


import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/theme/app_theme_data.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  AppThemeData get currentThemeData => _isDarkMode ? AppThemeData.darkTheme() : AppThemeData.lightTheme();


  ThemeData get currentTheme => ThemeData(
    primaryColor: currentThemeData.primaryColor,
    primaryColorLight: currentThemeData.primaryColorLight,
    primaryColorDark:currentThemeData.primaryColorDark,
    brightness: currentThemeData.brightness,
    fontFamily: currentThemeData.fontFamily,
    package: currentThemeData.package,
    textTheme: TextTheme(
      displayLarge: currentThemeData.displayLargeTextStyle,
      bodyMedium: currentThemeData.bodyMediumTextStyle,
      titleLarge: currentThemeData.titleLargeTextStyle,
      titleMedium: currentThemeData.titleMediumTextStyle,
    ),
  );


  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
