import 'package:flutter/material.dart';

ThemeData lightTheme() {
  const Color primaryColor = Color.fromRGBO(0, 0, 253, 1);
  const Color primaryColorDark = Color.fromRGBO(0, 0, 108, 1);
  const Color primaryColorLight = Color.fromRGBO(124, 124, 255, 1);
  Color shadeColor = Colors.blueGrey.shade50;

  const TextStyle textStyleElevatedButton = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );

  const BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme(
    color: primaryColor,
    shape: CircularNotchedRectangle(),
  );

  ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
      shape: const StadiumBorder(),
      textStyle: textStyleElevatedButton,
    ),
  );

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: primaryColor,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: primaryColorDark,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
  );

  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,

    bottomAppBarTheme: bottomAppBarTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
  );
}
