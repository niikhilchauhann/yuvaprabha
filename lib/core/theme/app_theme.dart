import 'package:flutter/material.dart';

import '../../config/api/export.dart';

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

   ButtonStyle elevatedButtonTheme(Color background, Color foreground,
          {double? width, double? height}) =>
      ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(width ?? 148, height ?? 56)),
        backgroundColor: WidgetStatePropertyAll(background),
        foregroundColor: WidgetStatePropertyAll(foreground),
        shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );

   ButtonStyle textButtonTheme() => const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 13,
            decoration: TextDecoration.underline,
          ),
        ),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
      );


// import 'package:flutter/material.dart';

// import '../colors/app_colors.dart';
// class ThemeHelper {
//   static ColorScheme colors(Brightness brightness, Color targetColor) =>
//       ColorScheme.fromSeed(seedColor: targetColor, brightness: brightness);

//   static ShapeBorder? roundedEdge = RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(15),
//   );

//   static DialogTheme dialogTheme = DialogTheme(shape: roundedEdge);
//   static CardTheme cardTheme = CardTheme(
//     shape: roundedEdge,
//     elevation: 5,
//   );

//   static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
//         backgroundColor: colorScheme.surface,
//         foregroundColor: colorScheme.onSurface,
//         elevation: 0,
//         titleTextStyle: TextStyle(
//           color: colorScheme.onSurface,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 0.5,
//           fontSize: 18,
//         ),
//         centerTitle: true,
//       );

  // static ButtonStyle elevatedButtonTheme(Color background, Color foreground,
  //         {double? width, double? height}) =>
  //     ButtonStyle(
  //       minimumSize: WidgetStatePropertyAll(Size(width ?? 148, height ?? 56)),
  //       backgroundColor: WidgetStatePropertyAll(background),
  //       foregroundColor: WidgetStatePropertyAll(foreground),
  //       shadowColor: const WidgetStatePropertyAll(Colors.transparent),
  //       shape: WidgetStatePropertyAll(
  //         RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //       ),
  //     );

  // static ButtonStyle textButtonTheme() => const ButtonStyle(
  //       foregroundColor: WidgetStatePropertyAll(Colors.black),
  //       overlayColor: WidgetStatePropertyAll(Colors.transparent),
  //       textStyle: WidgetStatePropertyAll(
  //         TextStyle(
  //           fontSize: 13,
  //           decoration: TextDecoration.underline,
  //         ),
  //       ),
  //       padding: WidgetStatePropertyAll(EdgeInsets.zero),
  //     );

//   static InputDecorationTheme inputDecoration(ColorScheme colorScheme) =>
//       InputDecorationTheme(
//         contentPadding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
//         labelStyle: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//         ),
//         prefixIconColor: colorScheme.secondary,
//         suffixIconColor: colorScheme.onSurface,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(16)),
//           borderSide: BorderSide(color: colorScheme.primary),
//         ),
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: colorScheme.error, width: 2),
//           borderRadius: const BorderRadius.all(Radius.circular(16)),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: colorScheme.error, width: 2),
//           borderRadius: const BorderRadius.all(Radius.circular(16)),
//         ),
//       );

//   static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
//         titleSmall: TextStyle(color: colorScheme.onSurface),
//         bodyMedium: TextStyle(color: colorScheme.onSurface),
//         labelLarge: TextStyle(
//             color: colorScheme.onSurface,
//             fontWeight: FontWeight.bold,
//             fontSize: 16),
//         labelMedium: TextStyle(
//             color: colorScheme.onSurface,
//             fontWeight: FontWeight.bold,
//             fontSize: 13),
//         titleMedium: TextStyle(color: colorScheme.onSurface),
//         titleLarge: TextStyle(color: colorScheme.onSurface),
//         displayMedium: TextStyle(color: colorScheme.onSurface),
//         displaySmall: TextStyle(color: colorScheme.onSurface),
//         headlineSmall: TextStyle(
//           color: colorScheme.onSurface,
//           fontWeight: FontWeight.bold,
//         ),
//       ).apply();

//   static ThemeData lightTheme(Color targetColor) {
//     final ColorScheme colorScheme = colors(Brightness.light, targetColor);
//     return ThemeData.light(useMaterial3: true).copyWith(
//       dialogTheme: dialogTheme,
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: AppColors.white,
//       inputDecorationTheme: inputDecoration(colorScheme),
//       cardTheme: cardTheme,
//       appBarTheme: appBarTheme(colorScheme),
//       textTheme: textTheme(colorScheme),
//     );
//   }
// }
