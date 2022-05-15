import 'package:flutter/material.dart';

class ListDisciplinePage extends StatefulWidget {
  const ListDisciplinePage({Key? key}) : super(key: key);

  @override
  State<ListDisciplinePage> createState() => _ListDisciplinePageState();
}

class _ListDisciplinePageState extends State<ListDisciplinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
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
