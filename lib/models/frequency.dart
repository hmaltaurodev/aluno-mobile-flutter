const String frequencyTable = 'FREQUENCY';
const String frequencyId = 'ID';
const String frequencyClassroomStudentId = 'CLASSROOM_STUDENT';
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

  factory Frequency.fromMap(Map map) {
    return Frequency(
      id: int.tryParse(map[frequencyId].toString()),
      classroomStudentId: int.parse(map[frequencyClassroomStudentId].toString()),
      disciplineId: int.parse(map[frequencyDisciplineId].toString()),
      lessonNumber: int.parse(map[frequencyLessonNumber].toString()),
      presence: map[frequencyPresence]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      frequencyId: id,
      frequencyClassroomStudentId: classroomStudentId,
      frequencyDisciplineId: disciplineId,
      frequencyLessonNumber: lessonNumber,
      frequencyPresence: presence
    };
  }
}
