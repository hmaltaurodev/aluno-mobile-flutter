const String classroomTable = 'CLASSROOM';
const String classroomId = 'ID';
const String classroomCurriculumGrideId = 'CURRICULUM_GRIDE';
const String classroomPeriodYear = 'PERIOD_YEAR';
const String classroomIsActive = 'IS_ACTIVE';

class Classroom {
  int? id;
  int currriculumGrideId;
  int periodYear;
  int isActive;

  Classroom({
    this.id,
    required this.currriculumGrideId,
    required this.periodYear,
    this.isActive = 1
  });

  factory Classroom.fromMap(Map map) {
    return Classroom(
      id: int.tryParse(map[classroomId].toString()),
      currriculumGrideId: int.parse(map[classroomCurriculumGrideId].toString()),
      periodYear: int.parse(map[classroomPeriodYear].toString()),
      isActive: int.parse(map[classroomIsActive].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      classroomId: id,
      classroomCurriculumGrideId: currriculumGrideId,
      classroomPeriodYear: periodYear,
      classroomIsActive: isActive
    };
  }
}
