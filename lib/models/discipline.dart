import 'package:aluno_mobile_flutter/models/models.dart';

const String disciplineTable = 'DISCIPLINE';
const String disciplineId = 'D_ID';
const String disciplineDescription = 'D_DESCRIPTION';
const String disciplineClassHours = 'D_CLASS_HOURS';
const String disciplineNumberOfClasses = 'D_NUMBER_OF_CLASSES';
const String disciplineTeacher = 'D_TEACHER';
const String disciplineIsActive = 'D_IS_ACTIVE';

class Discipline {
  int? id;
  String description;
  int classHours;
  int numberOfClasses;
  Teacher teacher;
  int isActive;

  Discipline({
    this.id,
    required this.description,
    required this.classHours,
    required this.numberOfClasses,
    required this.teacher,
    this.isActive = 1
  });

  factory Discipline.fromMap(Map map) {
    Teacher teacher = Teacher.fromMap(map);

    return Discipline(
      id: int.tryParse(map[disciplineId].toString()),
      description: map[disciplineDescription].toString(),
      classHours: int.parse(map[disciplineClassHours].toString()),
      numberOfClasses: int.parse(map[disciplineNumberOfClasses].toString()),
      teacher: teacher,
      isActive: int.parse(map[disciplineIsActive].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      disciplineId: id,
      disciplineDescription: description,
      disciplineClassHours: classHours,
      disciplineNumberOfClasses: numberOfClasses,
      disciplineTeacher: teacher.id,
      disciplineIsActive: isActive
    };
  }
}
