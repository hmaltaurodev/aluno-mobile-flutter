import 'package:intl/intl.dart';

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
  bool isActive;

  Teacher({
    this.id,
    required this.registrationId,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.registrationDate,
    this.isActive = true
  });

  factory Teacher.fromMap(Map map) {
    return Teacher(
        id: int.tryParse(map[teacherId].toString()),
        registrationId: int.parse(map[teacherRegistrarionId].toString()),
        name: map[teacherName].toString(),
        cpf: map[teacherCpf].toString(),
        birthDate: DateFormat('dd/MM/yyyy').parse(map[teacherBirthDate].toString()),
        registrationDate: DateFormat('dd/MM/yyyy').parse(map[teacherRegistrationDate].toString()),
        isActive: map[teacherIsActive]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      teacherId: id,
      teacherRegistrarionId: registrationId,
      teacherName: name,
      teacherCpf: cpf,
      teacherBirthDate: DateFormat('dd/MM/yyyy').format(birthDate),
      teacherRegistrationDate: DateFormat('dd/MM/yyyy').format(registrationDate),
      teacherIsActive: isActive
    };
  }
}
