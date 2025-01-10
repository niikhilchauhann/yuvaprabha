import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../providers/theme_provider.dart';
import '../utils/core/export.dart';

class WebViewBaseScreen extends StatefulWidget {
  final String heading;
  final String url;
  const WebViewBaseScreen(
      {super.key, required this.heading, required this.url});

  @override
  State<WebViewBaseScreen> createState() => _WebViewBaseScreenState();
}

class _WebViewBaseScreenState extends State<WebViewBaseScreen> {
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
          _blockLoginPopup();
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  void _blockLoginPopup() {
    _controller.runJavaScript('''
      const loginPopup = document.getElementById('login-popup');
      if (loginPopup) {
        loginPopup.style.display = 'none';
      }
      document.querySelectorAll('#login-popup, .login-trigger').forEach(el => {
        el.addEventListener('click', (event) => {
          event.preventDefault();
          alert('This functionality is blocked in the app.');
        });
      });
    ''');
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
          appBar: AppBar(
            title: Text(
              widget.heading,
              style: titlelarge,
            ),
            automaticallyImplyLeading: false,
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (context, isLoading, child) {
                  return isLoading
                      ? Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
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
