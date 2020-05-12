import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'OpenSans-Semibold',
  primaryColor: Colors.cyan[900],

);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
//  scaffoldBackgroundColor: Colors.black,
    fontFamily: 'OpenSans-Semibold'
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme(param) {
    if (param == 1) {
      _darkTheme = true;
    } else if (param == 2) {
      _darkTheme = false;
    }
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
