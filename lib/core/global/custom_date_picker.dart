import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/api/export.dart';
import '../provider/theme_provider.dart';

class CustomDatePicker extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  final String? date;
  const CustomDatePicker({
    super.key,
    required this.ontap,
    required this.text,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: ontap,
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDark ? surfaceDark : surface,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.calendar,
              size: 20,
            ),
            w8,
            Expanded(
              child: Text(
                date ?? text,
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    ).pOnly(bottom: 16);
  }
}
