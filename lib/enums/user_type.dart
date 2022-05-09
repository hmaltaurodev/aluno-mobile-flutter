enum UserType {
  student,
  teacher,
  admin
}

extension UserTypeExtension on UserType {
  String getDescription() {
    switch (this) {
      case UserType.student:
        return 'Estudante';
      case UserType.teacher:
        return 'Professor';
      case UserType.admin:
        return 'Administrador';
      default:
        return '';
    }
  }

  int toInt() {
    switch (this) {
      case UserType.student:
        return 1;
      case UserType.teacher:
        return 2;
      case UserType.admin:
        return 3;
      default:
        return 0;
    }
  }
}
