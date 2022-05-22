import 'package:aluno_mobile_flutter/datasources/database.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

const String classroomStudentSqlCreate = '''
  CREATE TABLE $classroomStudentTable (
    $classroomStudentId INTEGER PRIMARY KEY,
    $classroomStudentClassroom INTEGER,
    $classroomStudentStudent INTEGER
  )
''';

const String classroomStudentSqlSelectAll = '''
  SELECT
    $classroomStudentClassroom,
    $classroomStudentStudent,
    
    $classroomId,
    $classroomCurriculumGride,
    $classroomPeriodYear,
    $classroomIsActive,
    
    $curriculumGrideId,
    $curriculumGrideCourse,
    $curriculumGrideAcademicYear,
    $curriculumGrideAcademicRegime,
    $curriculumGrideSemesterPeriod,
    $curriculumGrideIsActive,
    
    $courseId,
    $courseMecId,
    $courseDescription,
    $courseAcademicDegree,
    $courseIsActive,
    
    $studentId,
    $studentRegistrationId,
    $studentName,
    $studentCpf,
    $studentBirthDate,
    $studentRegistrationDate,
    $studentIsActive
  FROM $classroomStudentTable
  INNER JOIN $classroomTable ON $classroomTable.$classroomId = $classroomStudentTable.$classroomStudentClassroom
  INNER JOIN $curriculumGrideTable ON $curriculumGrideTable.$curriculumGrideId = $classroomTable.$classroomCurriculumGride
  INNER JOIN $courseTable ON $courseTable.$courseId = $curriculumGrideTable.$curriculumGrideCourse
  INNER JOIN $studentTable ON $studentTable.$studentId = $classroomStudentTable.$classroomStudentStudent
''';

const String classroomStudentSqlSelectByClassroomStudent = '''
  $classroomStudentSqlSelectAll
  WHERE $classroomStudentClassroom = ?
  AND $classroomStudentStudent = ?
''';

const String classroomStudentSqlCount = '''
  SELECT COUNT(1)
  FROM $classroomStudentTable
''';

class ClassroomStudentHelper {
  Future<ClassroomStudent> insert(ClassroomStudent classroomStudent) async {
    Database database = await DataBase().getDatabase;
    await database.insert(
      classroomStudentTable,
      classroomStudent.toMap()
    );

    return classroomStudent;
  }

  Future<int> update(ClassroomStudent classroomStudent) async {
    Database database = await DataBase().getDatabase;
    return database.update(
      classroomStudentTable,
      classroomStudent.toMap(),
      where: '$classroomStudentId = ?',
      whereArgs: [classroomStudent.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
      classroomStudentTable,
      where: '$classroomStudentId = ?',
      whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
      await database.query(classroomStudentSqlCount)
    );
  }

  Future<List<ClassroomStudent>> getAll() async {
    Database database = await DataBase().getDatabase;
    List classroomsStudents = await database.rawQuery(classroomStudentSqlSelectAll);
    return classroomsStudents.map((e) => ClassroomStudent.fromMap(e)).toList();
  }

  Future<ClassroomStudent?> getByClassroomStudent(int idClassroom, int idStudent) async {
    Database database = await DataBase().getDatabase;
    List classroomsStudents = await database.rawQuery(
      classroomStudentSqlSelectByClassroomStudent, [idClassroom, idStudent]
    );

    if (classroomsStudents.isNotEmpty) {
      return ClassroomStudent.fromMap(classroomsStudents.first);
    }

    return null;
  }
}
