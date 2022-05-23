import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
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
  bool _registrationIdNotUnique = false;

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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _save,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WTextField(
                labelText: 'R.A.',
                textEditingController: _registrationIdController,
                validator: _validateRegistrationId,
                textInputType: TextInputType.number,
                paddingTop: 20,
                readOnly: _student != null,
                maxLenght: 8,
                onChanged: (string) {
                  if (_registrationIdNotUnique) {
                    setState(() {
                      _registrationIdNotUnique = false;
                    });
                  }
                },
              ),
              WTextField(
                labelText: 'Nome',
                textEditingController: _nameController,
                validator: _validateName,
              ),
              WTextField(
                labelText: 'CPF',
                textEditingController: _cpfController,
                textInputType: TextInputType.number,
                validator: _validateCPF,
              ),
              GestureDetector(
                onTap: _showDatePickerBirthDate,
                child: WTextField(
                  labelText: 'Data de Nascimento',
                  textEditingController: _birthDateController,
                  textInputType: TextInputType.datetime,
                  validator: _validateBirthDate,
                  enabled: false,
                ),
              ),
              GestureDetector(
                onTap: _showDatePickerRegistrationDate,
                child: WTextField(
                  labelText: 'Data de Registro',
                  textEditingController: _registrationDateController,
                  textInputType: TextInputType.datetime,
                  validator: _validateRegistrationDate,
                  enabled: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      StudentHelper studentHelper = StudentHelper();
      UserHelper userHelper = UserHelper();

      if (_student == null) {
        Student student = Student(
          registrationId: int.parse(_registrationIdController.text),
          name: _nameController.text,
          cpf: _cpfController.text,
          birthDate: DateFormat('dd/MM/yyyy').parse(_birthDateController.text),
          registrationDate: DateFormat('dd/MM/yyyy').parse(_registrationDateController.text),
        );

        if ((await userHelper.getByUsername(student.registrationId.toString().padLeft(8, '0'))) != null) {
          setState(() {
            _registrationIdNotUnique = true;
            _formKey.currentState!.validate();
          });

          return;
        }

        student = await studentHelper.insert(student);

        User user = User(
          username: student.registrationId.toString().padLeft(8, '0'),
          password: Crypt.sha256(student.registrationId.toString().padLeft(8, '0')).toString(),
          userType: UserType.student.toInt(),
          student: student,
          isActive: 1
        );

        userHelper.insert(user);
      }
      else {
        _student!.name = _nameController.text;
        _student!.cpf = _cpfController.text;
        _student!.birthDate = DateFormat('dd/MM/yyyy').parse(_birthDateController.text);
        _student!.registrationDate = DateFormat('dd/MM/yyyy').parse(_registrationDateController.text);

        studentHelper.update(_student!);
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

  void _showDatePickerBirthDate() {
    FocusScope.of(context).unfocus();

    Utils.datePicker(context).then((value) {
      setState(() {
        if (value != null) {
          _birthDateController.text = DateFormat('dd/MM/yyyy').format(value);
        }
      });
    });
  }

  void _showDatePickerRegistrationDate() {
    FocusScope.of(context).unfocus();

    Utils.datePicker(context).then((value) {
      setState(() {
        if (value != null) {
          _registrationDateController.text = DateFormat('dd/MM/yyyy').format(value);
        }
      });
    });
  }

  String? _validateRegistrationId(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o R.A.';
    }

    if (int.parse(string) == 0) {
      return 'Informe um R.A. valido';
    }

    if (_registrationIdNotUnique) {
      return 'Já existe um aluno ou professor com esse R.A.';
    }

    return null;
  }

  String? _validateName(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o Nome';
    }

    return null;
  }

  String? _validateCPF(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o CPF';
    }

    return null;
  }

  String? _validateBirthDate(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe a Data de Nascimento';
    }

    return null;
  }

  String? _validateRegistrationDate(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe a Data de Registro';
    }

    return null;
  }
}
