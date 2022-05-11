import 'package:flutter/material.dart';

ThemeData lightTheme() {
  const Color primaryColor = Color.fromRGBO(0, 0, 253, 1);
  const Color primaryColorDark = Color.fromRGBO(0, 0, 108, 1);
  const Color primaryColorLight = Color.fromRGBO(124, 124, 255, 1);

  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    //scaffoldBackgroundColor: Colors.blueGrey.shade50,
  );
}
