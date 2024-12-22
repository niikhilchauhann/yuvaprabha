import 'package:flutter/material.dart';
import 'package:nextsolutions/providers/theme_provider.dart';
import 'package:provider/provider.dart';

const Color kWhiteColor = Color(0xffffffff);
const Color kBlackColor = Color(0xff000000);

const Color kGrey0 = Color(0xff555555);
const Color kGrey1 = Color(0xff8D9091);
const Color kGrey2 = Color(0xffCCCCCC);
const Color kGrey3 = Color(0xffEFEFEF);

const Color kPrimaryColor = Color(0xFF3F37C9);

const Color kRed = Color(0xffC5292A);

SnackBar getSnackBar(String message, Color backgroundColor) {
  SnackBar snackBar = SnackBar(
    content: Text(message, style: const TextStyle(fontSize: 14)),
    backgroundColor: backgroundColor,
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
  );
  return snackBar;
}

class BuildTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final Color fillColor;
  final Color hintColor;
  final int? maxLength;
  final Function onChange;

  const BuildTextField(
      {super.key,
      required this.hint,
      this.controller,
      required this.inputType,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.enabled = true,
      this.fillColor = kWhiteColor,
      this.hintColor = kGrey1,
      this.maxLength,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDarkTheme;
    Color backgroundColor = isDark ? Color(0xff121212) : Colors.white;

    Color text = !isDark ? Color(0xFF262626) : const Color(0xE0FFFFFF);
    return TextFormField(
      onChanged: (value) {
        onChange(value);
      },
      validator: (val) => val!.isEmpty ? 'required' : null,
      keyboardType: inputType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: inputType == TextInputType.multiline ? 3 : 1,
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        counterText: "",
        fillColor: fillColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: hintColor,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: kRed,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 1, color: kPrimaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: fillColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: kGrey1),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 0, color: kGrey1)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: kRed)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: kGrey1)),
        focusColor: kWhiteColor,
        hoverColor: kWhiteColor,
      ),
      cursorColor: kPrimaryColor,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: text,
      ),
    );
  }
}

Text buildText(String text, Color color, double fontSize, FontWeight fontWeight,
    TextAlign textAlign, TextOverflow overflow, TextDecoration? decor) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    style: TextStyle(
      decoration: decor ?? TextDecoration.none,
      decorationColor: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
