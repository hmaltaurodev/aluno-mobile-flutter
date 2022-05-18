import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String curriculumGrideDisciplineSqlCreate = '''
  CREATE TABLE $curriculumGrideDisciplineTable (
    $curriculumGrideDisciplineId INTEGER PRIMARY KEY,
    $curriculumGrideDisciplineCurriculumGride INTEGER,
    $curriculumGrideDisciplineDiscipline INTEGER
  )
''';

const String curriculumGrideDisciplineSqlSelectAll = '''
  SELECT
    $curriculumGrideDisciplineId,
    $curriculumGrideDisciplineCurriculumGride,
    $curriculumGrideDisciplineDiscipline,
    
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
    $courseIsActive,
    
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
  FROM $curriculumGrideDisciplineTable
  INNER JOIN $curriculumGrideTable ON $curriculumGrideTable.$curriculumGrideId = $curriculumGrideDisciplineTable.$curriculumGrideDisciplineCurriculumGride
  INNER JOIN $courseTable ON $courseTable.$courseId = $curriculumGrideTable.$curriculumGrideCourse
  INNER JOIN $disciplineTable ON $disciplineTable.$disciplineId = $curriculumGrideDisciplineTable.$curriculumGrideDisciplineDiscipline
  INNER JOIN $teacherTable ON $teacherTable.$teacherId = $disciplineTable.$disciplineTeacher
''';

const String curriculumGrideDisciplineSqlCount = '''
  SELECT COUNT(1)
  FROM $curriculumGrideDisciplineTable
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
        where: '$curriculumGrideDisciplineId = ?',
        whereArgs: [curriculumGrideDiscipline.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        curriculumGrideDisciplineTable,
        where: '$curriculumGrideDisciplineId = ?',
        whereArgs: [id]
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
    List curriculumsGridesDisciplines = await database.rawQuery(curriculumGrideDisciplineSqlSelectAll);
    return curriculumsGridesDisciplines.map((e) => CurriculumGrideDiscipline.fromMap(e)).toList();
  }
}
