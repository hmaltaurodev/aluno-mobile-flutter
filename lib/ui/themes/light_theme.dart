import 'package:flutter/material.dart';

ThemeData lightTheme() {
  const Color primaryColor = Color.fromRGBO(0, 0, 253, 1);
  const Color primaryColorDark = Color.fromRGBO(0, 0, 108, 1);
  const Color primaryColorLight = Color.fromRGBO(124, 124, 255, 1);

  const TextStyle textStyleElevatedButton = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );

  const BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme(
    color: primaryColor,
    shape: CircularNotchedRectangle(),
  );

  const FloatingActionButtonThemeData floatingActionButtonThemeData = FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  );

  const AppBarTheme appBarTheme = AppBarTheme(
    color: primaryColor,
  );

  ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
      ),
      textStyle: textStyleElevatedButton,
    ),
  );

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: primaryColor,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: primaryColorDark,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
  );

  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,

    appBarTheme: appBarTheme,
    bottomAppBarTheme: bottomAppBarTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
    floatingActionButtonTheme: floatingActionButtonThemeData,
  );
}
