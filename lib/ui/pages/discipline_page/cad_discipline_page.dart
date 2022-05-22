import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class CadDisciplinePage extends StatefulWidget {
  final Discipline? discipline;

  const CadDisciplinePage({
    this.discipline,
    Key? key
  }) : super(key: key);

  @override
  State<CadDisciplinePage> createState() => _CadDisciplinePageState();
}

class _CadDisciplinePageState extends State<CadDisciplinePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _classHoursController = TextEditingController();
  final TextEditingController _numberOfClassesController = TextEditingController();
  List<Teacher> _teachers = List<Teacher>.empty();
  Teacher? _teacher;
  Discipline? _discipline;

  @override
  void initState() {
    super.initState();
    _discipline = widget.discipline;
    _loadLists();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Disciplina',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WTextField(
                labelText: 'Descrição',
                textEditingController: _descriptionController,
                validator: _validateDescription,
                paddingTop: 20,
              ),
              WTextField(
                labelText: 'Horas Aulas',
                textEditingController: _classHoursController,
                validator: _validateClassHours,
                textInputType: TextInputType.number,
                readOnly: _discipline != null,
              ),
              WTextField(
                labelText: 'Número de Aulas',
                textEditingController: _numberOfClassesController,
                validator: _validateNumberOfClasses,
                textInputType: TextInputType.number,
                readOnly: _discipline != null,
              ),
              _createDropdownTeachers(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDropdownTeachers() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<Teacher>(
        value: _teacher,
        validator: _validateTeacher,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Professor',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _teacher = newValue!;
          });
        },
        items: _teachers.map((Teacher teacher) {
          return DropdownMenuItem<Teacher>(
            value: teacher,
            child: Text(teacher.toString()),
          );
        }).toList(),
      ),
    );
  }

  void _save() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      DisciplineHelper disciplineHelper = DisciplineHelper();

      if (_discipline == null) {
        Discipline discipline = Discipline(
          description: _descriptionController.text,
          classHours: int.parse(_classHoursController.text),
          numberOfClasses: int.parse(_numberOfClassesController.text),
          teacher: _teacher!
        );

        disciplineHelper.insert(discipline);
      }
      else {
        _discipline!.description = _descriptionController.text;
        _discipline!.classHours = int.parse(_classHoursController.text);
        _discipline!.numberOfClasses = int.parse(_numberOfClassesController.text);
        _discipline!.teacher = _teacher!;

        disciplineHelper.update(_discipline!);
      }

      Navigator.pop(context);
    }
  }

  void _loadLists() async {
    TeacherHelper teacherHelper = TeacherHelper();
    _teachers = (await teacherHelper.getAllActive());

    setState(() {
      _loadDiscipline();
    });
  }

  void _loadDiscipline() {
    if (_discipline != null) {
      if (_teachers.isEmpty) {
        _teachers = [ _discipline!.teacher ];
      }

      _descriptionController.text = _discipline!.description;
      _classHoursController.text = _discipline!.classHours.toString();
      _numberOfClassesController.text = _discipline!.numberOfClasses.toString();
      _teacher = _teachers.isEmpty ? _discipline?.teacher : _teachers.firstWhere((teacher) => teacher.id == _discipline?.teacher.id);
    }
  }

  String? _validateDescription(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe a Descrição';
    }

    return null;
  }

  String? _validateClassHours(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe as Horas Aulas';
    }

    if (int.parse(string) == 0) {
      return 'Informe uma Horas Aulas valida';
    }

    return null;
  }

  String? _validateNumberOfClasses(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o Número de Aulas';
    }

    if (int.parse(string) == 0) {
      return 'Informe um Número de Aulas valido';
    }

    return null;
  }

  String? _validateTeacher(Teacher? teacher) {
    if (teacher == null) {
      return 'Selecione um Professor';
    }

    return null;
  }
}
