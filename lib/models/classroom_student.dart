import 'package:aluno_mobile_flutter/models/models.dart';

const String classroomStudentTable = 'CLASSROOM_STUDENT';
const String classroomStudentId = 'CLS_ID';
const String classroomStudentClassroom = 'CLS_CLASSROOM';
const String classroomStudentStudent = 'CLS_STUDENT';

class ClassroomStudent {
  int? id;
  Classroom classroom;
  Student student;

  ClassroomStudent({
    this.id,
    required this.classroom,
    required this.student
  });

  factory ClassroomStudent.fromMap(Map map) {
    Classroom classroom = Classroom.fromMap(map);
    Student student = Student.fromMap(map);

    return ClassroomStudent(
      id: int.tryParse(map[classroomStudentId].toString()),
      classroom: classroom,
      student: student
    );
  }

  Map<String, dynamic> toMap() {
    return {
      classroomStudentId: id,
      classroomStudentClassroom: classroom.id,
      classroomStudentStudent: student.id
    };
  }
}
