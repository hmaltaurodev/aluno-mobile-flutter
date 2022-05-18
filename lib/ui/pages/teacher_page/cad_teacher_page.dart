import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadTeacherPage extends StatefulWidget {
  const CadTeacherPage({Key? key}) : super(key: key);

  @override
  State<CadTeacherPage> createState() => _CadTeacherPageState();
}

class _CadTeacherPageState extends State<CadTeacherPage> {
  final TextEditingController _registrationIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _registrationDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Professor',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            WTextField(
              labelText: 'R.A.',
              textEditingController: _registrationIdController,
              textInputType: TextInputType.number,
              paddingTop: 20,
            ),
            WTextField(
              labelText: 'Nome',
              textEditingController: _nameController,
            ),
            WTextField(
              labelText: 'CPF',
              textEditingController: _cpfController,
            ),
            WTextField(
              labelText: 'Data de Nascimento',
              textEditingController: _birthDateController,
              textInputType: TextInputType.datetime,
            ),
            WTextField(
              labelText: 'Data de Registro',
              textEditingController: _registrationDateController,
              textInputType: TextInputType.datetime,
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    Teacher teacher = Teacher(
      registrationId: int.parse(_registrationIdController.text),
      name: _nameController.text,
      cpf: _cpfController.text,
      birthDate: DateFormat('dd/MM/yyyy').parse(_birthDateController.text),
      registrationDate: DateFormat('dd/MM/yyyy').parse(_registrationDateController.text),
    );

    TeacherHelper teacherHelper = TeacherHelper();
    teacherHelper.insert(teacher);

    Navigator.pop(context);
  }
}
