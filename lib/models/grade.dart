import 'package:aluno_mobile_flutter/models/classroom_student.dart';
import 'package:aluno_mobile_flutter/models/discipline.dart';

const String gradeTable = 'GRADE';
const String gradeId = 'G_ID';
const String gradeClassroomStudent = 'G_CLASSROOM_STUDENT';
const String gradeDiscipline = 'G_DISCIPLINE';
const String gradeBimester = 'G_BIMESTER';
const String gradeGrade = 'G_GRADE';

class Grade {
  int? id;
  ClassroomStudent classroomStudent;
  Discipline discipline;
  int bimester;
  double grade;

  Grade({
    this.id,
    required this.classroomStudent,
    required this.discipline,
    required this.bimester,
    required this.grade
  });
  
  factory Grade.fromMap(Map map) {
    ClassroomStudent classroomStudent = ClassroomStudent.fromMap(map);
    Discipline discipline = Discipline.fromMap(map);

    return Grade(
      id: int.tryParse(map[gradeId].toString()),
      classroomStudent: classroomStudent,
      discipline: discipline,
      bimester: int.parse(map[gradeBimester].toString()),
      grade: double.parse(map[gradeGrade].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      gradeId: id,
      gradeClassroomStudent: classroomStudent.id,
      gradeDiscipline: discipline.id,
      gradeBimester: bimester,
      gradeGrade: grade
    };
  }
}
