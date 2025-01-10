import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../providers/theme_provider.dart';
import '../../utils/core/export.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  late final WebViewController _controller;
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          _isLoading.value = true;
        },
        onPageFinished: (url) {
          _isLoading.value = false;
        },
      ))
      ..loadRequest(Uri.parse('https://app.flowcv.com/resumes'));
  }

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) =>
          AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor:
              themeProvider.isDarkMode ? surfaceDark : surface,
          systemNavigationBarIconBrightness:
              themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
        ),
        child: Scaffold(
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (context, isLoading, child) {
                  return isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
