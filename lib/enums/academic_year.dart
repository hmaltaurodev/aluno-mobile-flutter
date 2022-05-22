enum AcademicYear {
  first,
  second,
  third,
  fourth,
  fifth
}

extension AcademicYearExtension on AcademicYear {
  String getDescription() {
    switch (this) {
      case AcademicYear.first:
        return '1º Série';
      case AcademicYear.second:
        return '2º Série';
      case AcademicYear.third:
        return '3º Série';
      case AcademicYear.fourth:
        return '4º Série';
      case AcademicYear.fifth:
        return '5º Série';
    }
  }

  int toInt() {
    switch (this) {
      case AcademicYear.first:
        return 1;
      case AcademicYear.second:
        return 2;
      case AcademicYear.third:
        return 3;
      case AcademicYear.fourth:
        return 4;
      case AcademicYear.fifth:
        return 5;
    }
  }
}
