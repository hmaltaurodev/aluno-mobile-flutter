import 'package:aluno_mobile_flutter/models/models.dart';

const String frequencyTable = 'FREQUENCY';
const String frequencyId = 'F_ID';
const String frequencyClassroomStudent = 'F_CLASSROOM_STUDENT';
const String frequencyDiscipline = 'F_DISCIPLINE';
const String frequencyLessonNumber = 'F_LESSON_NUMBER';
const String frequencyPresence = 'F_PRESENCE';

class Frequency {
  int? id;
  ClassroomStudent classroomStudent;
  Discipline discipline;
  int lessonNumber;
  int presence;

  Frequency({
    this.id,
    required this.classroomStudent,
    required this.discipline,
    required this.lessonNumber,
    required this.presence
  });

  factory Frequency.fromMap(Map map) {
    ClassroomStudent classroomStudent = ClassroomStudent.fromMap(map);
    Discipline discipline = Discipline.fromMap(map);

    return Frequency(
      id: int.tryParse(map[frequencyId].toString()),
      classroomStudent: classroomStudent,
      discipline: discipline,
      lessonNumber: int.parse(map[frequencyLessonNumber].toString()),
      presence: int.parse(map[frequencyPresence].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      frequencyId: id,
      frequencyClassroomStudent: classroomStudent.id,
      frequencyDiscipline: discipline.id,
      frequencyLessonNumber: lessonNumber,
      frequencyPresence: presence
    };
  }
}
