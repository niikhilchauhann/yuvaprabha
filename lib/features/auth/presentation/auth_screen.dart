import 'package:flutter/material.dart';
import 'package:yuvaprabha/config/api/export.dart';

import 'login_widget.dart';
import 'registeration_widget.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth';
  AuthScreen({super.key});

  final ValueNotifier<bool> isLogin = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isLogin,
              builder: (context, isLoginValue, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: offsetAnimation,
                      child: child,
                    );
                  },
                  child: isLoginValue
                      ? LoginScreen(
                      
                          key: const ValueKey('LoginScreen'))
                      : RegisterationScreen(
                         
                          key: const ValueKey('RegisterationScreen'),
                        ),
                );
              },
            ),
            h12,
            ValueListenableBuilder<bool>(
              valueListenable: isLogin,
              builder: (context, isLoginValue, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isLoginValue
                        ? "Don't have an account?"
                        : "Already have an account?"),
                    TextButton(
                      onPressed: () => isLogin.value = !isLogin.value,
                      child: Text(
                        isLoginValue ? 'Sign Up' : 'Login',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
