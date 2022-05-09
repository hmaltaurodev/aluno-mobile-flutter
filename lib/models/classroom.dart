const String classroomTable = 'CLASSROOM';
const String classroomId = 'ID';
const String classroomCurriculumGrideId = 'CURRICULUM_GRIDE';
const String classroomPeriodYear = 'PERIOD_YEAR';
const String classroomIsActive = 'IS_ACTIVE';

class Classroom {
  int? id;
  int currriculumGrideId;
  int periodYear;
  bool isActive = true;

  Classroom({
    this.id,
    required this.currriculumGrideId,
    required this.periodYear
  });
}
