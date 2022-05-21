import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
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
  final TextEditingController _periodYearController = TextEditingController();

  List<Course> _courses = List<Course>.empty();
  List<CurriculumGride> _curriculumGrides = List<CurriculumGride>.empty();
  List<Student> _students = List<Student>.empty();
  List<Student> _selectedStudents = List<Student>.empty();

  Course? _course;
  CurriculumGride? _curriculumGride;
  Student? _student;

  @override
  void initState() {
    super.initState();

    _loadLists();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Turma',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createDropdownCourses(),
          _createDropdownCurriculumsGrides(),
          WTextField(
            labelText: 'Ano Período',
            textEditingController: _periodYearController,
            textInputType: TextInputType.number,
          ),
          _createDropdownDisciplines(),
          _createListViewBuilder(),
        ],
      )
    );
  }

  void _loadLists() async {
    CourseHelper courseHelper = CourseHelper();
    StudentHelper studentHelper = StudentHelper();

    _courses = (await courseHelper.getAll());
    _students = (await studentHelper.getAll());

    setState(() {});
  }

  void _loadCurriculumsGrides(Course course) async {
    CurriculumGrideHelper curriculumGrideHelper = CurriculumGrideHelper();
    _curriculumGrides = (await curriculumGrideHelper.getByCourse(course.id!));

    setState(() {
      _course = course;
      _curriculumGride = null;
    });
  }

  void _save() async {
    Classroom classroom = Classroom(
      currriculumGride: _curriculumGride!,
      periodYear: int.parse(_periodYearController.text)
    );

    ClassroomHelper classroomHelper = ClassroomHelper();
    classroom = (await classroomHelper.insert(classroom));

    ClassroomStudentHelper classroomStudentHelper = ClassroomStudentHelper();
    for (Student student in _selectedStudents) {
      ClassroomStudent classroomStudent = ClassroomStudent(
        classroom: classroom,
        student: student
      );

      classroomStudentHelper.insert(classroomStudent);
    }

    Navigator.pop(context);
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
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Curso',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
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
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Grade Curricular',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _curriculumGride = newValue!;
          });
        },
        items: _curriculumGrides.map((CurriculumGride curriculumGride) {
          return DropdownMenuItem<CurriculumGride>(
            value: curriculumGride,
            child: Text(curriculumGride.academicYear.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownDisciplines() {
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
              decoration: const InputDecoration(
                label: WLabelInputDecoration(
                  labelText: 'Selecione os Alunos',
                ),
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
              onChanged: (newValue) {
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
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _createListViewBuilder() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: _selectedStudents.length,
        itemBuilder: (context, index) {
          return WSlidable(
            title: _selectedStudents[index].name,
            slidablesActions: _createSlidablesActions(_selectedStudents[index]),
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

  List<Widget> _createSlidablesActions(Student student) {
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

  Widget _slidable(Student student) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 2.5,
          bottom: 2.5,
          left: 30,
          right: 30
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.blueGrey.shade50,
        elevation: 0,
        child: Slidable(
          child: ListTile(
            title: Text(student.name),
          ),
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
