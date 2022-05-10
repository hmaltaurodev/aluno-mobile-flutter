const String curriculumGrideTable = 'CURRICULUM_GRIDE';
const String curriculumGrideId = 'ID';
const String curriculumGrideCourseId = 'COURSE';
const String curriculumGrideAcademicYear = 'ACADEMIC_YEAR';
const String curriculumGrideAcademicRegime = 'ACADEMIC_REGIME';
const String curriculumGrideSemesterPeriod = 'SEMESTER_PERIOD';
const String curriculumGrideIsActive = 'IS_ACTIVE';

class CurriculumGride {
  int? id;
  int courseId;
  int academicYear;
  int academicRegime;
  int semesterPeriod;
  bool isActive;

  CurriculumGride({
    this.id,
    required this.courseId,
    required this.academicYear,
    required this.academicRegime,
    required this.semesterPeriod,
    this.isActive = true
  });

  factory CurriculumGride.fromMap(Map map) {
    return CurriculumGride(
      id: int.tryParse(map[curriculumGrideId].toString()),
      courseId: int.parse(map[curriculumGrideCourseId].toString()),
      academicYear: int.parse(map[curriculumGrideAcademicYear].toString()),
      academicRegime: int.parse(map[curriculumGrideAcademicRegime].toString()),
      semesterPeriod: int.parse(map[curriculumGrideSemesterPeriod].toString()),
      isActive: map[curriculumGrideIsActive]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      curriculumGrideId: id,
      curriculumGrideCourseId: courseId,
      curriculumGrideAcademicYear: academicYear,
      curriculumGrideAcademicRegime: academicRegime,
      curriculumGrideSemesterPeriod: semesterPeriod,
      curriculumGrideIsActive: isActive
    };
  }
}
