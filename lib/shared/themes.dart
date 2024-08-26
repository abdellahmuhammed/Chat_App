import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return _buildTheme(
    context,
    textColor: Colors.black,
    backgroundColor: Colors.blueGrey,
  );
}

ThemeData darkTheme(BuildContext context) {
  return _buildTheme(
    context,
    textColor: Colors.white,
    backgroundColor: Colors.grey.shade900,
  );
}

ThemeData _buildTheme(BuildContext context,
    {required Color textColor, required Color backgroundColor}) {
  return ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: textColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: textColor),
      ),
      //  Enabled Outline Input Border
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.blue),
      ),
      //  Focused Outline Input Border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: textColor),
      ),
      // General  Outline Input Border
      filled: true,
      fillColor: backgroundColor,
      labelStyle: Theme.of(context).textTheme.titleLarge,
    ),
  );
}
