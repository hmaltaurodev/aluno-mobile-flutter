class Student {
  int? id;
  int registrationId;
  String name;
  String cpf;
  DateTime birthDate;
  DateTime registrationDate;
  bool isPresent = false;

  Student({
    required this.registrationId,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.registrationDate
  });
}
