import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class LancFrequencyPage extends StatefulWidget {
  const LancFrequencyPage({Key? key}) : super(key: key);

  @override
  State<LancFrequencyPage> createState() => _LancFrequencyPageState();
}

class _LancFrequencyPageState extends State<LancFrequencyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Course> _courses = List<Course>.empty();
  List<Classroom> _classrooms = List<Classroom>.empty();
  List<Discipline> _disciplines = List<Discipline>.empty();
  List<int> _lessonsNumbers = List<int>.empty();
  List<Student> _students = List<Student>.empty();

  Course? _course;
  Classroom? _classroom;
  Discipline? _discipline;
  int? _lessonNumber;
  bool _frequencyDuplicate = false;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Lançamento de Frequencias',
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
              _createDropdownLessonsNumbers(),
              _createListViewBuilder()
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
          _loadDisciplinesStudents(newValue!);
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
          _loadLessonsNumbers(newValue!);
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

  Widget _createDropdownLessonsNumbers() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<int>(
        value: _lessonNumber,
        validator: _validateLesson,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Aula Número',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _lessonNumber = newValue;
          });
        },
        items: _lessonsNumbers.map((int lesson) {
          return DropdownMenuItem<int>(
            value: lesson,
            child: Text(lesson.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createListViewBuilder() {
    return SizedBox(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(4),
        itemCount: _students.length,
        itemBuilder: (context, index) {
          return WCardList(
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Theme.of(context).primaryColor,
              value: _students[index].isPresent,
              title: Text(_students[index].toString()),
              onChanged: (value) {
                setState(() {
                  _students[index].isPresent = value!;
                });
              },
            ),
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

  void _save() async {
    FocusScope.of(context).unfocus();

    FrequencyHelper frequencyHelper = FrequencyHelper();
    if (_students.isNotEmpty) {
      _frequencyDuplicate = await frequencyHelper.isDuplicate(_classroom?.id, _students[0].id, _discipline?.id, _lessonNumber);
    }

    if (_formKey.currentState!.validate()) {
      ClassroomStudentHelper classroomStudentHelper = ClassroomStudentHelper();

      for (Student student in _students) {
        ClassroomStudent classroomStudent = (await classroomStudentHelper.getByClassroomStudent(_classroom!.id!, student.id!))!;

        Frequency frequency = Frequency(
          classroomStudent: classroomStudent,
          discipline: _discipline!,
          lessonNumber: _lessonNumber!,
          presence: student.isPresent ? 1 : 0
        );

        frequencyHelper.insert(frequency);
      }

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
      _lessonNumber = null;

      _classrooms = [];
      _disciplines = [];
      _lessonsNumbers = [];
      _students = [];
    });

    ClassroomHelper classroomHelper = ClassroomHelper();
    _classrooms = (await classroomHelper.getByCourse(course!.id!));

    setState(() {
      _course = course;
    });
  }

  void _loadDisciplinesStudents(Classroom? classroom) async {
    setState(() {
      _discipline = null;
      _lessonNumber = null;

      _disciplines = [];
      _lessonsNumbers = [];
      _students = [];
    });

    DisciplineHelper disciplineHelper = DisciplineHelper();
    StudentHelper studentHelper = StudentHelper();

    _disciplines = (await disciplineHelper.getByCurriculumGride(classroom!.curriculumGride.id!));
    _students = (await studentHelper.getByClassroom(classroom.id!));

    setState(() {
      _classroom = classroom;
    });
  }

  void _loadLessonsNumbers(Discipline? discipline) async {
    DisciplineHelper disciplineHelper = DisciplineHelper();
    int numberOfClasses = (await disciplineHelper.getNumberOfClasses(discipline!.id!)) ?? 0;

    setState(() {
      _lessonsNumbers = [for (int i = 1; i <= numberOfClasses; i++) i];
      _discipline = discipline;
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

  String? _validateLesson(int? lesson) {
    if (lesson == null) {
      return 'Selecione uma Aula';
    }

    if (_frequencyDuplicate) {
      return 'Essa frequência já foi lançada';
    }

    return null;
  }
}
