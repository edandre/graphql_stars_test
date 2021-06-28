import 'package:flutter/material.dart';

class LightTheme {
  final ThemeData _themeData = ThemeData(
    fontFamily: 'Segoe UI',
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey[800],
    backgroundColor: Colors.grey[200],
    accentColor: Colors.lime[800],
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade900,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade900,
      ),
      button: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade100,
      ),
    ),
  );

  ThemeData get themeData => _themeData;
}
