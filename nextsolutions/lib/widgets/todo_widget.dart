import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nextsolutions/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/todo_provider.dart';
import 'constants.dart';

class TaskItemView extends StatefulWidget {
  final ToDoModel taskModel;
  const TaskItemView({super.key, required this.taskModel});

  @override
  State<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends State<TaskItemView> {
  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDarkTheme;
    Color backgroundColor = isDark ? Color(0xFF262626) : Colors.white;
    Color text = !isDark ? Color(0xFF262626) : const Color(0xE0FFFFFF);
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(2, 2))
            ],
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: widget.taskModel.completed,
                onChanged: (value) {
                  var taskModel = ToDoModel(
                    id: widget.taskModel.id,
                    title: widget.taskModel.title,
                    description: widget.taskModel.description,
                    completed: !widget.taskModel.completed,
                  );
                  context
                      .read<ToDoProvider>()
                      .toggleTaskCompletion(taskModel.id);
                }),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  buildText(
                      widget.taskModel.title,
                      text,
                      14,
                      FontWeight.w500,
                      TextAlign.start,
                      TextOverflow.clip,
                      widget.taskModel.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                  const SizedBox(
                    height: 5,
                  ),
                  buildText(
                      widget.taskModel.description,
                      isDark ? const Color(0xC3FFFFFF) : Colors.black54,
                      12,
                      FontWeight.normal,
                      TextAlign.start,
                      TextOverflow.clip,
                      widget.taskModel.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  context.read<ToDoProvider>().deleteTask(widget.taskModel.id);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/delete.svg',
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    buildText(
                        'Delete',
                        isDark ? const Color(0xC3FFFFFF) : kRed,
                        14,
                        FontWeight.normal,
                        TextAlign.start,
                        TextOverflow.clip,
                        TextDecoration.none)
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ));
  }
}
