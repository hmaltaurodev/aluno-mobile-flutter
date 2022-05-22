import 'package:aluno_mobile_flutter/models/models.dart';

class DetailDiscipline {
  Discipline discipline;
  List<Grade> grades;
  int presencesClasses;
  int taughtClasses;

  DetailDiscipline({
    required this.discipline,
    required this.grades,
    required this.presencesClasses,
    required this.taughtClasses
  });
}