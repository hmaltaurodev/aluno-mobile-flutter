import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String classroomSqlCreate = '''
  CREATE TABLE $classroomTable (
    $classroomId INTEGER PRIMARY KEY AUTOINCREMENT,
    $classroomCurriculumGride INTEGER,
    $classroomPeriodYear INTEGER,
    $classroomIsActive BOOLEAN
  )
''';

const String classroomSqlSelectAll = '''
  SELECT
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
    $courseIsActive
  FROM $classroomTable
  INNER JOIN $curriculumGrideTable ON $curriculumGrideTable.$curriculumGrideId = $classroomTable.$classroomCurriculumGride
  INNER JOIN $courseTable ON $courseTable.$courseId = $curriculumGrideTable.$curriculumGrideCourse
''';

const String classroomSqlSelectAllActive = '''
  $classroomSqlSelectAll
  WHERE $classroomIsActive = 1
''';

const String classroomSqlSelectById = '''
  $classroomSqlSelectAllActive
  AND $classroomId = ?
''';

const String classroomSqlSelectByStudent = '''
  SELECT DISTINCT
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
    $courseIsActive
  FROM $classroomTable
  INNER JOIN $curriculumGrideTable ON $curriculumGrideTable.$curriculumGrideId = $classroomTable.$classroomCurriculumGride
  INNER JOIN $courseTable ON $courseTable.$courseId = $curriculumGrideTable.$curriculumGrideCourse
  INNER JOIN $classroomStudentTable ON $classroomStudentTable.$classroomStudentClassroom = $classroomTable.$classroomId
  WHERE $classroomStudentTable.$classroomStudentStudent = ?
''';

const String classroomSqlSelectByCourse = '''
  $classroomSqlSelectAllActive
  AND $courseId = ?
''';

const String classroomSqlCount = '''
  SELECT COUNT(1)
  FROM $classroomTable
''';

class ClassroomHelper {
  Future<Classroom> insert(Classroom classroom) async {
    Database database = await DataBase().getDatabase;
    classroom.id = await database.insert(
      classroomTable,
      classroom.toMap()
    );
    return classroom;
  }

  Future<int> update(Classroom classroom) async {
    Database database = await DataBase().getDatabase;
    return database.update(
      classroomTable,
      classroom.toMap(),
      where: '$classroomId = ?',
      whereArgs: [classroom.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
      classroomTable,
      where: '$classroomId = ?',
      whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
      await database.query(classroomSqlCount)
    );
  }

  Future<List<Classroom>> getAll() async {
    Database database = await DataBase().getDatabase;
    List classrooms = await database.rawQuery(classroomSqlSelectAll);
    return classrooms.map((e) => Classroom.fromMap(e)).toList();
  }

  Future<List<Classroom>> getAllActive() async {
    Database database = await DataBase().getDatabase;
    List classrooms = await database.rawQuery(classroomSqlSelectAllActive);
    return classrooms.map((e) => Classroom.fromMap(e)).toList();
  }

  Future<Classroom?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List classrooms = await database.rawQuery(
      classroomSqlSelectById, [id]
    );

    if (classrooms.isNotEmpty) {
      return Classroom.fromMap(classrooms.first);
    }

    return null;
  }

  Future<List<Classroom>> getByStudent(int? idStudent) async {
    Database database = await DataBase().getDatabase;
    List classrooms = await database.rawQuery(
        classroomSqlSelectByStudent, [idStudent]
    );

    return classrooms.map((e) => Classroom.fromMap(e)).toList();
  }

  Future<List<Classroom>> getByCourse(int idCourse) async {
    Database database = await DataBase().getDatabase;
    List classrooms = await database.rawQuery(
        classroomSqlSelectByCourse, [idCourse]
    );

    return classrooms.map((e) => Classroom.fromMap(e)).toList();
  }
}
