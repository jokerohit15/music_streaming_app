import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';

class AppThemeData {
  final Color primaryColor;
  final TextStyle displayLargeTextStyle;
  final TextStyle bodyMediumTextStyle;
  final TextStyle buttonLarge; // Example of an additional text style
  final Brightness brightness;
  final String fontFamily;
  final TextStyle titleLargeTextStyle;
  final TextStyle titleMediumTextStyle;
  final Color primaryColorLight;
  final Color primaryColorDark;
  final InputDecorationTheme   inputDecorationTheme;

  AppThemeData( {
    required this.primaryColor,
    required this.primaryColorLight,
    required this.primaryColorDark,
    required this.displayLargeTextStyle,
    required this.bodyMediumTextStyle,
    required this.buttonLarge, // Initialize in constructors
    required this.brightness,
    required this.fontFamily,
    required this.titleLargeTextStyle,
    required this.titleMediumTextStyle,
    required this.inputDecorationTheme,
  });

  factory AppThemeData.lightTheme() {
    return AppThemeData(
      primaryColor: AppColors.secondaryColor,
      primaryColorLight: AppColors.whiteColor,
      primaryColorDark: AppColors.blackColor,
      displayLargeTextStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyMediumTextStyle: const TextStyle(fontSize: 14, color: Colors.black),
      titleLargeTextStyle: const TextStyle(
          fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
      titleMediumTextStyle: const TextStyle(
          fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
      buttonLarge: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
      brightness: Brightness.light,
      fontFamily: 'Louis George Cafe',
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blackColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.secondaryColor.withOpacity(0.5)),
        ),
        disabledBorder: InputBorder.none,
        outlineBorder:  BorderSide(color: AppColors.secondaryColor.withOpacity(0.5)),
      ),
    );
  }

  factory AppThemeData.darkTheme() {
    return AppThemeData(
      primaryColor: AppColors.brandColor,
      primaryColorLight: AppColors.blackColor,
      primaryColorDark: AppColors.whiteColor,
      displayLargeTextStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMediumTextStyle: const TextStyle(fontSize: 14, color: Colors.white),
      titleLargeTextStyle: const TextStyle(
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      titleMediumTextStyle: const TextStyle(
          fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
      buttonLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.lightBlueAccent),
      brightness: Brightness.dark,
      fontFamily: 'Louis George Cafe',
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.brandColor),
        ),
        disabledBorder: InputBorder.none,
        outlineBorder: const BorderSide(color: AppColors.brandColor),
      ),
    );
  }
}
