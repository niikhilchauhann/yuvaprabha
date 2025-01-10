import 'package:flutter/material.dart';
import '/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'utils/core/export.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) => MaterialApp(
        title: 'Yuvaprabha App',
        theme: theme.isDarkMode ? darkTheme : lightTheme,
        themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: const AppStructure(),
      ),
    );
  }
}
