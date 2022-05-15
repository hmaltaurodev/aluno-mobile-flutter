import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadStudentPage extends StatefulWidget {
  const CadStudentPage({Key? key}) : super(key: key);

  @override
  State<CadStudentPage> createState() => _CadStudentPageState();
}

class _CadStudentPageState extends State<CadStudentPage> {
  final TextEditingController _registrationIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _registrationDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Aluno'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _save,
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

  void _save() {
    Student student = Student(
      registrationId: int.parse(_registrationIdController.text),
      name: _nameController.text,
      cpf: _cpfController.text,
      birthDate: DateFormat('dd/MM/yyyy').parse(_birthDateController.text),
      registrationDate: DateFormat('dd/MM/yyyy').parse(_registrationDateController.text),
    );

    StudentHelper studentHelper = StudentHelper();
    studentHelper.insert(student);

    Navigator.pop(context);
  }
}
