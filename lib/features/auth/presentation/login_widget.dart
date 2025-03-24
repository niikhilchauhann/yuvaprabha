import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yuvaprabha/config/api/export.dart';

import '../../../config/helpers/custom_validators.dart';
import '../../../core/global/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's get you started",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          h24,
          Text(
            'Email/Phone Number',
            style: theme.labelMedium,
          ).pOnly(bottom: 12),
          CustomTextField(
            controller: emailController,
            customValidator: (value) => emailOrPhoneValidator(value),
            hint: 'Email',
          ),
          Text(
            'Password',
            style: theme.labelMedium,
          ).pOnly(bottom: 12),
          CustomTextField(
            controller: passwordController,
            isPassword: true,
            customValidator: (value) => passwordValidator(value),
            hint: 'Password',
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              // style: ThemeHelper.textButtonTheme(),
              onPressed: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          h16,
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                } on FirebaseException catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primary,
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },
              style: elevatedButtonTheme(primary, Colors.black,
                  width: size.width - 116),
              child: Text(
                'Login',
                style: theme.labelLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
