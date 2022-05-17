import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String classroomSqlCreate = '''
  CREATE TABLE $classroomTable (
    $classroomId INTEGER PRIMARY KEY AUTOINCREMENT,
    $classroomCurriculumGrideId INTEGER,
    $classroomPeriodYear INTEGER,
    $classroomIsActive BOOLEAN
  );
''';

const String classroomSqlCount = '''
  SELECT COUNT(*)
  FROM $classroomTable;
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
    List classrooms = await database.rawQuery(classroomTable);
    return classrooms.map((e) => Classroom.fromMap(e)).toList();
  }

  Future<Classroom?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List classrooms = await database.query(
      classroomTable,
      where: '$classroomId = ?',
      whereArgs: [id]
    );

    if (classrooms.isNotEmpty) {
      return Classroom.fromMap(classrooms.first);
    }

    return null;
  }
}
