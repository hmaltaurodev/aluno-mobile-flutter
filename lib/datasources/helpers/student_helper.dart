import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String studentSqlCreate = '''
  CREATE TABLE $studentTable (
    $studentId INTEGER PRIMARY KEY AUTOINCREMENT,
    $studentRegistrationId INTEGER,
    $studentName TEXT,
    $studentCpf TEXT,
    $studentBirthDate TEXT,
    $studentRegistrationDate TEXT,
    $studentIsActive BOOLEAN
  )
''';

const String studentSqlCount = '''
  SELECT COUNT(1)
  FROM $studentTable
''';

class StudentHelper {
  Future<Student> insert(Student student) async {
    Database database = await DataBase().getDatabase;
    student.id = await database.insert(
        studentTable,
        student.toMap()
    );
    return student;
  }

  Future<int> update(Student student) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        studentTable,
        student.toMap(),
        where: '$studentId = ?',
        whereArgs: [student.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        studentTable,
        where: '$studentId = ?',
        whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(studentSqlCount)
    );
  }

  Future<List<Student>> getAll() async {
    Database database = await DataBase().getDatabase;
    List students = await database.query(studentTable);
    return students.map((e) => Student.fromMap(e)).toList();
  }

  Future<Student?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List students = await database.query(
        studentTable,
        where: '$studentId = ?',
        whereArgs: [id]
    );

    if (students.isNotEmpty) {
      return Student.fromMap(students.first);
    }

    return null;
  }
}
