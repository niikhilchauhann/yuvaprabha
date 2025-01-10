import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/utils/core/export.dart';

import '../../providers/theme_provider.dart';

class CustomRoundButton extends StatelessWidget {
  final double size;
  final VoidCallback? onPressed;
  final String? imgPath;
  final Widget child;
  final Color? color;
  const CustomRoundButton({
    super.key,
    required this.size,
    this.onPressed,
    this.imgPath,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.all(size),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.defRad),
              color: color ??
                  (!Provider.of<ThemeProvider>(context).isDarkMode
                      ? surface
                      : surfaceDark),
              image: imgPath != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      invertColors: true,
                      image: AssetImage(imgPath!))
                  : null),
          child: child),
    );
  }
}
