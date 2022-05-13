import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:aluno_mobile_flutter/ui/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromRGBO(0, 0, 253, 1),
    statusBarColor: Color.fromRGBO(0, 0, 253, 1),
  ));

  runApp(MaterialApp(
    title: 'Aluno Mobile',
    home: const LoginPage(),
    theme: lightTheme(),
    debugShowCheckedModeBanner: false,
    /*routes: <String, WidgetBuilder> {
      "home_page" : (BuildContext context) => const HomePage(),
    }*/
  ));
}
