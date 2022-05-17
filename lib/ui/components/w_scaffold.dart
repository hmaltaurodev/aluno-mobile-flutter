import 'package:flutter/material.dart';

class WScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Icon iconFAB;
  final void Function() onPressedFAB;

  const WScaffold({
    required this.title,
    required this.body,
    required this.iconFAB,
    required this.onPressedFAB,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: iconFAB,
        onPressed: onPressedFAB,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        child: Padding(
          child: Icon(null),
          padding: EdgeInsets.all(8),
        ),
      ),
      extendBody: true,
    );
  }
}
