import 'package:flutter/material.dart';

import '../utils/core/export.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primary,
    primary: primary,
    secondary: secondary,
    // background: background,
    surface: surface,
    // onBackground: onBackground,
    onSurface: onSurface,
    onPrimary: onPrimary,
    onSecondary: onSecondary,

    brightness: Brightness.light,
  ),
  useMaterial3: true,
  primaryColor: primary,
  scaffoldBackgroundColor: background,
  dialogBackgroundColor: background,
  appBarTheme: AppBarTheme(
    backgroundColor: surface,
    centerTitle: true,
  ),
  fontFamily: 'Gilroy',
  cardColor: surface,
  indicatorColor: primary,
  secondaryHeaderColor: secondary,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primary,
    primary: primary,
    secondary: secondary,
    // background: backgroundDark,
    surface: surfaceDark,
    // onBackground: onBackgroundDark,
    onSurface: onSurfaceDark,
    onPrimary: onPrimaryDark,
    onSecondary: onSecondaryDark,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  primaryColor: primary,
  scaffoldBackgroundColor: backgroundDark,
  dialogBackgroundColor: backgroundDark,
  appBarTheme: AppBarTheme(
    backgroundColor: surfaceDark,
    centerTitle: true,
  ),
  fontFamily: 'Gilroy',
  cardColor: surfaceDark,
  indicatorColor: primary,
  secondaryHeaderColor: secondary,
);
