import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CadClassroomPage extends StatefulWidget {
  final Classroom? classroom;

  const CadClassroomPage({
    this.classroom,
    Key? key
  }) : super(key: key);

  @override
  State<CadClassroomPage> createState() => _CadClassroomPageState();
}

class _CadClassroomPageState extends State<CadClassroomPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _periodYearController = TextEditingController();

  List<Course> _courses = List<Course>.empty();
  List<CurriculumGride> _curriculumGrides = List<CurriculumGride>.empty();
  List<Student> _students = List<Student>.empty();
  List<Student> _selectedStudents = List<Student>.empty();

  Classroom? _classroom;
  Course? _course;
  CurriculumGride? _curriculumGride;
  Student? _student;

  @override
  void initState() {
    super.initState();
    _classroom = widget.classroom;
    _loadLists();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Turma',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _save,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _createDropdownCourses(),
              _createDropdownCurriculumsGrides(),
              WTextField(
                labelText: 'Ano Período',
                textEditingController: _periodYearController,
                validator: _validatePeriodYear,
                textInputType: TextInputType.number,
              ),
              _createDropdownStudents(),
              _createListViewBuilder(),
            ],
          ),
        ),
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
        onChanged: _classroom != null ? null : (newValue) {
          _loadCurriculumsGrides(newValue!);
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

  Widget _createDropdownCurriculumsGrides() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<CurriculumGride>(
        value: _curriculumGride,
        validator: _validateCurriculuGride,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Grade Curricular',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: _classroom != null ? null : (newValue) {
          setState(() {
            _curriculumGride = newValue!;
          });
        },
        items: _curriculumGrides.map((CurriculumGride curriculumGride) {
          return DropdownMenuItem<CurriculumGride>(
            value: curriculumGride,
            child: Text(curriculumGride.toStringWithoutCourse()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownStudents() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 30,
              right: 5
            ),
            child: DropdownButtonFormField<Student>(
              value: _student,
              validator: (student) {
                return _validateStudents();
              },
              decoration: const InputDecoration(
                label: WLabelInputDecoration(
                  labelText: 'Selecione os Alunos',
                ),
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
              onChanged: _classroom != null ? null : (newValue) {
                setState(() {
                  _student = newValue!;
                });
              },
              items: _students.map((Student student) {
                return DropdownMenuItem<Student>(
                  value: student,
                  child: Text(student.name),
                );
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 30
          ),
          child: WElevatedButton(
            child: const Icon(Icons.add),
            onPressed: () {
              if (_student != null) {
                setState(() {
                  _selectedStudents = _selectedStudents.toList();
                  _selectedStudents.add(_student!);
                  _students.remove(_student!);
                  _student = null;

                  FocusScope.of(context).unfocus();
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _createListViewBuilder() {
    return SizedBox(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(4),
        itemCount: _selectedStudents.length,
        itemBuilder: (context, index) {
          return WSlidable(
            child: ListTile(
              title: Text(_selectedStudents[index].name),
            ),
            slideableActions: _createSlidablesActions(_selectedStudents[index]),
            padding: const EdgeInsets.only(
              top: 2.5,
              bottom: 2.5,
              left: 30,
              right: 30
            ),
          );
        },
      ),
    );
  }

  List<Widget>? _createSlidablesActions(Student student) {
    if (_classroom == null) {
      return [
        SlidableAction(
          icon: Icons.delete,
          label: 'Remover',
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: (context) {
            setState(() {
              _students = _students.toList();
              _students.add(student);
              _selectedStudents.remove(student);
            });
          },
        ),
      ];
    }

    return null;
  }

  void _save() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ClassroomHelper classroomHelper = ClassroomHelper();

      if (_classroom == null) {
        Classroom classroom = Classroom(
          curriculumGride: _curriculumGride!,
          periodYear: int.parse(_periodYearController.text)
        );

        classroom = (await classroomHelper.insert(classroom));

        ClassroomStudentHelper classroomStudentHelper = ClassroomStudentHelper();
        for (Student student in _selectedStudents) {
          ClassroomStudent classroomStudent = ClassroomStudent(
            classroom: classroom,
            student: student
          );

          classroomStudentHelper.insert(classroomStudent);
        }
      }
      else {
        _classroom!.curriculumGride = _curriculumGride!;
        _classroom!.periodYear = int.parse(_periodYearController.text);

        classroomHelper.update(_classroom!);
      }

      Navigator.pop(context);
    }
  }

  void _loadLists() async {
    if (_classroom == null) {
      CourseHelper courseHelper = CourseHelper();
      StudentHelper studentHelper = StudentHelper();

      _courses = (await courseHelper.getAllActive());
      _students = (await studentHelper.getAllActive());
    }

    setState(() {
      _loadClassroom();
    });
  }

  void _loadClassroom() {
    if (_classroom != null) {
      _courses = [ _classroom!.curriculumGride.course ];
      _curriculumGrides = [ _classroom!.curriculumGride ];
      _students = [];

      _course = _courses.isEmpty ? _classroom?.curriculumGride.course : _courses.firstWhere((course) => course.id == _classroom?.curriculumGride.course.id);
      _curriculumGride = _curriculumGrides.isEmpty ? _classroom?.curriculumGride : _curriculumGrides.firstWhere((curriculumGride) => curriculumGride.id == _classroom?.curriculumGride.id);
      _periodYearController.text = _classroom!.periodYear.toString();
    }
  }

  void _loadCurriculumsGrides(Course course) async {
    CurriculumGrideHelper curriculumGrideHelper = CurriculumGrideHelper();
    _curriculumGrides = (await curriculumGrideHelper.getByCourse(course.id!));

    setState(() {
      _course = course;
      _curriculumGride = null;
    });
  }

  String? _validateCourse(Course? course) {
    if (course == null) {
      return 'Selecione um Curso';
    }

    return null;
  }

  String? _validateCurriculuGride(CurriculumGride? curriculumGride) {
    if (curriculumGride == null) {
      return 'Selecione uma Grade Curricular';
    }

    return null;
  }

  String? _validatePeriodYear(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o Ano Período';
    }

    if (int.parse(string) == 0) {
      return 'Informe um Ano Período valido';
    }

    return null;
  }

  String? _validateStudents() {
    if (_selectedStudents.isEmpty) {
      return 'Adicione ou menos um Aluno';
    }

    return null;
  }
}
