import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:crypt/crypt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:aluno_mobile_flutter/datasources/database.dart';

const String userSqlCreate = '''
  CREATE TABLE $userTable (
    $userId INTEGER PRIMARY KEY AUTOINCREMENT,
    $userUsername TEXT UNIQUE,
    $userPassword TEXT,
    $userUserType INTEGER,
    $userStudent INTEGER NULL,
    $userTeacher INTEGER NULL,
    $userIsActive BOOLEAN
  )
''';

const String userSqlSelectAll = '''
  SELECT
    $userId,
    $userUsername,
    $userPassword,
    $userUserType,
    $userStudent,
    $userTeacher,
    $userIsActive,
    
    $studentId,
    $studentRegistrationId,
    $studentName,
    $studentCpf,
    $studentBirthDate,
    $studentRegistrationDate,
    $studentIsActive,
    
    $teacherId,
    $teacherRegistrationId,
    $teacherName,
    $teacherCpf,
    $teacherBirthDate,
    $teacherRegistrationDate,
    $teacherIsActive
  FROM $userTable
  LEFT JOIN $studentTable ON $studentTable.$studentId = $userTable.$userStudent
  LEFT JOIN $teacherTable ON $teacherTable.$teacherId = $userTable.$userTeacher
''';

const String userSqlSelectById = '''
  $userSqlSelectAll
  WHERE $userId = ?
''';

const String userSqlSelectByUsername = '''
  $userSqlSelectAll
  WHERE $userUsername = ?
''';

const String userSqlCount = '''
  SELECT COUNT(1)
  FROM $userTable
''';

class UserHelper {
  Future<User> insert(User user) async {
    Database database = await DataBase().getDatabase;
    user.id = await database.insert(
        userTable,
        user.toMap()
    );

    return user;
  }

  Future<int> update(User user) async {
    Database database = await DataBase().getDatabase;
    return database.update(
        userTable,
        user.toMap(),
        where: '$userId = ?',
        whereArgs: [user.id]
    );
  }

  Future<int> delete(int id) async {
    Database database = await DataBase().getDatabase;
    return database.delete(
        userTable,
        where: '$userId = ?',
        whereArgs: [id]
    );
  }

  Future<int?> count() async {
    Database database = await DataBase().getDatabase;
    return firstIntValue(
        await database.query(userSqlCount)
    );
  }

  Future<List<User>> getAll() async {
    Database database = await DataBase().getDatabase;
    List users = await database.rawQuery(userSqlSelectAll);
    return users.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List users = await database.rawQuery(
        userSqlSelectById, [id]
    );

    if (users.isNotEmpty) {
      return User.fromMap(users.first);
    }

    return null;
  }

  Future<User?> getByUsername(String username) async {
    Database database = await DataBase().getDatabase;
    List users = await database.rawQuery(
        userSqlSelectByUsername, [username]
    );

    if (users.isNotEmpty) {
      return User.fromMap(users.first);
    }

    return null;
  }

  Future<User?> getByLogin(String username, String password) async {
    Database database = await DataBase().getDatabase;
    List users = await database.rawQuery(
        userSqlSelectByUsername, [username]
    );

    if (users.isNotEmpty && Crypt(User.fromMap(users.first).password).match(password)) {
      return User.fromMap(users.first);
    }

    return null;
  }
}
