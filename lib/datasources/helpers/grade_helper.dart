import 'dart:developer';

import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String gradeSqlCreate = '''
  CREATE TABLE $gradeTable (
    $gradeId INTEGER PRIMARY KEY AUTOINCREMENT,
    $gradeClassroomStudent INTEGER,
    $gradeDiscipline INTEGER,
    $gradeBimester INTEGER,
    $gradeGrade DECIMAL(10, 2)
  )
''';

const String gradeSqlSelectAll = '''
  SELECT
    $gradeId,
    $gradeClassroomStudent,
    $gradeDiscipline,
    $gradeBimester,
    $gradeGrade,
    
    $classroomStudentId,
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
    $studentIsActive,
    
    $disciplineId,
    $disciplineDescription,
    $disciplineClassHours,
    $disciplineNumberOfClasses,
    $disciplineTeacher,
    $disciplineIsActive,
    
    $teacherId,
    $teacherRegistrationId,
    $teacherName,
    $teacherCpf,
    $teacherBirthDate,
    $teacherRegistrationDate,
    $teacherIsActive
  FROM $gradeTable
  INNER JOIN $classroomStudentTable ON $classroomStudentTable.$classroomStudentId = $gradeTable.$gradeClassroomStudent
  INNER JOIN $classroomTable ON $classroomTable.$classroomId = $classroomStudentTable.$classroomStudentClassroom
  INNER JOIN $curriculumGrideTable ON $curriculumGrideTable.$curriculumGrideId = $classroomTable.$classroomCurriculumGride
  INNER JOIN $courseTable ON $courseTable.$courseId = $curriculumGrideTable.$curriculumGrideCourse
  INNER JOIN $studentTable ON $studentTable.$studentId = $classroomStudentTable.$classroomStudentStudent
  INNER JOIN $disciplineTable ON $disciplineTable.$disciplineId = $gradeTable.$gradeDiscipline
  INNER JOIN $teacherTable ON $teacherTable.$teacherId = $disciplineTable.$disciplineTeacher
''';

const String gradeSqlSelectDuplicate = '''
  SELECT COUNT(1)
  FROM $gradeTable
  INNER JOIN $classroomStudentTable ON $classroomStudentTable.$classroomStudentId = $gradeTable.$gradeClassroomStudent
  WHERE $classroomStudentClassroom = ?
  AND $classroomStudentStudent = ?
  AND $gradeDiscipline = ?
  AND $gradeBimester = ?
''';

const String gradeSqlSelectStudentGrades = '''
  $gradeSqlSelectAll
  WHERE $gradeClassroomStudent = ?
  AND $gradeDiscipline = ?
  ORDER BY $gradeBimester ASC
''';

const String gradeSqlSelectById = '''
  $gradeSqlSelectAll
  WHERE $gradeId = ?
''';

const String gradeSqlCount = '''
  SELECT COUNT(1)
  FROM $gradeTable
''';

class GradeHelper {
  Future<Grade> insert(Grade grade) async {
    Database database = await DataBase().getDatabase;
    grade.id = await database.insert(
      gradeTable,
      grade.toMap()
    );

    return grade;
  }

  Future<int> update(Grade grade) async {
    Database database = await DataBase().getDatabase;
    return database.update(
      gradeTable,
      grade.toMap(),
      where: '$gradeId = ?',
      whereArgs: [grade.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
      gradeTable,
      where: '$gradeId = ?',
      whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
      await database.rawQuery(gradeSqlCount)
    );
  }

  Future<List<Grade>> getAll() async {
    Database database = await DataBase().getDatabase;
    List grades = await database.rawQuery(gradeSqlSelectAll);
    return grades.map((e) => Grade.fromMap(e)).toList();
  }

  Future<Grade?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List grades = await database.rawQuery(
      gradeSqlSelectById, [id]
    );

    if (grades.isNotEmpty) {
      return Grade.fromMap(grades.first);
    }

    return null;
  }

  Future<bool> isDuplicate(int? idClassroom, int? idStudent, int? idDiscipline, int? bimester) async {
    Database database = await DataBase().getDatabase;
    int count = firstIntValue(
      await database.rawQuery(
        gradeSqlSelectDuplicate, [idClassroom, idStudent, idDiscipline, bimester]
      )
    )!;

    return count >= 1;
  }

  Future<List<Grade>> getByClassroomStudent(int? idClassroomStudent, int? idDiscipline) async {
    Database database = await DataBase().getDatabase;
    List grades = await database.rawQuery(
      gradeSqlSelectStudentGrades, [idClassroomStudent, idDiscipline]
    );

    return grades.map((e) => Grade.fromMap(e)).toList();
  }
}
