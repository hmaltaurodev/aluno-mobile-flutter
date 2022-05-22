import 'dart:developer';

import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/bimester.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class LancGradePage extends StatefulWidget {
  const LancGradePage({Key? key}) : super(key: key);

  @override
  State<LancGradePage> createState() => _LancGradePageState();
}

class _LancGradePageState extends State<LancGradePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _gradeController = TextEditingController();

  List<Course> _courses = List<Course>.empty();
  List<Classroom> _classrooms = List<Classroom>.empty();
  List<Discipline> _disciplines = List<Discipline>.empty();
  List<Student> _students = List<Student>.empty();
  List<Bimester> _bimesters = List<Bimester>.empty();

  Course? _course;
  Classroom? _classroom;
  Discipline? _discipline;
  Student? _student;
  Bimester? _bimester;
  bool _gradeDuplicate = false;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Lançamento de Notas',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _save,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _createDropdownCourses(),
              _createDropdownClassrooms(),
              _createDropdownDisciplines(),
              _createDropdownStudents(),
              _createDropdownBimesters(),
              WTextField(
                labelText: 'Nota',
                textEditingController: _gradeController,
                validator: _validateGrade,
                textInputType: TextInputType.number,
                maxLenght: 3,
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _createDropdownCourses() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<Course>(
        value: _course,
        validator: _validateCourse,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Curso',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          _loadClassrooms(newValue!);
        },
        items: _courses.map((Course course) {
          return DropdownMenuItem<Course>(
            value: course,
            child: Text(course.description),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownClassrooms() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<Classroom>(
        value: _classroom,
        validator: _validateClassroom,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Turma',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          _loadDisciplinesStudentsBimester(newValue!);
        },
        items: _classrooms.map((Classroom classroom) {
          return DropdownMenuItem<Classroom>(
            value: classroom,
            child: Text(classroom.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownDisciplines() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<Discipline>(
        value: _discipline,
        validator: _validateDiscipline,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Disciplina',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _discipline = newValue;
          });
        },
        items: _disciplines.map((Discipline discipline) {
          return DropdownMenuItem<Discipline>(
            value: discipline,
            child: Text(discipline.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownStudents() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<Student>(
        value: _student,
        validator: _validateStudent,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Aluno',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _student = newValue;
          });
        },
        items: _students.map((Student student) {
          return DropdownMenuItem<Student>(
            value: student,
            child: Text(student.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownBimesters() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<Bimester>(
        value: _bimester,
        validator: _validateBimester,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Bimestre',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _bimester = newValue;
          });
        },
        items: _bimesters.map((Bimester bimester) {
          return DropdownMenuItem<Bimester>(
            value: bimester,
            child: Text(bimester.getDescription()),
          );
        }).toList(),
      ),
    );
  }

  void _save() async {
    FocusScope.of(context).unfocus();

    GradeHelper gradeHelper = GradeHelper();
    _gradeDuplicate = await gradeHelper.isDuplicate(_classroom?.id, _student?.id, _discipline?.id, _bimester?.toInt());

    if (_formKey.currentState!.validate()) {
      ClassroomStudentHelper classroomStudentHelper = ClassroomStudentHelper();
      ClassroomStudent classroomStudent = (await classroomStudentHelper.getByClassroomStudent(_classroom!.id!, _student!.id!))!;

      Grade grade = Grade(
        classroomStudent: classroomStudent,
        discipline: _discipline!,
        bimester: _bimester!.toInt(),
        grade: double.parse(_gradeController.text)
      );

      gradeHelper.insert(grade);
      Navigator.pop(context);
    }
  }

  void _loadCourses() async {
    CourseHelper courseHelper = CourseHelper();
    _courses = (await courseHelper.getAllActive());

    setState(() {});
  }

  void _loadClassrooms(Course? course) async {
    setState(() {
      _classroom = null;
      _discipline = null;
      _student = null;
      _bimester = null;

      _classrooms = [];
      _disciplines = [];
      _students = [];
      _bimesters = [];
    });

    ClassroomHelper classroomHelper = ClassroomHelper();
    _classrooms = (await classroomHelper.getByCourse(course!.id!));

    setState(() {
      _course = course;
    });
  }

  void _loadDisciplinesStudentsBimester(Classroom? classroom) async {
    setState(() {
      _discipline = null;
      _student = null;
      _bimester = null;

      _disciplines = [];
      _students = [];
      _bimesters = [];
    });

    DisciplineHelper disciplineHelper = DisciplineHelper();
    StudentHelper studentHelper = StudentHelper();

    _disciplines = (await disciplineHelper.getByCurriculumGride(classroom!.curriculumGride.id!));
    _students = (await studentHelper.getByClassroom(classroom.id!));

    setState(() {
      _classroom = classroom;

      if (classroom.curriculumGride.academicRegime == 1) {
        _bimesters = [
          Bimester.first,
          Bimester.second
        ];
      }
      else {
        _bimesters = Bimester.values;
      }
    });
  }

  String? _validateCourse(Course? course) {
    if (course == null) {
      return 'Selecione um Curso';
    }

    return null;
  }

  String? _validateClassroom(Classroom? classroom) {
    if (classroom == null) {
      return 'Selecione uma Turma';
    }

    if (_students.isEmpty) {
      return 'A Turma não tem Alunos ativos';
    }

    return null;
  }

  String? _validateDiscipline(Discipline? discipline) {
    if (discipline == null) {
      return 'Selecione uma Disciplina';
    }

    return null;
  }

  String? _validateStudent(Student? student) {
    if (student == null) {
      return 'Selecione um Aluno';
    }

    return null;
  }

  String? _validateBimester(Bimester? bimester) {
    if (bimester == null) {
      return 'Selecione um Bimestre';
    }

    return null;
  }

  String? _validateGrade(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe a Nota';
    }

    if (int.parse(string) > 100) {
      return 'Informe uma Nota valida';
    }

    if (_gradeDuplicate) {
      return 'Essa nota já foi lançada';
    }

    return null;
  }
}
