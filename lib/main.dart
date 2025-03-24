import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yuvaprabha/features/auth/presentation/auth_switch.dart';
import 'core/provider/resume_data_provider.dart';
import 'core/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'config/api/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ResumeDataProvider(),
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
        debugShowCheckedModeBanner: false,
        theme: theme.isDarkMode ? darkTheme : lightTheme,
        themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: AuthSwitchWidget(),
      ),
    );
  }
}
