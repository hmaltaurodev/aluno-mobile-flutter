import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String curriculumGrideSqlCreate = '''
  CREATE TABLE $curriculumGrideTable (
    $curriculumGrideId INTEGER PRIMARY KEY AUTOINCREMENT,
    $curriculumGrideCourse INTEGER,
    $curriculumGrideAcademicYear INTEGER,
    $curriculumGrideAcademicRegime INTEGER,
    $curriculumGrideSemesterPeriod INTEGER,
    $curriculumGrideIsActive BOOLEAN
  )
''';

const String curriculumGrideSqlSelectAll = '''
  SELECT
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
  FROM $curriculumGrideTable
  INNER JOIN $courseTable ON $courseTable.$courseId = $curriculumGrideTable.$curriculumGrideCourse  
''';

const String curriculumGrideSqlSelectById = '''
  $curriculumGrideSqlSelectAll
  WHERE $curriculumGrideId = ?
''';

const String curriculumGrideSqlSelectByCourse = '''
  $curriculumGrideSqlSelectAll
  WHERE $curriculumGrideCourse = ?
''';

const String curriculumGrideSqlCount = '''
  SELECT COUNT(1)
  FROM $curriculumGrideTable
''';

class CurriculumGrideHelper {
  Future<CurriculumGride> insert(CurriculumGride curriculumGride) async {
    Database database = await DataBase().getDatabase;
    curriculumGride.id = await database.insert(
        curriculumGrideTable,
        curriculumGride.toMap()
    );
    return curriculumGride;
  }

  Future<int> update(CurriculumGride curriculumGride) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        curriculumGrideTable,
        curriculumGride.toMap(),
        where: '$curriculumGrideId = ?',
        whereArgs: [curriculumGride.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        curriculumGrideTable,
        where: '$curriculumGrideId = ?',
        whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(curriculumGrideSqlCount)
    );
  }

  Future<List<CurriculumGride>> getAll() async {
    Database database = await DataBase().getDatabase;
    List curriculumsGrides = await database.rawQuery(curriculumGrideSqlSelectAll);
    return curriculumsGrides.map((e) => CurriculumGride.fromMap(e)).toList();
  }

  Future<CurriculumGride?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List curriculumsGrides = await database.rawQuery(
        curriculumGrideSqlSelectById, [id]
    );

    if (curriculumsGrides.isNotEmpty) {
      return CurriculumGride.fromMap(curriculumsGrides.first);
    }

    return null;
  }

  Future<List<CurriculumGride>> getByCourse(int courseId) async {
    Database database = await DataBase().getDatabase;
    List curriculumsGrides = await database.rawQuery(
        curriculumGrideSqlSelectByCourse, [courseId]
    );
    return curriculumsGrides.map((e) => CurriculumGride.fromMap(e)).toList();
  }
}
