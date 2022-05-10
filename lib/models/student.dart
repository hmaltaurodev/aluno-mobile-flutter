import 'package:intl/intl.dart';

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
  bool isActive;
  bool isPresent = false;

  Student({
    this.id,
    required this.registrationId,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.registrationDate,
    this.isActive = true
  });

  factory Student.fromMap(Map map) {
    return Student(
      id: int.tryParse(map[studentId].toString()),
      registrationId: int.parse(map[studentRegistrationId].toString()),
      name: map[studentName].toString(),
      cpf: map[studentCpf].toString(),
      birthDate: DateFormat('dd/MM/yyyy').parse(map[studentBirthDate].toString()),
      registrationDate: DateFormat('dd/MM/yyyy').parse(map[studentRegistrationDate].toString()),
      isActive: map[studentIsActive]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      studentId: id,
      studentRegistrationId: registrationId,
      studentName: name,
      studentCpf: cpf,
      studentBirthDate: DateFormat('dd/MM/yyyy').format(birthDate),
      studentRegistrationDate: DateFormat('dd/MM/yyyy').format(registrationDate),
      studentIsActive: isActive
    };
  }
}
