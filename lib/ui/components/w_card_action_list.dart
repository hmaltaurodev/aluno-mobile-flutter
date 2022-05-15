import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class WCardActionList extends StatelessWidget {
  final ActionType actionType;

  const WCardActionList({
    required this.actionType,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _action(context, actionType);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Theme.of(context).primaryColor,
        elevation: 2,
        child: SizedBox(
            width: 120,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  actionType.getIcon(),
                  color: Colors.white,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                    left: 5,
                    top: 5
                  ),
                  child: Text(
                    actionType.getLabel(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  void _action(BuildContext context, ActionType actionType) {
    Widget Function(BuildContext) listPage;

    switch (actionType) {
      case ActionType.student:
        listPage = (context) => const ListStudentPage();
        break;
      case ActionType.teacher:
        listPage = (context) => const ListTeacherPage();
        break;
      case ActionType.discipline:
        listPage = (context) => const ListDisciplinePage();
        break;
      case ActionType.course:
        listPage = (context) => const ListCoursePage();
        break;
      case ActionType.curriculumGride:
        listPage = (context) => const ListCurriculumGridePage();
        break;
      default:
        listPage = (context) => const ListClassroomPage();
        break;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: listPage
        )
    );
  }
}
