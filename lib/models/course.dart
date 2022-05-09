const String courseTable = 'COURSE';
const String courseId = 'ID';
const String courseMecId = 'MEC_ID';
const String courseDescription = 'DESCRIPTION';
const String courseAcademicDegree = 'ACADEMIC_DEGREE';
const String courseIsActive = 'IS_ACTIVE';

class Course {
  int? id;
  int mecId;
  String description;
  int academicDegree;
  bool isActive = true;

  Course({
    this.id,
    required this.mecId,
    required this.description,
    required this.academicDegree
  });
}
