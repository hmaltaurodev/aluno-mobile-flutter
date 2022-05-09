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
}
