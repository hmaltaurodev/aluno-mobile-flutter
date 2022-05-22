import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadTeacherPage extends StatefulWidget {
  final Teacher? teacher;

  const CadTeacherPage({
    this.teacher,
    Key? key
  }) : super(key: key);

  @override
  State<CadTeacherPage> createState() => _CadTeacherPageState();
}

class _CadTeacherPageState extends State<CadTeacherPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _registrationIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _registrationDateController = TextEditingController();
  Teacher? _teacher;

  @override
  void initState() {
    super.initState();
    _teacher = widget.teacher;
    _loadTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Professor',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _save,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              WTextField(
                labelText: 'R.A.',
                textEditingController: _registrationIdController,
                validator: _validateRegistrationId,
                textInputType: TextInputType.number,
                paddingTop: 20,
                readOnly: _teacher != null,
                maxLenght: 8,
              ),
              WTextField(
                labelText: 'Nome',
                textEditingController: _nameController,
                validator: _validateName,
              ),
              WTextField(
                labelText: 'CPF',
                textEditingController: _cpfController,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      TeacherHelper teacherHelper = TeacherHelper();

      if (_teacher == null) {
        Teacher teacher = Teacher(
          registrationId: int.parse(_registrationIdController.text),
          name: _nameController.text,
          cpf: _cpfController.text,
          birthDate: DateFormat('dd/MM/yyyy').parse(_birthDateController.text),
          registrationDate: DateFormat('dd/MM/yyyy').parse(_registrationDateController.text),
        );

        teacher = await teacherHelper.insert(teacher);

        User user = User(
          username: teacher.registrationId.toString().padLeft(8, '0'),
          password: Crypt.sha256(teacher.registrationId.toString().padLeft(8, '0')).toString(),
          userType: UserType.teacher.toInt(),
          teacher: teacher,
          isActive: 1
        );

        UserHelper userHelper = UserHelper();
        userHelper.insert(user);
      }
      else {
        _teacher!.name = _nameController.text;
        _teacher!.cpf = _cpfController.text;
        _teacher!.birthDate = DateFormat('dd/MM/yyyy').parse(_birthDateController.text);
        _teacher!.registrationDate = DateFormat('dd/MM/yyyy').parse(_registrationDateController.text);

        teacherHelper.update(_teacher!);
      }

      Navigator.pop(context);
    }
  }

  void _loadTeacher() {
    if (_teacher != null) {
      _registrationIdController.text = _teacher!.registrationId.toString();
      _nameController.text = _teacher!.name;
      _cpfController.text = _teacher!.cpf;
      _birthDateController.text = DateFormat('dd/MM/yyyy').format(_teacher!.birthDate);
      _registrationDateController.text = DateFormat('dd/MM/yyyy').format(_teacher!.registrationDate);
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
