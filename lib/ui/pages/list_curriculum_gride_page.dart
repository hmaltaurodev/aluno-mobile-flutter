import 'package:flutter/material.dart';

class ListCurriculumGridePage extends StatefulWidget {
  const ListCurriculumGridePage({Key? key}) : super(key: key);

  @override
  State<ListCurriculumGridePage> createState() => _ListCurriculumGridePageState();
}

class _ListCurriculumGridePageState extends State<ListCurriculumGridePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades Curriculares'),
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
