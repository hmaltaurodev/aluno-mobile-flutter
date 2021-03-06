import 'package:flutter/material.dart';

ThemeData lightTheme() {
  const Color primaryColor = Color.fromRGBO(0, 0, 253, 1);
  const Color primaryColorDark = Color.fromRGBO(0, 0, 108, 1);
  const Color primaryColorLight = Color.fromRGBO(124, 124, 255, 1);
  const Color errorColor = Color.fromRGBO(255, 0, 0, 1);

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
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(
      fontSize: 15,
      color: Colors.grey.shade700,
    ),
    errorStyle: const TextStyle(
      color: errorColor, // or any other color
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
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
    scaffoldBackgroundColor: Colors.blueGrey.shade50,
  );
}
