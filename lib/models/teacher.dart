import 'package:intl/intl.dart';

const String teacherTable = 'TEACHER';
const String teacherId = 'ID';
const String teacherRegistrationId = 'REGISTRATION_ID';
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
  int isActive;

  Teacher({
    this.id,
    required this.registrationId,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.registrationDate,
    this.isActive = 1
  });

  factory Teacher.fromMap(Map map) {
    return Teacher(
        id: int.tryParse(map[teacherId].toString()),
        registrationId: int.parse(map[teacherRegistrationId].toString()),
        name: map[teacherName].toString(),
        cpf: map[teacherCpf].toString(),
        birthDate: DateFormat('dd/MM/yyyy').parse(map[teacherBirthDate].toString()),
        registrationDate: DateFormat('dd/MM/yyyy').parse(map[teacherRegistrationDate].toString()),
        isActive: int.parse(map[teacherIsActive].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      teacherId: id,
      teacherRegistrationId: registrationId,
      teacherName: name,
      teacherCpf: cpf,
      teacherBirthDate: DateFormat('dd/MM/yyyy').format(birthDate),
      teacherRegistrationDate: DateFormat('dd/MM/yyyy').format(registrationDate),
      teacherIsActive: isActive
    };
  }
}
