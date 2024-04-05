

import 'package:music_streaming_app/core/app_constants/app_keys.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageSource{

  bool? isDarkTheme();
  void  saveTheme(bool isDark);
}


class LocalStorageSourceImpl extends LocalStorageSource{

  final SharedPreferences sharedPreferences;

  LocalStorageSourceImpl( this.sharedPreferences);

  @override
  bool? isDarkTheme() {
    return sharedPreferences.getBool(AppKeys.themeKey);
  }

  @override
  void saveTheme(bool isDark)  {
    sharedPreferences.setBool(AppKeys.themeKey, isDark);
  }

}