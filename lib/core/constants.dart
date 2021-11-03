import 'package:flutter/material.dart';

class StyleConstants {
  static const kDefaultButtonColor = Colors.black54;
  static const kDefaultButtonSize = 60.0;
  static const kDefaultPadding = 20.0;

  static Color kLightColor() => Colors.grey[50]!;

  static Color kDarkColor() => Colors.grey[850]!;

  static const TextStyle kDefaultTextStyle = TextStyle(
    fontSize: 16.0,
  );

  static ThemeData kLightTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: kLightColor(),
    textTheme: TextTheme(
      bodyText2: kDefaultTextStyle.copyWith(color: Colors.black),
    ),
    canvasColor: kLightColor(),
  );

  static ThemeData kDarkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: kDarkColor(),
    textTheme: TextTheme(
      bodyText2: kDefaultTextStyle.copyWith(color: Colors.white),
    ),
    canvasColor: kDarkColor(),
  );
}
