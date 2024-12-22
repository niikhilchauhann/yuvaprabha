import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  CounterProvider() {
    _loadCount();
  }

  void _loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    _count = prefs.getInt('counter') ?? 0;
    notifyListeners();
  }

  void increment() async {
    _count++;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', _count);
    notifyListeners();
  }
}
