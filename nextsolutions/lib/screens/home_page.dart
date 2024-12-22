import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextsolutions/providers/counter_provider.dart';
import 'package:nextsolutions/providers/theme_provider.dart';
import 'package:nextsolutions/screens/todoapp.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int findLargestNum(List nums) {
    int max = -999999999;
    for (var i = 0; i < nums.length; i++) {
      if (nums[i] > max) {
        max = nums[i];
      }
    }
    return max;
  }

  final numList = [1, -27, 984, 9, 24, 645, -5, 12];
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDarkTheme;
    Color backgroundColor = isDark ? Color(0xff121212) : Colors.white;

    Color text = !isDark ? Color(0xFF262626) : const Color(0xE0FFFFFF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Coding Questions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Hello HR, here's the asssignment:",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600, color: text),
            ),
          ),
          QuestionHeaderWidget(
            title: 'Question 1',
            subtitle:
                'Write a Flutter widget to display a button that increments a counter.',
          ),
          AnswerBlock(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Count: ${context.watch<CounterProvider>().count}',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: text),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      iconColor: WidgetStateProperty.all(Colors.white),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.deepPurple)),
                  icon: Icon(Icons.add),
                  onPressed: () {
                    context.read<CounterProvider>().increment();
                  },
                  label: Text('Increment'),
                ),
              ],
            ),
          ),
          QuestionHeaderWidget(
            title: 'Question 2',
            subtitle:
                'Write a function in Dart to find the largest number in a list.',
          ),
          AnswerBlock(
            child: Center(
              child: Text(
                'Largest Number in list:\n$numList is ${findLargestNum(numList)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: text),
              ),
            ),
          ),
          QuestionHeaderWidget(
            title: 'Question 3',
            subtitle:
                'Create a custom widget that displays an image with a title and description below it.',
          ),
          AnswerBlock(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Image.asset(
                        'assets/placeholder.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Lorem Ipsum Title Text',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, color: text),
                ),
                SizedBox(height: 4),
                Text(
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas facere quo nemo, facilis commodi nihil vero asperiores molestias possimus iure assumenda, nobis enim blanditiis est excepturi! Repudiandae distinctio consequuntur necessitatibus.',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: isDark ? const Color(0xC3FFFFFF) : Colors.black54),
                ),
              ],
            ),
          ),
          QuestionHeaderWidget(
            title: 'Question 4',
            subtitle:
                'Create a simple Flutter widget to display a grid of colored boxes.',
          ),
          AnswerBlock(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: 16,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.primaries[(isDark?index:(index*6)) % Colors.primaries.length],
                );
              },
            ),
          ),
          QuestionHeaderWidget(
            title: 'Question 5',
            subtitle:
                'Write a Flutter widget that accepts user input and displays it in real-time on the screen.',
          ),
          AnswerBlock(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your thoughts: ${controller.text}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: text)),
                SizedBox(height: 16),
                TextField(
                  controller: controller,
                  style: TextStyle(color: text),
                  decoration: InputDecoration(
                      fillColor: backgroundColor,
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Do you like my work?',
                      labelStyle: TextStyle(fontSize: 15, color: text)),
                  onChanged: (value) => setState(() => controller.text = value),
                ),
              ],
            ),
          ),
          QuestionHeaderWidget(
            title: 'Question 6',
            subtitle:
                'Build a Flutter widget that toggles between two themes (light and dark).',
          ),
          AnswerBlock(
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Current Theme: ${isDark ? 'Dark' : 'Light'}",
                        style:
                            TextStyle(fontWeight: FontWeight.w600, color: text),
                      ),
                      Switch.adaptive(
                        value: themeProvider.isDarkTheme,
                        onChanged: (value) {
                          setState(() {
                            isDark != isDark;
                          });
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return ToDoApp();
                    },
                  ));
                },
                child: Text('Navigate to: To-Do App')),
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}

class AnswerBlock extends StatelessWidget {
  final Widget child;
  const AnswerBlock({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDarkTheme;
    Color backgroundColor = isDark ? Color(0xFF262626) : Colors.white;

    return Container(
        margin: EdgeInsets.all(24),
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
        padding: EdgeInsets.all(24),
        child: child);
  }
}

class QuestionHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const QuestionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDarkTheme;
    Color text = !isDark ? Color(0xFF262626) : const Color(0xE0FFFFFF);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: text),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.normal, color: text),
          ),
        ],
      ),
    );
  }
}
