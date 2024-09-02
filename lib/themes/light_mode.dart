import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData selectedTheme = ThemeData.light(useMaterial3: true);

  static TextTheme textTheme(
      {color = const Color(0xFF4F8500), family = "BreeSerif", size, weight}) {
    return TextTheme(
        titleLarge: TextStyle(
            fontSize: size ?? 26.0,
            fontWeight: weight ?? FontWeight.w600,
            fontFamily: family,
            color: color),
        titleMedium: TextStyle(
            fontSize: size ?? 22.0,
            fontWeight: weight ?? FontWeight.w400,
            fontFamily: family,
            color: color),
        titleSmall: TextStyle(
            fontSize: size ?? 20.0,
            fontWeight: weight ?? FontWeight.w200,
            fontFamily: family,
            color: color),
        bodyLarge: TextStyle(
            fontSize: size ?? 22.0,
            fontWeight: weight ?? FontWeight.w300,
            fontFamily: family,
            color: color),
        bodyMedium: TextStyle(
          fontSize: size ?? 18.0,
          fontFamily: family,
          color: color,
        ),
        bodySmall: TextStyle(
          fontSize: size ?? 14.0,
          fontFamily: family,
          color: color,
        ),
        displaySmall: TextStyle(
          fontSize: size ?? 12.0,
          fontFamily: family,
          color: color,
        ));
  }
}
