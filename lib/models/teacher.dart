const String teacherTable = 'TEACHER';
const String teacherId = 'ID';
const String teacherRegistrarionId = 'REGISTRATION_ID';
const String teacherName = 'NAME';
const String teacherCpf = 'CPF';
const String teacherBirthDate = 'BIRTH_DATE';
const String teacherRegistrationDate = 'REGISTRATION_DATE';
const String teacherIsActive = 'IS_ACTIVE';

class Teacher {
  int? id;
  int registrationId;
  String name;
  String cpf;
  DateTime birthDate;
  DateTime registrationDate;
  bool isActive = true;

  Teacher({
    this.id,
    required this.registrationId,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.registrationDate
  });
}
