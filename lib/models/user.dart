const String userTable = 'USER';
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
  bool isActive = true;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.userType,
    this.studentId,
    this.teacherId
  });
}
