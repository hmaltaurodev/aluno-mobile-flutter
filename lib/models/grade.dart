const String gradeTable = 'GRADE';
const String gradeId = 'ID';
const String gradeClassroomStudentId = 'CLASSROOM_STUDENT';
const String gradeDisciplineId = 'DISCIPLINE';
const String gradeBimester = 'BIMESTER';
const String gradeGrade = 'GRADE';

class Grade {
  int? id;
  int classroomStudentId;
  int disciplineId;
  int bimester;
  double grade;

  Grade({
    this.id,
    required this.classroomStudentId,
    required this.disciplineId,
    required this.bimester,
    required this.grade
  });
}
