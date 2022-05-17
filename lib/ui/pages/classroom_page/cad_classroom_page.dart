import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CadClassroomPage extends StatefulWidget {
  const CadClassroomPage({Key? key}) : super(key: key);

  @override
  State<CadClassroomPage> createState() => _CadClassroomPageState();
}

class _CadClassroomPageState extends State<CadClassroomPage> {
  List<Course> _courses = List<Course>.empty();

  Course? _courseValue;

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Turma',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        ],
      )
    );
  }

  void _save() {

  }
}
