import 'package:flutter/material.dart';
import 'package:nextsolutions/providers/counter_provider.dart';
import 'package:nextsolutions/providers/theme_provider.dart';
import 'package:nextsolutions/providers/todo_provider.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => ToDoProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NextSolution Assignment",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
