import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/config/api/export.dart';

import '../provider/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final void Function(String)? onSubmit;
  final FormFieldValidator<String>? customValidator;
  final bool? isPassword;
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(true);
  final bool? isPara;
  final TextInputType? type;

  CustomTextField(
      {super.key,
      required this.hint,
      this.isPara,
      required this.controller,
      this.type,
      this.customValidator,
      this.isPassword,
      this.focusNode,
      this.nextFocus,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return ValueListenableBuilder<bool>(
        valueListenable: _isVisible,
        builder: (context, value, child) => TextFormField(
              focusNode: focusNode,
              validator: customValidator,
              keyboardType: type ?? TextInputType.name,
              controller: controller,
              style: TextStyle(fontSize: 14),
              maxLines: (isPara == null ? 1 : 5),
              obscureText: isPassword != null ? _isVisible.value : false,
              onFieldSubmitted: (v) {
                nextFocus?.requestFocus();
                onSubmit != null ? onSubmit!(v) : ();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? surfaceDark : surface,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintText: hint,
                hintStyle: TextStyle(fontSize: 13),
                suffixIcon: isPassword != null
                    ? IconButton(
                        icon: Icon(
                          value ? Icons.visibility_off : Icons.visibility,
                          size: 18,
                        ),
                        onPressed: () => _isVisible.value = !value,
                      )
                    : null,
              ),
            ).pOnly(bottom: 16));
  }
}
