import 'package:aluno_mobile_flutter/models/curriculum_gride.dart';

const String classroomTable = 'CLASSROOM';
const String classroomId = 'CL_ID';
const String classroomCurriculumGride = 'CL_CURRICULUM_GRIDE';
const String classroomPeriodYear = 'CL_PERIOD_YEAR';
const String classroomIsActive = 'CL_IS_ACTIVE';

class Classroom {
  int? id;
  CurriculumGride curriculumGride;
  int periodYear;
  int isActive;

  Classroom({
    this.id,
    required this.curriculumGride,
    required this.periodYear,
    this.isActive = 1
  });

  factory Classroom.fromMap(Map map) {
    CurriculumGride curriculumGride = CurriculumGride.fromMap(map);

    return Classroom(
      id: int.tryParse(map[classroomId].toString()),
      curriculumGride: curriculumGride,
      periodYear: int.parse(map[classroomPeriodYear].toString()),
      isActive: int.parse(map[classroomIsActive].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      classroomId: id,
      classroomCurriculumGride: curriculumGride.id,
      classroomPeriodYear: periodYear,
      classroomIsActive: isActive
    };
  }

  @override
  String toString() {
    return periodYear.toString() + ' - ' + curriculumGride.toStringWithoutCourse();
  }

  String toStringWithCourse() {
    return periodYear.toString() + ' - ' + curriculumGride.toString();
  }
}
