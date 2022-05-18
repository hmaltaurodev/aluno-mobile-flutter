import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String disciplineSqlCreate = '''
  CREATE TABLE $disciplineTable (
    $disciplineId INTEGER PRIMARY KEY AUTOINCREMENT,
    $disciplineDescription TEXT,
    $disciplineClassHours INTEGER,
    $disciplineNumberOfClasses INTEGER,
    $disciplineTeacher INTEGER,
    $disciplineIsActive BOOLEAN
  )
''';

const String disciplineSqlSelectAll = '''
  SELECT
    $disciplineId,
    $disciplineDescription,
    $disciplineClassHours,
    $disciplineNumberOfClasses,
    $disciplineTeacher,
    $disciplineIsActive,
    
    $teacherId,
    $teacherRegistrationId,
    $teacherName,
    $teacherCpf,
    $teacherBirthDate,
    $teacherRegistrationDate,
    $teacherIsActive
  FROM $disciplineTable
  INNER JOIN $teacherTable ON $teacherTable.$teacherId = $disciplineTable.$disciplineTeacher
''';

const String disciplineSqlSelectById = '''
  $disciplineSqlSelectAll
  WHERE $disciplineId = ?
''';

const String disciplineSqlCount = '''
  SELECT COUNT(1)
  FROM $disciplineTable
''';

class DisciplineHelper {
  Future<Discipline> insert(Discipline discipline) async {
    Database database = await DataBase().getDatabase;
    discipline.id = await database.insert(
        disciplineTable,
        discipline.toMap()
    );
    return discipline;
  }

  Future<int> update(Discipline discipline) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        disciplineTable,
        discipline.toMap(),
        where: '$disciplineId = ?',
        whereArgs: [discipline.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        disciplineTable,
        where: '$disciplineId = ?',
        whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(disciplineSqlCount)
    );
  }

  Future<List<Discipline>> getAll() async {
    Database database = await DataBase().getDatabase;
    List disciplines = await database.rawQuery(disciplineSqlSelectAll);
    return disciplines.map((e) => Discipline.fromMap(e)).toList();
  }

  Future<Discipline?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List disciplines = await database.rawQuery(
        disciplineSqlSelectById, [id]
    );

    if (disciplines.isNotEmpty) {
      return Discipline.fromMap(disciplines.first);
    }

    return null;
  }
}
