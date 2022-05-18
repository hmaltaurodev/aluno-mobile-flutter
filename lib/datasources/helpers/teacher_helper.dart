import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String teacherSqlCreate = '''
  CREATE TABLE $teacherTable (
    $teacherId INTEGER PRIMARY KEY AUTOINCREMENT,
    $teacherRegistrationId INTEGER,
    $teacherName TEXT,
    $teacherCpf TEXT,
    $teacherBirthDate TEXT,
    $teacherRegistrationDate TEXT,
    $teacherIsActive BOOLEAN
  )
''';

const String teacherSqlCount = '''
  SELECT COUNT(1)
  FROM $teacherTable
''';

class TeacherHelper {
  Future<Teacher> insert(Teacher teacher) async {
    Database database = await DataBase().getDatabase;
    teacher.id = await database.insert(
        teacherTable,
        teacher.toMap()
    );
    return teacher;
  }

  Future<int> update(Teacher teacher) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        teacherTable,
        teacher.toMap(),
        where: '$teacherId = ?',
        whereArgs: [teacher.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        teacherTable,
        where: '$teacherId = ?',
        whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(teacherSqlCount)
    );
  }

  Future<List<Teacher>> getAll() async {
    Database database = await DataBase().getDatabase;
    List teachers = await database.query(teacherTable);
    return teachers.map((e) => Teacher.fromMap(e)).toList();
  }

  Future<Teacher?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List teachers = await database.query(
        teacherTable,
        where: '$teacherId = ?',
        whereArgs: [id]
    );

    if (teachers.isNotEmpty) {
      return Teacher.fromMap(teachers.first);
    }

    return null;
  }
}
