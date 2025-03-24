import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yuvaprabha/config/api/export.dart';
import 'package:yuvaprabha/features/auth/presentation/auth_screen.dart';

class AuthSwitchWidget extends StatelessWidget {
  const AuthSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return AppStructure();
        } else {
          return AuthScreen();
        }
      }),
    );
  }
}
