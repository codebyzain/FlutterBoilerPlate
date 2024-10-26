import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/config_main.dart';

class AppTheme {
  static light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "DefaultFont",
      // Define the default brightness and colors.
      colorScheme: ColorScheme.fromSeed(
        background: const Color.fromRGBO(250, 250, 250, 1),
        secondary: Colors.black12,
        seedColor: MainConfig.appColorTheme,
        brightness: Brightness.light,
      ),
      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black87,
          fontSize: 13,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }

  static dark() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "DefaultFont",
      // Define the default brightness and colors.
      colorScheme: ColorScheme.fromSeed(
        background: Colors.white12,
        secondary: Colors.black87,
        seedColor: MainConfig.appColorTheme,
        brightness: Brightness.light,
      ),
      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }
}
