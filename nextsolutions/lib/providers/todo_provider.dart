import 'package:flutter/material.dart';
import 'package:nextsolutions/models/task_model.dart';

// Without save feature
class ToDoProvider extends ChangeNotifier {
  List<ToDoModel> _tasks = [];

  List<ToDoModel> get tasks => _tasks;

  void addTask(ToDoModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.completed = !task.completed;
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}
