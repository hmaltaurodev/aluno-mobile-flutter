import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CadCurriculumGridePage extends StatefulWidget {
  const CadCurriculumGridePage({Key? key}) : super(key: key);

  @override
  State<CadCurriculumGridePage> createState() => _CadCurriculumGridePageState();
}

class _CadCurriculumGridePageState extends State<CadCurriculumGridePage> {
  List<Course> _courses = List<Course>.empty();
  List<Discipline> _disciplines = List<Discipline>.empty();
  List<Discipline> _selectedDisciplines = [];

  Course? _courseValue;
  Discipline? _disciplineValue;
  AcademicYear? _academicYearValue;
  AcademicRegime? _academicRegimeValue;
  SemesterPeriod? _semesterPeriodValue;

  @override
  void initState() {
    super.initState();

    _loadLists();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Grade Curricular',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: SingleChildScrollView(
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
    );
  }

  void _loadLists() async {
    CourseHelper courseHelper = CourseHelper();
    DisciplineHelper disciplineHelper = DisciplineHelper();

    _courses = (await courseHelper.getAll());
    _disciplines = (await disciplineHelper.getAll());

    setState(() {});
  }

  void _save() async {
    CurriculumGride curriculumGride = CurriculumGride(
        course: _courseValue!,
        academicYear: _academicYearValue!.toInt(),
        academicRegime: _academicRegimeValue!.toInt(),
        semesterPeriod: _semesterPeriodValue!.toInt()
    );

    CurriculumGrideHelper curriculumGrideHelper = CurriculumGrideHelper();
    curriculumGride = (await curriculumGrideHelper.insert(curriculumGride));

    CurriculumGrideDisciplineHelper curriculumGrideDisciplineHelper = CurriculumGrideDisciplineHelper();
    for (Discipline discipline in _selectedDisciplines) {
      CurriculumGrideDiscipline curriculumGrideDiscipline = CurriculumGrideDiscipline(
        curriculumGride: curriculumGride,
        discipline: discipline
      );

      curriculumGrideDisciplineHelper.insert(curriculumGrideDiscipline);
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
        value: _courseValue,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Curso',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _courseValue = newValue!;
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
        value: _academicYearValue,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Ano Acadêmico',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _academicYearValue = newValue!;
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
        value: _academicRegimeValue,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Regime Acadêmico',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _academicRegimeValue = newValue!;
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
      visible: (_academicRegimeValue == AcademicRegime.semiannual),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 30,
            right: 30
        ),
        child: DropdownButtonFormField<SemesterPeriod>(
          value: _semesterPeriodValue,
          decoration: const InputDecoration(
            label: WLabelInputDecoration(
              labelText: 'Semestre Período',
            ),
            labelStyle: TextStyle(
              fontSize: 15,
            ),
          ),
          onChanged: (newValue) {
            setState(() {
              _semesterPeriodValue = newValue!;
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
              value: _disciplineValue,
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
                  _disciplineValue = newValue!;
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
              if (_disciplineValue != null) {
                setState(() {
                  _selectedDisciplines = _selectedDisciplines.toList();
                  _selectedDisciplines.add(_disciplineValue!);
                  _disciplines.remove(_disciplineValue!);
                  _disciplineValue = null;

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
            title: _selectedDisciplines[index].description,
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

  List<Widget> _createSlidablesActions(Discipline discipline) {
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
}
