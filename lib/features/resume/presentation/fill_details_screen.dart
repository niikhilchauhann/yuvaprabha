import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/features/resume/presentation/widgets/resume_app_bar.dart';

import '../../../core/provider/theme_provider.dart';
import '../../../config/api/export.dart';

class FillDetailsScreen extends StatelessWidget {
  final int id;
  final Widget screen;
  const FillDetailsScreen({super.key, required this.screen, required this.id});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) =>
          AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor:
                    themeProvider.isDarkMode ? surfaceDark : surface,
                systemNavigationBarColor:
                    themeProvider.isDarkMode ? surfaceDark : surface,
                systemNavigationBarIconBrightness: themeProvider.isDarkMode
                    ? Brightness.light
                    : Brightness.dark,
              ),
              child: Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResumeAppBar(id: id),
                        screen.p(AppConstants.defPad),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
