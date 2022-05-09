const String disciplineTable = 'DISCIPLINE';
const String disciplineId = 'ID';
const String disciplineDescription = 'DESCRIPTION';
const String disciplineClassHours = 'CLASS_HOURS';
const String disciplineNumberOfClasses = 'NUMBER_OF_CLASSES';
const String disciplineTeacherId = 'TEACHER';
const String disciplineIsActive = 'IS_ACTIVE';

class Discipline {
  int? id;
  String description;
  int classHours;
  int numberOfClasses;
  int teacherId;
  bool isActive = true;

  Discipline({
    this.id,
    required this.description,
    required this.classHours,
    required this.numberOfClasses,
    required this.teacherId
  });
}
