import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';

class DetailDisciplineHelper {
  Future<List<DetailDiscipline>> getDetailDiscipline(int idClassroom, int idStudent, int? idClassroomStudent) async {
    List<DetailDiscipline> detailsDisciplines = [];

    DisciplineHelper disciplineHelper = DisciplineHelper();
    FrequencyHelper frequencyHelper = FrequencyHelper();
    GradeHelper gradeHelper = GradeHelper();

    List<Discipline> disciplines = (await disciplineHelper.getAll());

    for (Discipline discipline in disciplines) {
      int taughtClasses = (await frequencyHelper.getTaughtClasses(idClassroom, discipline.id));
      int presencesClasses = (await frequencyHelper.getPrecensesClasses(idClassroomStudent, discipline.id));
      List<Grade> grades = (await gradeHelper.getByClassroomStudent(idClassroomStudent, discipline.id));

      DetailDiscipline detailDiscipline = DetailDiscipline(
        discipline: discipline,
        taughtClasses: taughtClasses,
        presencesClasses: presencesClasses,
        grades: grades
      );

      detailsDisciplines = detailsDisciplines.toList();
      detailsDisciplines.add(detailDiscipline);
    }

    return detailsDisciplines;
  }
}