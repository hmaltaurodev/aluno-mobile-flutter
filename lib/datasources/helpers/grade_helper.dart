import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String gradeSqlCreate = '''
  CREATE TABLE $gradeTable (
    $gradeId INTEGER PRIMARY KEY AUTOINCREMENT,
    $gradeClassroomStudentId INTEGER,
    $gradeDisciplineId INTEGER,
    $gradeBimester INTEGER,
    $gradeGrade DECIMAL(10, 2)
  );
''';

const String gradeSqlCount = '''
  SELECT COUNT(*)
  FROM $gradeTable;
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
        await database.query(gradeSqlCount)
    );
  }

  Future<List<Grade>> getAll() async {
    Database database = await DataBase().getDatabase;
    List grades = await database.query(gradeTable);
    return grades.map((e) => Grade.fromMap(e)).toList();
  }

  Future<Grade?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List grades = await database.query(
        gradeTable,
        where: '$gradeId = ?',
        whereArgs: [id]
    );

    if (grades.isNotEmpty) {
      return Grade.fromMap(grades.first);
    }

    return null;
  }
}
