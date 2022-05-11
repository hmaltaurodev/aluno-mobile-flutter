import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String curriculumGrideSqlCreate = '''
  CREATE TABLE $curriculumGrideTable (
    $curriculumGrideId INT PRIMARY KEY AUTOINCREMENT,
    $curriculumGrideCourseId INT,
    $curriculumGrideAcademicYear INT,
    $curriculumGrideAcademicRegime INT,
    $curriculumGrideSemesterPeriod INT,
    $curriculumGrideIsActive BOOLEAN
  );
''';

const String curriculumGrideSqlCount = '''
  SELECT COUNT(*)
  FROM $curriculumGrideTable;
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
    List curriculumsGrides = await database.query(curriculumGrideTable);
    return curriculumsGrides.map((e) => CurriculumGride.fromMap(e)).toList();
  }

  Future<CurriculumGride?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List curriculumsGrides = await database.query(
        curriculumGrideTable,
        where: '$curriculumGrideId = ?',
        whereArgs: [id]
    );

    if (curriculumsGrides.isNotEmpty) {
      return CurriculumGride.fromMap(curriculumsGrides.first);
    }

    return null;
  }
}
