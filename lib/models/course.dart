const String courseTable = 'COURSE';
const String courseId = 'C_ID';
const String courseMecId = 'C_MEC_ID';
const String courseDescription = 'C_DESCRIPTION';
const String courseAcademicDegree = 'C_ACADEMIC_DEGREE';
const String courseIsActive = 'C_IS_ACTIVE';

class Course {
  int? id;
  int mecId;
  String description;
  int academicDegree;
  int isActive;

  Course({
    this.id,
    required this.mecId,
    required this.description,
    required this.academicDegree,
    this.isActive = 1
  });

  factory Course.fromMap(Map map) {
    return Course(
      id: int.tryParse(map[courseId].toString()),
      mecId: int.parse(map[courseMecId].toString()),
      description: map[courseDescription].toString(),
      academicDegree: int.parse(map[courseAcademicDegree].toString()),
      isActive: int.parse(map[courseIsActive].toString())
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

  @override
  String toString() {
    return mecId.toString() + ' - ' + description;
  }
}
