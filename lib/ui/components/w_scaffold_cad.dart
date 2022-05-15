import 'package:flutter/material.dart';

class WScaffoldCad extends StatelessWidget {
  final String title;
  final Widget body;
  final void Function() onPressed;

  const WScaffoldCad({
    required this.title,
    required this.body,
    required this.onPressed,
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
        child: const Icon(Icons.save),
        onPressed: onPressed,
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
