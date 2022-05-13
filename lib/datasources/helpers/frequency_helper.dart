import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String frequencySqlCreate = '''
  CREATE TABLE $frequencyTable (
    $frequencyId INTEGER PRIMARY KEY AUTOINCREMENT,
    $frequencyClassroomStudentId INTEGER,
    $frequencyDisciplineId INTEGER,
    $frequencyLessonNumber INTEGER,
    $frequencyPresence BOOLEAN
  );
''';

const String frequencySqlCount = '''
  SELECT COUNT(*)
  FROM $frequencyTable;
''';

class FrequencyHelper {
  Future<Frequency> insert(Frequency frequency) async {
    Database database = await DataBase().getDatabase;
    frequency.id = await database.insert(
        frequencyTable,
        frequency.toMap()
    );
    return frequency;
  }

  Future<int> update(Frequency frequency) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        frequencyTable,
        frequency.toMap(),
        where: '$frequencyId = ?',
        whereArgs: [frequency.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        frequencyTable,
        where: '$frequencyId = ?',
        whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(frequencySqlCount)
    );
  }

  Future<List<Frequency>> getAll() async {
    Database database = await DataBase().getDatabase;
    List frequencies = await database.query(frequencyTable);
    return frequencies.map((e) => Frequency.fromMap(e)).toList();
  }

  Future<Frequency?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List frequencies = await database.query(
        frequencyTable,
        where: '$frequencyId = ?',
        whereArgs: [id]
    );

    if (frequencies.isNotEmpty) {
      return Frequency.fromMap(frequencies.first);
    }

    return null;
  }
}
