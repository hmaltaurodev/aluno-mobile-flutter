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
  bool isActive = true;

  CurriculumGride({
    this.id,
    required this.courseId,
    required this.academicYear,
    required this.academicRegime,
    required this.semesterPeriod
  });
}