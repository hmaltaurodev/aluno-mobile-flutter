import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CadCurriculumGridePage extends StatefulWidget {
  final CurriculumGride? curriculumGride;

  const CadCurriculumGridePage({
    this.curriculumGride,
    Key? key
  }) : super(key: key);

  @override
  State<CadCurriculumGridePage> createState() => _CadCurriculumGridePageState();
}

class _CadCurriculumGridePageState extends State<CadCurriculumGridePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Course> _courses = List<Course>.empty();
  List<Discipline> _disciplines = List<Discipline>.empty();
  List<Discipline> _selectedDisciplines = [];

  CurriculumGride? _curriculumGride;
  Course? _course;
  Discipline? _discipline;
  AcademicYear? _academicYear;
  AcademicRegime? _academicRegime;
  SemesterPeriod? _semesterPeriod;
  bool _curriculumGrideDuplicate = false;

  @override
  void initState() {
    super.initState();
    _curriculumGride = widget.curriculumGride;
    _loadLists();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Grade Curricular',
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
              _createDropdownAcademicYear(),
              _createDropdownAcademicRegime(),
              _createDropdownSemesterPeriod(),
              _createDropdownDisciplines(),
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
        onChanged: _curriculumGride != null ? null : (newValue) {
          setState(() {
            _course = newValue!;
          });
        },
        items: _courses.map((Course course) {
          return DropdownMenuItem<Course>(
            value: course,
            child: Text(course.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownAcademicYear() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<AcademicYear>(
        value: _academicYear,
        validator: _validateAcademicYear,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Série Acadêmica',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _academicYear = newValue!;
          });
        },
        items: AcademicYear.values.map((AcademicYear academicYear) {
          return DropdownMenuItem<AcademicYear>(
            value: academicYear,
            child: Text(academicYear.getDescription()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownAcademicRegime() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30
      ),
      child: DropdownButtonFormField<AcademicRegime>(
        value: _academicRegime,
        validator: _validateAcademicRegime,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Regime Acadêmico',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: _curriculumGride != null ? null : (newValue) {
          setState(() {
            _academicRegime = newValue!;
            _semesterPeriod = null;
          });
        },
        items: AcademicRegime.values.map((AcademicRegime academicRegime) {
          return DropdownMenuItem<AcademicRegime>(
            value: academicRegime,
            child: Text(academicRegime.getDescription()),
          );
        }).toList(),
      ),
    );
  }

  Widget _createDropdownSemesterPeriod() {
    return Visibility(
      visible: (_academicRegime == AcademicRegime.semiannual),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 30,
          right: 30
        ),
        child: DropdownButtonFormField<SemesterPeriod>(
          value: _semesterPeriod,
          validator: _validateSemesterPeriod,
          decoration: const InputDecoration(
            label: WLabelInputDecoration(
              labelText: 'Semestre Período',
            ),
            labelStyle: TextStyle(
              fontSize: 15,
            ),
          ),
          onChanged: _curriculumGride != null ? null : (newValue) {
            setState(() {
              _semesterPeriod = newValue!;
            });
          },
          items: SemesterPeriod.values.map((SemesterPeriod semesterPeriod) {
            return DropdownMenuItem<SemesterPeriod>(
              value: semesterPeriod,
              child: Text(semesterPeriod.getDescription()),
            );
          }).toList(),
        ),
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
            child: DropdownButtonFormField<Discipline>(
              value: _discipline,
              validator: (discipline) {
                return _validateDisciplines();
              },
              decoration: const InputDecoration(
                label: WLabelInputDecoration(
                  labelText: 'Selecione as Disciplinas',
                ),
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  _discipline = newValue!;
                });
              },
              items: _disciplines.map((Discipline discipline) {
                return DropdownMenuItem<Discipline>(
                  value: discipline,
                  child: Text(discipline.description),
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
              if (_discipline != null) {
                setState(() {
                  _selectedDisciplines = _selectedDisciplines.toList();
                  _selectedDisciplines.add(_discipline!);
                  _disciplines.remove(_discipline!);
                  _discipline = null;

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
        itemCount: _selectedDisciplines.length,
        itemBuilder: (context, index) {
          return WSlidable(
            child: ListTile(
              title: Text(_selectedDisciplines[index].description),
            ),
            slideableActions: _createSlidablesActions(_selectedDisciplines[index]),
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

  List<Widget>? _createSlidablesActions(Discipline discipline) {
    if (_curriculumGride == null) {
      return [
        SlidableAction(
          icon: Icons.delete,
          label: 'Remover',
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: (context) {
            setState(() {
              _disciplines = _disciplines.toList();
              _disciplines.add(discipline);
              _selectedDisciplines.remove(discipline);
            });
          },
        ),
      ];
    }

    return null;
  }

  void _save() async {
    FocusScope.of(context).unfocus();

    CurriculumGrideHelper curriculumGrideHelper = CurriculumGrideHelper();
    _curriculumGrideDuplicate = (await curriculumGrideHelper.isDuplicate(_course?.id, _academicYear?.toInt(), _academicRegime?.toInt(), _semesterPeriod?.toInt() ?? 0));

    if (_formKey.currentState!.validate()) {
      if (_curriculumGride == null) {
        CurriculumGride curriculumGride = CurriculumGride(
          course: _course!,
          academicYear: _academicYear!.toInt(),
          academicRegime: _academicRegime!.toInt(),
          semesterPeriod: _semesterPeriod?.toInt() ?? 0
        );

        curriculumGride = (await curriculumGrideHelper.insert(curriculumGride));

        CurriculumGrideDisciplineHelper curriculumGrideDisciplineHelper = CurriculumGrideDisciplineHelper();
        for (Discipline discipline in _selectedDisciplines) {
          CurriculumGrideDiscipline curriculumGrideDiscipline = CurriculumGrideDiscipline(
            curriculumGride: curriculumGride,
            discipline: discipline
          );

          curriculumGrideDisciplineHelper.insert(curriculumGrideDiscipline);
        }
      }
      else {
        _curriculumGride!.course = _course!;
        _curriculumGride!.academicYear = _academicYear!.toInt();
        _curriculumGride!.academicRegime = _academicRegime!.toInt();
        _curriculumGride!.semesterPeriod = _semesterPeriod?.toInt() ?? 0;

        curriculumGrideHelper.update(_curriculumGride!);
      }

      Navigator.pop(context);
    }
  }

  void _loadLists() async {
    if (_curriculumGride == null) {
      CourseHelper courseHelper = CourseHelper();
      DisciplineHelper disciplineHelper = DisciplineHelper();

      _courses = (await courseHelper.getAllActive());
      _disciplines = (await disciplineHelper.getAllActive());
    }

    setState(() {
      _loadCurriculumGride();
    });
  }

  void _loadCurriculumGride() async {
    if (_curriculumGride != null) {
      _disciplines = [];
      _courses = [ _curriculumGride!.course ];

      _course = _courses.isEmpty ? _curriculumGride?.course : _courses.firstWhere((course) => course.id == _curriculumGride?.course.id);
      _academicYear = Utils.academicYearByInt(_curriculumGride!.academicYear.toInt());
      _academicRegime = Utils.academicRegimeByInt(_curriculumGride!.academicRegime.toInt());
      _semesterPeriod = Utils.semesterPeriodByInt(_curriculumGride!.semesterPeriod.toInt());
    }
  }

  String? _validateCourse(Course? course) {
    if (course == null) {
      return 'Selecione um Curso';
    }

    if (_curriculumGrideDuplicate) {
      return 'Já existe uma grade ativa para esse Curso, Série e Regime Acadêmico';
    }

    return null;
  }

  String? _validateAcademicYear(AcademicYear? academicYear) {
    if (academicYear == null) {
      return 'Selecione uma Série Acadêmica';
    }

    return null;
  }

  String? _validateAcademicRegime(AcademicRegime? academicRegime) {
    if (academicRegime == null) {
      return 'Selecione um Regime Acadêmico';
    }

    return null;
  }

  String? _validateSemesterPeriod(SemesterPeriod? semesterPeriod) {
    if (_academicRegime == null && semesterPeriod == null) {
      return 'Selecione um Semestre Perído';
    }

    return null;
  }

  String? _validateDisciplines() {
    if (_selectedDisciplines.isEmpty) {
      return 'Adicione ou menos uma Disciplina';
    }

    return null;
  }
}
