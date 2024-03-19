import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/theme/app_theme_data.dart';

class AppTheme extends InheritedWidget {
  final AppThemeData data;

  const AppTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppTheme oldWidget) => data != oldWidget.data;

  static AppThemeData of(BuildContext context) {
    final AppTheme? result = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(result != null, 'No AppTheme found in context');
    return result!.data;
  }
}

