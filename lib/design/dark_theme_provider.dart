import 'package:flutter/material.dart';
import 'package:the_ranch_app/design/shared_preff_theme.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = true;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
