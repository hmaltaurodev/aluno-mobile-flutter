import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class CadDisciplinePage extends StatefulWidget {
  final Teacher? teacherDefalt;

  const CadDisciplinePage({
    this.teacherDefalt,
    Key? key
  }) : super(key: key);

  @override
  State<CadDisciplinePage> createState() => _CadDisciplinePageState();
}

class _CadDisciplinePageState extends State<CadDisciplinePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _classHoursController = TextEditingController();
  final TextEditingController _numberOfClassesController = TextEditingController();
  Teacher? _teacherDefalt;
  List<Teacher> _teachers = List<Teacher>.empty();

  @override
  void initState() {
    super.initState();
    _teacherDefalt = widget.teacherDefalt;
    _loadTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffoldCad(
      title: 'Cadastro de Disciplina',
      onPressed: _save,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WTextField(
            labelText: 'Descrição',
            textEditingController: _descriptionController,
            paddingTop: 20,
          ),
          WTextField(
            labelText: 'Horas Aulas',
            textEditingController: _classHoursController,
            textInputType: TextInputType.number,
          ),
          WTextField(
            labelText: 'Número de Aulas',
            textEditingController: _numberOfClassesController,
            textInputType: TextInputType.number,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 30,
                right: 30
            ),
            child: DropdownButtonFormField<Teacher>(
              value: _teacherDefalt,
              decoration: const InputDecoration(
                labelText: 'Professor',
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  _teacherDefalt = newValue!;
                });
              },
              items: _teachers.map((Teacher teacher) {
                return DropdownMenuItem<Teacher>(
                  value: teacher,
                  child: Text(teacher.name),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget teste() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Disciplina'),
        centerTitle: true,
      ),
      body: Text(''),
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

  void _loadTeachers() async {
    TeacherHelper teacherHelper = TeacherHelper();
    _teachers = (await teacherHelper.getAll());

    setState(() {});
  }

  void _save() {
    Discipline discipline = Discipline(
      description: _descriptionController.text,
      classHours: int.parse(_classHoursController.text),
      numberOfClasses: int.parse(_numberOfClassesController.text),
      teacherId: _teacherDefalt!.id!
    );

    DisciplineHelper disciplineHelper = DisciplineHelper();
    disciplineHelper.insert(discipline);

    Navigator.pop(context);
  }
}
