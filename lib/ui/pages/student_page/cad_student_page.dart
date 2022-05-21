import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadStudentPage extends StatefulWidget {
  final Student? student;

  const CadStudentPage({
    this.student,
    Key? key
  }) : super(key: key);

  @override
  State<CadStudentPage> createState() => _CadStudentPageState();
}

class _CadStudentPageState extends State<CadStudentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _registrationIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _registrationDateController = TextEditingController();
  Student? _student;

  @override
  void initState() {
    super.initState();
    _student = widget.student;
    _loadStudent();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Aluno',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WTextField(
                labelText: 'R.A.',
                textEditingController: _registrationIdController,
                validator: validateRegistrationId,
                textInputType: TextInputType.number,
                paddingTop: 20,
                readOnly: _student != null,
                maxLenght: 8,
              ),
              WTextField(
                labelText: 'Nome',
                textEditingController: _nameController,
                validator: validateName,
              ),
              WTextField(
                labelText: 'CPF',
                textEditingController: _cpfController,
                validator: validateCPF,
              ),
              WTextField(
                labelText: 'Data de Nascimento',
                textEditingController: _birthDateController,
                textInputType: TextInputType.datetime,
                validator: validateBirthDate,
              ),
              WTextField(
                labelText: 'Data de Registro',
                textEditingController: _registrationDateController,
                textInputType: TextInputType.datetime,
                validator: validateRegistrationDate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      StudentHelper studentHelper = StudentHelper();

      if (_student == null) {
        Student student = Student(
          registrationId: int.parse(_registrationIdController.text),
          name: _nameController.text,
          cpf: _cpfController.text,
          birthDate: DateFormat('dd/MM/yyyy').parse(_birthDateController.text),
          registrationDate: DateFormat('dd/MM/yyyy').parse(_registrationDateController.text),
        );

        student = await studentHelper.insert(student);

        User user = User(
            username: student.registrationId.toString().padLeft(8, '0'),
            password: Crypt.sha256(student.registrationId.toString().padLeft(8, '0')).toString(),
            userType: UserType.student.toInt(),
            student: student,
            isActive: 1
        );

        UserHelper userHelper = UserHelper();
        userHelper.insert(user);
      }
      else {
        _student!.name = _nameController.text;
        _student!.cpf = _cpfController.text;
        _student!.birthDate = DateFormat('dd/MM/yyyy').parse(_birthDateController.text);
        _student!.registrationDate = DateFormat('dd/MM/yyyy').parse(_registrationDateController.text);

        await studentHelper.update(_student!);
      }

      Navigator.pop(context);
    }
  }

  void _loadStudent() {
    if (_student != null) {
      _registrationIdController.text = _student!.registrationId.toString();
      _nameController.text = _student!.name;
      _cpfController.text = _student!.cpf;
      _birthDateController.text = DateFormat('dd/MM/yyyy').format(_student!.birthDate);
      _registrationDateController.text = DateFormat('dd/MM/yyyy').format(_student!.registrationDate);
    }
  }

  String? validateRegistrationId(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o R.A.';
    }

    if (int.parse(string) == 0) {
      return 'Informe um R.A. valido';
    }

    return null;
  }

  String? validateName(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o Nome';
    }

    return null;
  }

  String? validateCPF(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o CPF';
    }

    return null;
  }

  String? validateBirthDate(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe a Data de Nascimento';
    }

    return null;
  }

  String? validateRegistrationDate(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe a Data de Registro';
    }

    return null;
  }
}
