import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  void changeTheme() {
    isDarkTheme != isDarkTheme;
    notifyListeners();
  }
}
