import 'package:flutter/material.dart';

class CadClassroomPage extends StatefulWidget {
  const CadClassroomPage({Key? key}) : super(key: key);

  @override
  State<CadClassroomPage> createState() => _CadClassroomPageState();
}

class _CadClassroomPageState extends State<CadClassroomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Turma'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () { },
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
