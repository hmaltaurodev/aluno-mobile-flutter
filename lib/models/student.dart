const String studentTable = 'STUDENT';
const String studentId = 'ID';
const String studentRegistrationId = 'REGISTRATION_ID';
const String studentName = 'NAME';
const String studentCpf = 'CPF';
const String studentBirthDate = 'BIRTH_DATE';
const String studentRegistrationDate = 'REGISTRATION_DATE';
const String studentIsActive = 'IS_ACTIVE';

class Student {
  int? id;
  int registrationId;
  String name;
  String cpf;
  DateTime birthDate;
  DateTime registrationDate;
  bool isActive = true;
  bool isPresent = false;

  Student({
    this.id,
    required this.registrationId,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.registrationDate
  });
}
