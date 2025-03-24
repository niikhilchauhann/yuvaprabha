import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yuvaprabha/config/api/export.dart';

import '../../../config/helpers/custom_validators.dart';
import '../../../core/global/custom_text_field.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({
    super.key,
  });

  static const String routeName = '/register';

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
final TextEditingController cityController = TextEditingController();
final TextEditingController stateController = TextEditingController();

class _RegisterationScreenState extends State<RegisterationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
            'Name',
            style: theme.labelMedium,
          ).pOnly(bottom: 12),
          CustomTextField(
            controller: nameController,
            customValidator: (value) => firstNameValidator(value),
            hint: 'Name',
          ),
          Text(
            'Email Address',
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
          Text(
            'Re-enter Password',
            style: theme.labelMedium,
          ).pOnly(bottom: 12),
          CustomTextField(
            controller: confirmPasswordController,
            isPassword: true,
            customValidator: (value) => passwordValidator(value),
            hint: 'Confirm Password',
          ),
          h20,
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final auth = FirebaseAuth.instance;
                try {
                  await auth
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then(
                        (value) => FirebaseFirestore.instance
                            .collection('users')
                            .doc(auth.currentUser!.uid)
                            .set(
                          {'name': nameController.text},
                        ),
                      );
                } on FirebaseException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primary,
                      content: Text(
                        e.message.toString(),
                      ),
                    ),
                  );
                }
              },
              style: elevatedButtonTheme(primary, Colors.black,
                  width: size.width - 116),
              child: Text(
                'Register',
                style: theme.labelLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
