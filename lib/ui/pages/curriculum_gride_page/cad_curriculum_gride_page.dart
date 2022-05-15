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
  List<Discipline> _selectedDisciplines = List<Discipline>.empty();

  Course? _courseValue;
  Discipline? _disciplineValue;
  AcademicYear? _academicYear;
  AcademicRegime? _academicRegime;
  SemesterPeriod? _semesterPeriod;

  @override
  Widget build(BuildContext context) {
    return WScaffoldCad(
      title: 'Cadastro de Grade Curricular',
      onPressed: _save,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _dropdownCourses(),
          _dropdownAcademicYear(),
          _dropdownAcademicRegime(),
          _dropdownSemesterPeriod(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: _dropdownDisciplines()
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 5,
                    right: 30
                ),
                child: WElevatedButton(
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _save() {

  }

  Widget _dropdownCourses() {
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
          labelText: 'Curso',
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
            child: Text(course.description),
          );
        }).toList(),
      ),
    );
  }

  Widget _dropdownAcademicYear() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 30,
          right: 30
      ),
      child: DropdownButtonFormField<AcademicYear>(
        value: _academicYear,
        decoration: const InputDecoration(
          labelText: 'Ano Acadêmico',
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

  Widget _dropdownAcademicRegime() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 30,
          right: 30
      ),
      child: DropdownButtonFormField<AcademicRegime>(
        value: _academicRegime,
        decoration: const InputDecoration(
          labelText: 'Regime Acadêmico',
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _academicRegime = newValue!;
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

  Widget _dropdownSemesterPeriod() {
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
          decoration: const InputDecoration(
            labelText: 'Semestre Período',
            labelStyle: TextStyle(
              fontSize: 15,
            ),
          ),
          onChanged: (newValue) {
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

  Widget _dropdownDisciplines() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 30,
          right: 5
      ),
      child: DropdownButtonFormField<Discipline>(
        value: _disciplineValue,
        decoration: const InputDecoration(
          labelText: 'Selecione uma Disciplina',
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
    );
  }

  Widget _listViewBuilder() {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: _selectedDisciplines.length,
      itemBuilder: (context, index) {
        return _slidable(_selectedDisciplines[index]);
      },
    );
  }

  Widget _slidable(Discipline discipline) {
    return Slidable(
      child: ListTile(
        title: Text(discipline.description),
      ),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            icon: Icons.edit,
            label: 'Editar',
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onPressed: (context) {},
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            icon: Icons.blur_off,
            label: 'Inativar',
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onPressed: (context) {},
          ),
        ],
      ),
    );
  }
}
