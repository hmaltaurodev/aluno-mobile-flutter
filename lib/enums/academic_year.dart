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
        return '1º Ano';
      case AcademicYear.second:
        return '2º Ano';
      case AcademicYear.third:
        return '3º Ano';
      case AcademicYear.fourth:
        return '4º Ano';
      case AcademicYear.fifth:
        return '5º Ano';
      default:
        return '';
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
      default:
        return 0;
    }
  }
}
