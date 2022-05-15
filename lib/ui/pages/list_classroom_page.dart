import 'package:flutter/material.dart';

class ListClassroomPage extends StatefulWidget {
  const ListClassroomPage({Key? key}) : super(key: key);

  @override
  State<ListClassroomPage> createState() => _ListClassroomPageState();
}

class _ListClassroomPageState extends State<ListClassroomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turmas'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
