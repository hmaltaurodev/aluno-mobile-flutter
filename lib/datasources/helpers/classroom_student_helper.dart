import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String classroomStudentSqlCreate = '''
  CREATE TABLE $classroomStudentTable (
    $classroomStudentClassroomId INT PRIMARY KEY,
    $classroomStudentStudentId INT PRIMARY KEY
  );
''';

const String classroomStudentSqlCount = '''
  SELECT COUNT(*)
  FROM $classroomStudentTable;
''';

class ClassroomStudentHelper {
  Future<ClassroomStudent> insert(ClassroomStudent classroomStudent) async {
    Database database = await DataBase().getDatabase;
    await database.insert(
        classroomStudentTable,
        classroomStudent.toMap()
    );
    return classroomStudent;
  }

  Future<int> update(ClassroomStudent classroomStudent) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        classroomStudentTable,
        classroomStudent.toMap(),
        where: '$classroomStudentClassroomId = ?, $classroomStudentStudentId = ?',
        whereArgs: [classroomStudent.classroomId, classroomStudent.studentId]
    );
  }

  Future<int> delete(int classroomId, int studentId) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        classroomStudentTable,
        where: '$classroomStudentClassroomId = ?, $classroomStudentStudentId = ?',
        whereArgs: [classroomId, studentId]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(classroomStudentSqlCount)
    );
  }

  Future<List<ClassroomStudent>> getAll() async {
    Database database = await DataBase().getDatabase;
    List classroomsStudents = await database.query(classroomStudentTable);
    return classroomsStudents.map((e) => ClassroomStudent.fromMap(e)).toList();
  }

  Future<ClassroomStudent?> getByClassroom(int classroomId) async {
    Database database = await DataBase().getDatabase;
    List classroomsStudents = await database.query(
        classroomStudentTable,
        where: '$classroomStudentClassroomId = ?',
        whereArgs: [classroomId]
    );

    if (classroomsStudents.isNotEmpty) {
      return ClassroomStudent.fromMap(classroomsStudents.first);
    }

    return null;
  }

  Future<ClassroomStudent?> getByStudent(int studentId) async {
    Database database = await DataBase().getDatabase;
    List classroomsStudents = await database.query(
        classroomStudentTable,
        where: '$classroomStudentStudentId = ?',
        whereArgs: [studentId]
    );

    if (classroomsStudents.isNotEmpty) {
      return ClassroomStudent.fromMap(classroomsStudents.first);
    }

    return null;
  }
}
