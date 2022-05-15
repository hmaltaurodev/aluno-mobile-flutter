enum AcademicDegree {
  bachelor,
  technological,
  graduation,
  specialization,
  master,
  doctorate
}

extension AcademicDegreeExtension on AcademicDegree {
  String getDescription() {
    switch (this) {
      case AcademicDegree.bachelor:
        return 'Bacharel';
      case AcademicDegree.technological:
        return 'Tecnólogo';
      case AcademicDegree.graduation:
        return 'Graduação';
      case AcademicDegree.specialization:
        return 'Especialização';
      case AcademicDegree.master:
        return 'Mestrado';
      case AcademicDegree.doctorate:
        return 'Doutorado';
    }
  }

  int toInt() {
    switch (this) {
      case AcademicDegree.bachelor:
        return 1;
      case AcademicDegree.technological:
        return 2;
      case AcademicDegree.graduation:
        return 3;
      case AcademicDegree.specialization:
        return 4;
      case AcademicDegree.master:
        return 5;
      case AcademicDegree.doctorate:
        return 6;
    }
  }
}
