import 'package:aluno_mobile_flutter/models/models.dart';

const String curriculumGrideDisciplineTable = 'CURRICULUM_GRIDE_DISCIPLINE';
const String curriculumGrideDisciplineId = 'CGD_ID';
const String curriculumGrideDisciplineCurriculumGride = 'CGD_CURRICULUM_GRIDE';
const String curriculumGrideDisciplineDiscipline = 'CGD_DISCIPLINE';

class CurriculumGrideDiscipline {
  int? id;
  CurriculumGride curriculumGride;
  Discipline discipline;

  CurriculumGrideDiscipline({
    this.id,
    required this.curriculumGride,
    required this.discipline
  });

  factory CurriculumGrideDiscipline.fromMap(Map map) {
    CurriculumGride curriculumGride = CurriculumGride.fromMap(map);
    Discipline discipline = Discipline.fromMap(map);

    return CurriculumGrideDiscipline(
      id: int.tryParse(map[curriculumGrideDisciplineId].toString()),
      curriculumGride: curriculumGride,
      discipline: discipline
    );
  }

  Map<String, dynamic> toMap() {
    return {
      curriculumGrideDisciplineId: id,
      curriculumGrideDisciplineCurriculumGride: curriculumGride.id,
      curriculumGrideDisciplineDiscipline: discipline.id
    };
  }
}
