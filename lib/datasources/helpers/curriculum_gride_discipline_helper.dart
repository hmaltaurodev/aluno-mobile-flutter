import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String curriculumGrideDisciplineSqlCreate = '''
  CREATE TABLE $curriculumGrideDisciplineTable (
    $curriculumGrideDisciplineCurriculumGrideId INT PRIMARY KEY,
    $curriculumGrideDisciplineDisciplineId INT PRIMARY KEY
  );
''';

const String curriculumGrideDisciplineSqlCount = '''
  SELECT COUNT(*)
  FROM $curriculumGrideDisciplineTable;
''';

class CurriculumGrideDisciplineHelper {
  Future<CurriculumGrideDiscipline> insert(CurriculumGrideDiscipline curriculumGrideDiscipline) async {
    Database database = await DataBase().getDatabase;
    await database.insert(
        curriculumGrideDisciplineTable,
        curriculumGrideDiscipline.toMap()
    );
    return curriculumGrideDiscipline;
  }

  Future<int> update(CurriculumGrideDiscipline curriculumGrideDiscipline) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        curriculumGrideDisciplineTable,
        curriculumGrideDiscipline.toMap(),
        where: '$curriculumGrideDisciplineCurriculumGrideId = ?, $curriculumGrideDisciplineDisciplineId = ?',
        whereArgs: [curriculumGrideDiscipline.curriculumGrideId, curriculumGrideDiscipline.disciplineId]
    );
  }

  Future<int> delete(int curriculumGrideId, int disciplineId) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        curriculumGrideDisciplineTable,
        where: '$curriculumGrideDisciplineCurriculumGrideId = ?, $curriculumGrideDisciplineDisciplineId = ?',
        whereArgs: [curriculumGrideId, disciplineId]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(curriculumGrideDisciplineSqlCount)
    );
  }

  Future<List<CurriculumGrideDiscipline>> getAll() async {
    Database database = await DataBase().getDatabase;
    List curriculumsGridesDisciplines = await database.query(curriculumGrideDisciplineTable);
    return curriculumsGridesDisciplines.map((e) => CurriculumGrideDiscipline.fromMap(e)).toList();
  }

  Future<CurriculumGrideDiscipline?> getByCurricumGride(int curriculumGrideId) async {
    Database database = await DataBase().getDatabase;
    List curriculumsGridesDisciplines = await database.query(
        curriculumGrideDisciplineTable,
        where: '$curriculumGrideDisciplineCurriculumGrideId = ?',
        whereArgs: [curriculumGrideId]
    );

    if (curriculumsGridesDisciplines.isNotEmpty) {
      return CurriculumGrideDiscipline.fromMap(curriculumsGridesDisciplines.first);
    }

    return null;
  }

  Future<CurriculumGrideDiscipline?> getByDiscipline(int disciplineId) async {
    Database database = await DataBase().getDatabase;
    List curriculumsGridesDisciplines = await database.query(
        curriculumGrideDisciplineTable,
        where: '$curriculumGrideDisciplineDisciplineId = ?',
        whereArgs: [disciplineId]
    );

    if (curriculumsGridesDisciplines.isNotEmpty) {
      return CurriculumGrideDiscipline.fromMap(curriculumsGridesDisciplines.first);
    }

    return null;
  }
}
