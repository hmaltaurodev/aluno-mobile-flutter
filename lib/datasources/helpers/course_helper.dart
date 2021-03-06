import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String courseSqlCreate = '''
  CREATE TABLE $courseTable (
    $courseId INTEGER PRIMARY KEY AUTOINCREMENT,
    $courseMecId INTEGER,
    $courseDescription TEXT,
    $courseAcademicDegree INTEGER,
    $courseIsActive BOOLEAN
  )
''';

const String courseSqlSelectAll = '''
  SELECT
    $courseId,
    $courseMecId,
    $courseDescription,
    $courseAcademicDegree,
    $courseIsActive
  FROM $courseTable
''';

const String courseSqlSelectAllActive = '''
  $courseSqlSelectAll
  WHERE $courseIsActive = 1
''';

const String courseSqlSelectById = '''
  $courseSqlSelectAllActive
  AND $courseId = 1
''';

const String courseSqlCount = '''
  SELECT COUNT(1)
  FROM $courseTable
''';

class CourseHelper {
  Future<Course> insert(Course course) async {
    Database database = await DataBase().getDatabase;
    course.id = await database.insert(
        courseTable,
        course.toMap()
    );
    return course;
  }

  Future<int> update(Course course) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        courseTable,
        course.toMap(),
        where: '$courseId = ?',
        whereArgs: [course.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        courseTable,
        where: '$courseId = ?',
        whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(courseSqlCount)
    );
  }

  Future<List<Course>> getAll() async {
    Database database = await DataBase().getDatabase;
    List courses = await database.query(courseTable);
    return courses.map((e) => Course.fromMap(e)).toList();
  }

  Future<List<Course>> getAllActive() async {
    Database database = await DataBase().getDatabase;
    List courses = await database.rawQuery(courseSqlSelectAllActive);
    return courses.map((e) => Course.fromMap(e)).toList();
  }

  Future<Course?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List courses = await database.rawQuery(
        courseSqlSelectById, [id]
    );

    if (courses.isNotEmpty) {
      return Course.fromMap(courses.first);
    }

    return null;
  }
}
