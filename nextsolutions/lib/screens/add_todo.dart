import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextsolutions/models/task_model.dart';
import 'package:nextsolutions/providers/theme_provider.dart';
import 'package:nextsolutions/providers/todo_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/constants.dart';

class NewToDoScreen extends StatefulWidget {
  const NewToDoScreen({super.key});

  @override
  State<NewToDoScreen> createState() => _NewToDoScreenState();
}

class _NewToDoScreenState extends State<NewToDoScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDarkTheme;
    Color backgroundColor = isDark ? Color(0xff121212) : Colors.white;

    Color text = !isDark ? Color(0xFF262626) : const Color(0xE0FFFFFF);

    Color cardColor = isDark ? Color(0xFF262626) : Colors.white;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('Create a New ToDo'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<ToDoProvider>(
              builder: (context, toDoProvider, state) {
                return ListView(
                  children: [
                    const SizedBox(height: 20),
                    buildText(
                        'Title',
                        text,
                        14,
                        FontWeight.bold,
                        TextAlign.start,
                        TextOverflow.clip,
                        TextDecoration.none),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextField(
                        hint: "Task Title",
                        controller: title,
                        inputType: TextInputType.text,
                        fillColor: cardColor,
                        onChange: (value) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    buildText(
                        'Description',
                        text,
                        14,
                        FontWeight.bold,
                        TextAlign.start,
                        TextOverflow.clip,
                        TextDecoration.none),
                    const SizedBox(height: 10),
                    BuildTextField(
                        hint: "Task Description",
                        controller: description,
                        inputType: TextInputType.multiline,
                        fillColor: cardColor,
                        onChange: (value) {}),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor:
                                    WidgetStateProperty.all<Color>(kWhiteColor),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: buildText(
                                    'Cancel',
                                    kBlackColor,
                                    14,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip,
                                    TextDecoration.none),
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    kPrimaryColor),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                final String taskId = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                var taskModel = ToDoModel(
                                  id: taskId,
                                  title: title.text,
                                  description: description.text,
                                );
                                context.read<ToDoProvider>().addTask(taskModel);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: buildText(
                                    'Save',
                                    kWhiteColor,
                                    14,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip,
                                    TextDecoration.none),
                              )),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
