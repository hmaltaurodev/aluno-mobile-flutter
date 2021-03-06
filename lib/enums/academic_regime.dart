enum AcademicRegime {
  semiannual,
  yearly
}

extension AcademicRegimeExtension on AcademicRegime {
  String getDescription() {
    switch (this) {
      case AcademicRegime.semiannual:
        return 'Semestral';
      case AcademicRegime.yearly:
        return 'Anual';
    }
  }

  int toInt() {
    switch (this) {
      case AcademicRegime.semiannual:
        return 1;
      case AcademicRegime.yearly:
        return 2;
    }
  }
}
