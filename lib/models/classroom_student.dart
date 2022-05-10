const String classroomStudentTable = 'CLASSROOM_STUDENT';
const String classroomStudentClassroomId = 'CLASSROOM';
const String classroomStudentStudentId = 'STUDENT';

class ClassroomStudent {
  int classroomId;
  int studentId;

  ClassroomStudent({
    required this.classroomId,
    required this.studentId
  });

  factory ClassroomStudent.fromMap(Map map) {
    return ClassroomStudent(
      classroomId: int.parse(map[classroomStudentClassroomId].toString()),
      studentId: int.parse(map[classroomStudentStudentId].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      classroomStudentClassroomId: classroomId,
      classroomStudentStudentId: studentId
    };
  }
}
