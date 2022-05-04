class Grade {
  int? id;
  int classroomStudentId;
  int disciplineId;
  int bimester;
  double grade;

  Grade({
    required this.classroomStudentId,
    required this.disciplineId,
    required this.bimester,
    required this.grade
  });
}
