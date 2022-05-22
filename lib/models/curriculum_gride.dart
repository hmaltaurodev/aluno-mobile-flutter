import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';

const String curriculumGrideTable = 'CURRICULUM_GRIDE';
const String curriculumGrideId = 'CG_ID';
const String curriculumGrideCourse = 'CG_COURSE';
const String curriculumGrideAcademicYear = 'CG_ACADEMIC_YEAR';
const String curriculumGrideAcademicRegime = 'CG_ACADEMIC_REGIME';
const String curriculumGrideSemesterPeriod = 'CG_SEMESTER_PERIOD';
const String curriculumGrideIsActive = 'CG_IS_ACTIVE';

class CurriculumGride {
  int? id;
  Course course;
  int academicYear;
  int academicRegime;
  int semesterPeriod;
  int isActive;

  CurriculumGride({
    this.id,
    required this.course,
    required this.academicYear,
    required this.academicRegime,
    required this.semesterPeriod,
    this.isActive = 1
  });

  factory CurriculumGride.fromMap(Map map) {
    Course course = Course.fromMap(map);

    return CurriculumGride(
      id: int.tryParse(map[curriculumGrideId].toString()),
      course: course,
      academicYear: int.parse(map[curriculumGrideAcademicYear].toString()),
      academicRegime: int.parse(map[curriculumGrideAcademicRegime].toString()),
      semesterPeriod: int.parse(map[curriculumGrideSemesterPeriod].toString()),
      isActive: int.parse(map[curriculumGrideIsActive].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      curriculumGrideId: id,
      curriculumGrideCourse: course.id,
      curriculumGrideAcademicYear: academicYear,
      curriculumGrideAcademicRegime: academicRegime,
      curriculumGrideSemesterPeriod: semesterPeriod,
      curriculumGrideIsActive: isActive
    };
  }

  @override
  String toString() {
    return toStringNoCourse() + ' - ' + course.description;
  }

  String toStringNoCourse() {
    if (semesterPeriod != 0) {
      return academicYear.toString() + '/' + semesterPeriod.toString();
    }

    return academicYear.toString();
  }
}
