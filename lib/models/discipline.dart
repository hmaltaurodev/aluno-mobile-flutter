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
  int isActive;

  Discipline({
    this.id,
    required this.description,
    required this.classHours,
    required this.numberOfClasses,
    required this.teacherId,
    this.isActive = 1
  });

  factory Discipline.fromMap(Map map) {
    return Discipline(
      id: int.tryParse(map[disciplineId].toString()),
      description: map[disciplineDescription].toString(),
      classHours: int.parse(map[disciplineClassHours].toString()),
      numberOfClasses: int.parse(map[disciplineNumberOfClasses].toString()),
      teacherId: int.parse(map[disciplineTeacherId].toString()),
      isActive: int.parse(map[disciplineIsActive].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      disciplineId: id,
      disciplineDescription: description,
      disciplineClassHours: classHours,
      disciplineNumberOfClasses: numberOfClasses,
      disciplineTeacherId: teacherId,
      disciplineIsActive: isActive
    };
  }
}
