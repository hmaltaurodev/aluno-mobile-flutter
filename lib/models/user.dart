const String userTable = 'USER';
const String userId = 'ID';
const String userUsername = 'USERNAME';
const String userPassword = 'PASSWORD';
const String userUserType = 'USER_TYPE';
const String userStudentId = 'STUDENT';
const String userTeacherId = 'TEACHER';
const String userIsActive = 'IS_ACTIVE';

class User {
  int? id;
  String username;
  String password;
  int userType;
  int? studentId;
  int? teacherId;
  bool isActive;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.userType,
    this.studentId,
    this.teacherId,
    this.isActive = true
  });

  factory User.fromMap(Map map) {
    return User(
      id: int.tryParse(map[userId].toString()),
      username: map[userUsername].toString(),
      password: map[userPassword].toString(),
      userType: int.parse(map[userUserType].toString()),
      studentId: int.tryParse(map[userStudentId].toString()),
      teacherId: int.tryParse(map[userTeacherId].toString()),
      isActive: map[userIsActive]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      userId: id,
      userUsername: username,
      userPassword: password,
      userUserType: userType,
      userStudentId: studentId,
      userTeacherId: teacherId,
      userIsActive: isActive
    };
  }
}
