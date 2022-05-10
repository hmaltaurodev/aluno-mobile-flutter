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
  bool isActive;

  Course({
    this.id,
    required this.mecId,
    required this.description,
    required this.academicDegree,
    this.isActive = true
  });

  factory Course.fromMap(Map map) {
    return Course(
      id: int.tryParse(map[courseId].toString()),
      mecId: int.parse(map[courseMecId].toString()),
      description: map[courseDescription].toString(),
      academicDegree: int.parse(map[courseAcademicDegree].toString()),
      isActive: map[courseIsActive]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      courseId: id,
      courseMecId: mecId,
      courseDescription: description,
      courseAcademicDegree: academicDegree,
      courseIsActive: isActive
    };
  }
}
