


import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/theme/app_theme_data.dart';
import 'package:music_streaming_app/domain/use_cases/get_theme.dart';
import 'package:music_streaming_app/domain/use_cases/save_theme.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _isDarkMode;
  final GetTheme getTheme;
  final SaveTheme saveTheme;

  ThemeProvider(this.getTheme, this.saveTheme);



  void assignTheme(BuildContext context)  {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    _isDarkMode =  getTheme() ?? isDarkMode;
  }

  bool get isDarkMode => _isDarkMode;

  AppThemeData get currentThemeData => _isDarkMode ? AppThemeData.darkTheme() : AppThemeData.lightTheme();


  ThemeData get currentTheme => ThemeData(
    primaryColor: currentThemeData.primaryColor,
    primaryColorLight: currentThemeData.primaryColorLight,
    primaryColorDark:currentThemeData.primaryColorDark,
    brightness: currentThemeData.brightness,
    fontFamily: currentThemeData.fontFamily,
    inputDecorationTheme: currentThemeData.inputDecorationTheme,
    textTheme: TextTheme(
      displayLarge: currentThemeData.displayLargeTextStyle,
      bodyMedium: currentThemeData.bodyMediumTextStyle,
      titleLarge: currentThemeData.titleLargeTextStyle,
      titleMedium: currentThemeData.titleMediumTextStyle,
    ),
  );


  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    saveTheme(_isDarkMode);
    notifyListeners();
  }
}
