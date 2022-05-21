import 'package:flutter/material.dart';

enum ActionType {
  student,
  teacher,
  discipline,
  course,
  curriculumGride,
  classroom,
  classroomDetails,
  frequency,
  grade
}

extension ActionTypeExtension on ActionType {
  String getLabel() {
    switch (this) {
      case ActionType.student:
        return 'Aluno';
      case ActionType.teacher:
        return 'Professor';
      case ActionType.discipline:
        return 'Disciplina';
      case ActionType.course:
        return 'Curso';
      case ActionType.curriculumGride:
        return 'Grade Curricular';
      case ActionType.classroom:
        return 'Turma';
      case ActionType.classroomDetails:
        return 'Detalhes da Turma';
      case ActionType.frequency:
        return 'Frequencia';
      case ActionType.grade:
        return 'Notas';
    }
  }

  IconData getIcon() {
    switch (this) {
      case ActionType.student:
        return Icons.school;
      case ActionType.teacher:
        return Icons.person;
      case ActionType.discipline:
        return Icons.science;
      case ActionType.course:
        return Icons.class_;
      case ActionType.curriculumGride:
        return Icons.grid_view;
      case ActionType.classroom:
      case ActionType.classroomDetails:
        return Icons.people;
      case ActionType.frequency:
        return Icons.checklist_sharp;
      case ActionType.grade:
        return Icons.grade;
    }
  }
}
