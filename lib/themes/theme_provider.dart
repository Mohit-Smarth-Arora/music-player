import 'package:flutter/material.dart';
import 'package:mymusic/themes/DarkMode.dart';
import 'package:mymusic/themes/LightMode.dart';

class ThemeProvider extends ChangeNotifier {
  //initial theme set
  ThemeData _themeData = lightmode;

  //get theme
  ThemeData get themeData => _themeData;

  //is dark mode
  bool get isDarkMode => _themeData == darkmode;

  //set Theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    //update UI
    notifyListeners();
  }

  void ToggleTheme() {
    if (_themeData == lightmode) {
      themeData = darkmode;
    } else {
      themeData = lightmode;
    }
  }
}
