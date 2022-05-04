class Frequency {
  int? id;
  int classroomStudentId;
  int disciplineId;
  int lessonNumber;
  bool presence = false;

  Frequency({
    required this.classroomStudentId,
    required this.disciplineId,
    required this.lessonNumber
  });
}
