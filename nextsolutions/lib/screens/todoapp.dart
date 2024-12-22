import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nextsolutions/providers/theme_provider.dart';
import 'package:nextsolutions/screens/add_todo.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/todo_provider.dart';
import '../widgets/constants.dart';
import '../widgets/todo_widget.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool isDark = context.watch<ThemeProvider>().isDarkTheme;
    Color backgroundColor = isDark ? Color(0xff121212) : Colors.white;

    Color text = !isDark ? Color(0xFF262626) : const Color(0xE0FFFFFF);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('To Do App'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => NewToDoScreen(),
              )); // Navigate to New Task screen
        },
      ),
      body: Consumer<ToDoProvider>(
        builder: (context, toDoProvider, child) {
          List<ToDoModel> todolist = toDoProvider.tasks;
          return todolist.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.all(16),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todolist.length,
                  itemBuilder: (context, index) {
                    return TaskItemView(taskModel: todolist[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: const Divider(
                        color: kGrey1,
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/tasks.svg',
                        height: size.height * .20,
                        width: size.width,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      buildText(
                          'Schedule your tasks',
                          text,
                          30,
                          FontWeight.w600,
                          TextAlign.center,
                          TextOverflow.clip,
                          TextDecoration.none),
                      buildText(
                          'Manage your daily tasks with ease.',
                          text.withOpacity(.5),
                          14,
                          FontWeight.normal,
                          TextAlign.center,
                          TextOverflow.clip,
                          TextDecoration.none),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
