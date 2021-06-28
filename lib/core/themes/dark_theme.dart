import 'package:flutter/material.dart';

class DarkTheme {
  final ThemeData _themeData = ThemeData(
    fontFamily: 'Segoe UI',
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[300],
    backgroundColor: Colors.grey[800],
    accentColor: Colors.purple[800],
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade100,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade100,
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
