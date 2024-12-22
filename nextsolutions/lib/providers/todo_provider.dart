import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nextsolutions/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Without save feature
// class ToDoProvider extends ChangeNotifier {
//   List<ToDoModel> _tasks = [];

//   List<ToDoModel> get tasks => _tasks;

//   void addTask(ToDoModel task) {
//     _tasks.add(task);
//     notifyListeners();
//   }

//   void toggleTaskCompletion(String taskId) {
//     final task = _tasks.firstWhere((task) => task.id == taskId);
//     task.completed = !task.completed;
//     notifyListeners();
//   }

//   void deleteTask(String taskId) {
//     _tasks.removeWhere((task) => task.id == taskId);
//     notifyListeners();
//   }
// }

class ToDoProvider extends ChangeNotifier {
  List<ToDoModel> _tasks = [];

  List<ToDoModel> get tasks => _tasks;

  ToDoProvider() {
    _loadTasks();
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> decodedTasks = json.decode(tasksJson);
      _tasks = decodedTasks.map((task) => ToDoModel.fromJson(task)).toList();
      notifyListeners();
    }
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksJson =
        json.encode(_tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', tasksJson);
  }

  void addTask(ToDoModel task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.completed = !task.completed;
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    _saveTasks();
    notifyListeners();
  }
}
