import 'package:flutter/material.dart';
import 'shared_preference.dart';

class ThemeManager extends ChangeNotifier {
  ThemeManager._internal();
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;

  ThemeMode get themeMode => ThemeMode.light;

  bool get isDarkMode => false;

  Future<void> init() async {
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    await SharedPreferencesHelper.setDarkMode(false);
    notifyListeners();
  }
}
