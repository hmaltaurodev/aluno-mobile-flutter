const String frequencyTable = 'FREQUENCY';
const String frequencyId = 'ID';
const String frequencyDisciplineId = 'DISCIPLINE';
const String frequencyLessonNumber = 'LESSON_NUMBER';
const String frequencyPresence = 'PRESENCE';

class Frequency {
  int? id;
  int classroomStudentId;
  int disciplineId;
  int lessonNumber;
  bool presence;

  Frequency({
    this.id,
    required this.classroomStudentId,
    required this.disciplineId,
    required this.lessonNumber,
    required this.presence
  });
}
