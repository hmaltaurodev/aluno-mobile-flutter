const String curriculumGrideDisciplineTable = 'CURRICULUM_GRIDE_DISCIPLINE';
const String curriculumGrideDisciplineCurriculumGrideId = 'CURRICULUM_GRIDE';
const String curriculumGrideDisciplineDisciplineId = 'DISCIPLINE';

class CurriculumGrideDiscipline {
  int curriculumGrideId;
  int disciplineId;

  CurriculumGrideDiscipline({
    required this.curriculumGrideId,
    required this.disciplineId
  });

  factory CurriculumGrideDiscipline.fromMap(Map map) {
    return CurriculumGrideDiscipline(
      curriculumGrideId: int.parse(map[curriculumGrideDisciplineCurriculumGrideId].toString()),
      disciplineId: int.parse(map[curriculumGrideDisciplineDisciplineId].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      curriculumGrideDisciplineCurriculumGrideId: curriculumGrideId,
      curriculumGrideDisciplineDisciplineId: disciplineId
    };
  }
}
