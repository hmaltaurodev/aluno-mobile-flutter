class Discipline {
  int? id;
  String description;
  int classHours;
  int numberOfClasses;
  int teacherId;

  Discipline({
    required this.description,
    required this.classHours,
    required this.numberOfClasses,
    required this.teacherId
  });
}
