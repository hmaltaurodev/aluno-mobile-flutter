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
    $userStudentId INTEGER NULL,
    $userTeacherId INTEGER NULL,
    $userIsActive BOOLEAN
  );
''';

const String userSqlCount = '''
  SELECT COUNT(*)
  FROM $userTable;
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
    List users = await database.query(userTable);
    return users.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getById(int id) async {
    Database database = await DataBase().getDatabase;
    List users = await database.query(
        userTable,
        where: '$userId = ?',
        whereArgs: [id]
    );

    if (users.isNotEmpty) {
      return User.fromMap(users.first);
    }

    return null;
  }

  Future<User?> getByUsername(String username) async {
    Database database = await DataBase().getDatabase;
    List users = await database.query(
        userTable,
        where: '$userUsername = ?',
        whereArgs: [username]
    );

    if (users.isNotEmpty) {
      return User.fromMap(users.first);
    }

    return null;
  }

  Future<User?> getByLogin(String username, String password) async {
    Database database = await DataBase().getDatabase;
    List users = await database.query(
        userTable,
        where: '$userUsername = ?',
        whereArgs: [username]
    );

    if (users.isNotEmpty && Crypt(User.fromMap(users.first).password).match(password)) {
      return User.fromMap(users.first);
    }

    return null;
  }
}
