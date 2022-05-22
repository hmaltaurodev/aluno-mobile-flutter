import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String frequencySqlCreate = '''
  CREATE TABLE $frequencyTable (
    $frequencyId INTEGER PRIMARY KEY AUTOINCREMENT,
    $frequencyClassroomStudent INTEGER,
    $frequencyDiscipline INTEGER,
    $frequencyLessonNumber INTEGER,
    $frequencyPresence BOOLEAN
  )
''';

const String frequencySqlSelectAll = '''
  SELECT
    $frequencyId,
    $frequencyClassroomStudent,
    $frequencyDiscipline,
    $frequencyLessonNumber,
    $frequencyPresence,
    
    $classroomStudentId,
    $classroomStudentClassroom,
    $classroomStudentStudent,
    
    $classroomId,
    $classroomCurriculumGride,
    $classroomPeriodYear,
    $classroomIsActive,
    
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
    
    $studentId,
    $studentRegistrationId,
    $studentName,
    $studentCpf,
    $studentBirthDate,
    $studentRegistrationDate,
    $studentIsActive,
    
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
  FROM $frequencyTable
  INNER JOIN $classroomStudentTable ON $classroomStudentTable.$classroomStudentId = $frequencyTable.$frequencyClassroomStudent
  INNER JOIN $classroomTable ON $classroomTable.$classroomId = $classroomStudentTable.$classroomStudentClassroom
  INNER JOIN $curriculumGrideTable ON $curriculumGrideTable.$curriculumGrideId = $classroomTable.$classroomCurriculumGride
  INNER JOIN $courseTable ON $courseTable.$courseId = $curriculumGrideTable.$curriculumGrideCourse
  INNER JOIN $studentTable ON $studentTable.$studentId = $classroomStudentTable.$classroomStudentStudent
  INNER JOIN $disciplineTable ON $disciplineTable.$disciplineId = $frequencyTable.$frequencyDiscipline
  INNER JOIN $teacherTable ON $teacherTable.$teacherId = $disciplineTable.$disciplineTeacher
''';

const String frequencySqlSelectDuplicate = '''
  SELECT COUNT(1)
  FROM $frequencyTable
  INNER JOIN $classroomStudentTable ON $classroomStudentTable.$classroomStudentId = $frequencyTable.$frequencyClassroomStudent
  WHERE $classroomStudentClassroom = ?
  AND $classroomStudentStudent = ?
  AND $frequencyDiscipline = ?
  AND $frequencyLessonNumber = ?
''';

const String frequencySqlSelectTaughtClasses = '''
  SELECT
    MIN($frequencyId),
    MIN($frequencyClassroomStudent),
    $frequencyDiscipline,
    $frequencyLessonNumber,
    MIN($frequencyPresence)
  FROM $frequencyTable
  INNER JOIN $classroomStudentTable ON $classroomStudentTable.$classroomStudentId = $frequencyTable.$frequencyClassroomStudent
  WHERE $classroomStudentClassroom = ?
  AND $frequencyDiscipline = ?
  GROUP BY $frequencyDiscipline, $frequencyLessonNumber
''';

const String frequencySqlSelectPresencesClasses = '''
  SELECT COUNT(1)
  FROM $frequencyTable
  WHERE $frequencyClassroomStudent = ?
  AND $frequencyDiscipline = ?
  AND $frequencyPresence = 1
''';

const String frequencySqlSelectById = '''
  $frequencySqlSelectAll
  WHERE $frequencyId = ?
''';

const String frequencySqlCount = '''
  SELECT COUNT(1)
  FROM $frequencyTable
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
    List frequencies = await database.rawQuery(frequencySqlSelectAll);
    return frequencies.map((e) => Frequency.fromMap(e)).toList();
  }

  Future<Frequency?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List frequencies = await database.rawQuery(
      frequencySqlSelectById, [id]
    );

    if (frequencies.isNotEmpty) {
      return Frequency.fromMap(frequencies.first);
    }

    return null;
  }

  Future<bool> isDuplicate(int? idClassroom, int? idStudent, int? idDiscipline, int? lessonNumber) async {
    Database database = await DataBase().getDatabase;
    int count = firstIntValue(
      await database.rawQuery(
        frequencySqlSelectDuplicate, [idClassroom, idStudent, idDiscipline, lessonNumber]
      )
    )!;

    return count >= 1;
  }

  Future<int> getTaughtClasses(int? idClassroom, int? idDiscipline) async {
    Database database = await DataBase().getDatabase;
    return (await database.rawQuery(
      frequencySqlSelectTaughtClasses, [idClassroom, idDiscipline]
    )).length;
  }

  Future<int> getPrecensesClasses(int? idClassroomStudent, int? idDiscipline) async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
      await database.rawQuery(
        frequencySqlSelectPresencesClasses, [idClassroomStudent, idDiscipline]
      )
    )!;
  }
}
