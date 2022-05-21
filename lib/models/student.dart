import 'package:intl/intl.dart';

const String studentTable = 'STUDENT';
const String studentId = 'S_ID';
const String studentRegistrationId = 'S_REGISTRATION_ID';
const String studentName = 'S_NAME';
const String studentCpf = 'S_CPF';
const String studentBirthDate = 'S_BIRTH_DATE';
const String studentRegistrationDate = 'S_REGISTRATION_DATE';
const String studentIsActive = 'S_IS_ACTIVE';

class Student {
  int? id;
  int registrationId;
  String name;
  String cpf;
  DateTime birthDate;
  DateTime registrationDate;
  int isActive;
  bool isPresent = false;

  Student({
    this.id,
    required this.registrationId,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.registrationDate,
    this.isActive = 1
  });

  factory Student.fromMap(Map map) {
    return Student(
      id: int.tryParse(map[studentId].toString()),
      registrationId: int.parse(map[studentRegistrationId].toString()),
      name: map[studentName].toString(),
      cpf: map[studentCpf].toString(),
      birthDate: DateFormat('dd/MM/yyyy').parse(map[studentBirthDate].toString()),
      registrationDate: DateFormat('dd/MM/yyyy').parse(map[studentRegistrationDate].toString()),
      isActive: int.parse(map[studentIsActive].toString())
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

  @override
  String toString() {
    return registrationId.toString().padLeft(8, '0') + ' - ' + name;
  }

  String getFirstName() {
    return name.split(' ')[0];
  }
}
