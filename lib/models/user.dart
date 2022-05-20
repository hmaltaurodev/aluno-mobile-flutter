import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';

const String userTable = 'USER';
const String userId = 'U_ID';
const String userUsername = 'U_USERNAME';
const String userPassword = 'U_PASSWORD';
const String userUserType = 'U_USER_TYPE';
const String userStudent = 'U_STUDENT';
const String userTeacher = 'U_TEACHER';
const String userIsActive = 'U_IS_ACTIVE';

class User {
  int? id;
  String username;
  String password;
  int userType;
  Student? student;
  Teacher? teacher;
  int isActive;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.userType,
    this.student,
    this.teacher,
    this.isActive = 1
  });

  factory User.fromMap(Map map) {
    Student? student;
    Teacher? teacher;

    if (map[studentId].toString() != 'null') {
      Student.fromMap(map);
    }

    if (map[teacherId].toString() != 'null') {
      Teacher.fromMap(map);
    }

    return User(
      id: int.tryParse(map[userId].toString()),
      username: map[userUsername].toString(),
      password: map[userPassword].toString(),
      userType: int.parse(map[userUserType].toString()),
      student: student,
      teacher: teacher,
      isActive: int.parse(map[userIsActive].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      userId: id,
      userUsername: username,
      userPassword: password,
      userUserType: userType,
      userStudent: student?.id,
      userTeacher: teacher?.id,
      userIsActive: isActive
    };
  }

  static Future<void> createDefaultUser() async {
    final UserHelper userHelper = UserHelper();

    if (await userHelper.getByUsername('admin') == null) {
      userHelper.insert(User(
          username: 'admin',
          password: Crypt.sha256('admin').toString(),
          userType: UserType.admin.toInt(),
          isActive: 1
        )
      );
    }
  }

  String getUsernameLoggedIn() {
    if (teacher?.name != null) {
      return teacher!.name.toUpperCase();
    }

    if (student?.name != null) {
      return student!.name.toUpperCase();
    }

    return username.toUpperCase();
  }

  IconData getIconLoggedIn() {
    if (teacher?.name != null) {
      return Icons.person;
    }

    if (student?.name != null) {
      return Icons.school;
    }

    return Icons.admin_panel_settings;
  }
}
