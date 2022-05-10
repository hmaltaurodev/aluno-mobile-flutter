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
  
  factory Grade.fromMap(Map map) {
    return Grade(
      id: int.tryParse(map[gradeId].toString()),
      classroomStudentId: int.parse(map[gradeClassroomStudentId].toString()),
      disciplineId: int.parse(map[gradeDisciplineId].toString()),
      bimester: int.parse(map[gradeBimester].toString()),
      grade: double.parse(map[gradeGrade].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      gradeId: id,
      gradeClassroomStudentId: classroomStudentId,
      gradeDisciplineId: disciplineId,
      gradeBimester: bimester,
      gradeGrade: grade
    };
  }
}
