enum SemesterPeriod {
  first,
  second
}

extension SemesterPeriodExtension on SemesterPeriod {
  String getDescription() {
    switch (this) {
      case SemesterPeriod.first:
        return '1º Semestre';
      case SemesterPeriod.second:
        return '2º Semestre';
    }
  }

  int toInt() {
    switch (this) {
      case SemesterPeriod.first:
        return 1;
      case SemesterPeriod.second:
        return 2;
    }
  }
}
