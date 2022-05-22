import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class WCardAction extends StatelessWidget {
  final ActionType actionType;
  final EdgeInsetsGeometry padding;

  const WCardAction({
    required this.actionType,
    required this.padding,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding,
        child: GestureDetector(
          onTap: () {
            _action(context, actionType);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Colors.white,
            elevation: 0,
            child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      actionType.getIcon(),
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        left: 5,
                        top: 5
                      ),
                      child: Text(
                        actionType.getLabel(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
            ),
          ),
        )
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
      case ActionType.classroom:
        listPage = (context) => const ListClassroomPage();
        break;
      case ActionType.frequency:
        listPage = (context) => const LancFrequencyPage();
        break;
      case ActionType.grade:
        listPage = (context) => const LancGradePage();
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
