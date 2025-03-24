import 'package:flutter/material.dart';

import '../colors/color_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? btnColor;
  final Color? txtColor;
  final String? text;
  final VoidCallback? ontap;
  final bool? isRow;
  const CustomElevatedButton(
      {super.key,
      this.btnColor,
      this.text,
      this.ontap,
      this.txtColor,
      this.isRow});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        height: 52,
        // width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: btnColor ?? primary,
        ),
        child: Center(
            child: Text(
          text ?? 'Submit',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: txtColor ?? Colors.white),
        )),
      ),
    );
  }
}
