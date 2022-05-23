import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class DetailDisciplinePage extends StatefulWidget {
  final Classroom classroom;
  final Student student;

  const DetailDisciplinePage({
    required this.classroom,
    required this.student,
    Key? key
  }) : super(key: key);

  @override
  State<DetailDisciplinePage> createState() => _DetailDisciplinePageState();
}

class _DetailDisciplinePageState extends State<DetailDisciplinePage> {
  final DetailDisciplineHelper _detailDisciplineHelper = DetailDisciplineHelper();

  Classroom? _classroom;
  Student? _student;
  ClassroomStudent? _classroomStudent;

  @override
  void initState() {
    super.initState();
    _classroom = widget.classroom;
    _student = widget.student;
    _loadClassroomStudent();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Disciplinas da Turma',
      body: FutureBuilder(
        future: _detailDisciplineHelper.getDetailDiscipline(_classroom!.id!, _student!.id!, _classroomStudent?.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return _createListViewBuilder(snapshot);
          }
        },
      ),
    );
  }

  Widget _createListViewBuilder(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}');
    }

    List<DetailDiscipline> detailsDisciplines = (snapshot.data as List<DetailDiscipline>);

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: detailsDisciplines.length,
      itemBuilder: (context, index) {
        return WSlidable(
          child: _createColumnFrequencysGrades(detailsDisciplines[index]),
        );
      },
    );
  }

  void _loadClassroomStudent() async {
    ClassroomStudentHelper classroomStudentHelper = ClassroomStudentHelper();
    _classroomStudent = (await classroomStudentHelper.getByClassroomStudent(_classroom!.id!, _student!.id!))!;

    setState(() {});
  }

  Widget _createColumnFrequencysGrades(DetailDiscipline detailDiscipline) {
    int presencesClasses = detailDiscipline.presencesClasses;
    int taughtClasses = detailDiscipline.taughtClasses;
    int numberOfClasses = detailDiscipline.discipline.numberOfClasses;
    double frequencyPercentual = taughtClasses == 0 ? 0 : (presencesClasses * 100) / taughtClasses;

    List<Grade> grades = detailDiscipline.grades;

    Widget lessonsTotal = Text('Total de aulas: ' + numberOfClasses.toString());
    Widget lessonsTaught = Text('Aulas ministradas: ' + taughtClasses.toString());
    Widget lessonsPresences = Text('Aulas presenciadas: ' + presencesClasses.toString());
    Widget frequency = Text('Frequência: ' + frequencyPercentual.toString() + '%');

    double gradeFirstBimester = (grades.isNotEmpty) ? grades[0].grade : 0;
    double gradeSecondBimester = (grades.length >= 2) ? grades[1].grade : 0;
    double gradesSum = gradeFirstBimester + gradeSecondBimester;
    double gradesAverage = 0;

    Widget firstBimesterGrade = Text('1º Bimestre: ' + gradeFirstBimester.toString());
    Widget secondBimesterGrade = Text('2º Bimestre: ' + gradeSecondBimester.toString());
    Widget thirdBimesterGrade = const SizedBox();
    Widget fourthBimesterGrade = const SizedBox();

    Widget status = const SizedBox();
    bool inProgress = true;

    if (_classroomStudent!.classroom.curriculumGride.academicRegime == 1) {
      gradesAverage = gradesSum / 2;
      inProgress = !(grades.length == 2);
    }
    else {
      double gradeThirdBimester = (grades.length >= 3) ? grades[2].grade : 0;
      double gradeFourthBimester = (grades.length >= 4) ? grades[3].grade : 0;
      gradesSum += (gradeThirdBimester + gradeFourthBimester);
      gradesAverage = gradesSum / 4;
      inProgress = !(grades.length == 4);

      thirdBimesterGrade = Text('3º Bimestre: ' + gradeThirdBimester.toString());
      fourthBimesterGrade = Text('4º Bimestre: ' + gradeFourthBimester.toString());
    }

    Widget averageGrade = Text('Média: ' + gradesAverage.toString());

    if (numberOfClasses != taughtClasses || inProgress) {
      status = Text(
        'Status: EM ANDAMENTO',
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.bold
        ),
      );
    }
    else {
      if (frequencyPercentual < 70 && gradesAverage < 60) {
        status = const Text(
          'Status: REPROVADO POR NOTA E FALTAS',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold
          ),
        );
      }
      else if (frequencyPercentual < 70) {
        status = const Text(
          'Status: REPROVADO POR FALTAS',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold
          ),
        );
      }
      else if (gradesAverage < 60) {
        status = const Text(
          'Status: REPROVADO POR NOTA',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold
          ),
        );
      }
      else {
        status = const Text(
          'Status: APROVADO',
          style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(detailDiscipline.discipline.toString()),
        ),
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              firstBimesterGrade,
              secondBimesterGrade,
              thirdBimesterGrade,
              fourthBimesterGrade,
              averageGrade,
            ],
          ),
        ),
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lessonsTotal,
              lessonsTaught,
              lessonsPresences,
              frequency,
            ],
          ),
        ),
        ListTile(
          title: status,
        ),
      ],
    );
  }
}
