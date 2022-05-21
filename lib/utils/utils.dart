import 'package:flutter/material.dart';

class Utils {
  static IconData activeInactiveIcon(bool isActive) {
    return isActive ? Icons.blur_off : Icons.blur_on;
  }

  static String activeInactiveLabel(bool isActive) {
    return isActive ? 'Inativar' : 'Ativar';
  }

  static Color activeInactiveColor(bool isActive) {
    return isActive ? Colors.red : Colors.green;
  }
}