import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({
    required this.user,
    Key? key
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return WAnnotatedRegion(
      scaffold: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.blueGrey.shade50,
          actions: [
            _createPopupMenuButton(),
          ],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  _user!.getIconLoggedIn(),
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Olá, ' + _user!.getUsernameLoggedIn(),
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.user.userType == 3,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          WCardAction(
                            actionType: ActionType.student,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 5
                            ),
                          ),
                          WCardAction(
                            actionType: ActionType.teacher,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 5,
                                right: 10
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          WCardAction(
                            actionType: ActionType.discipline,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 5
                            ),
                          ),
                          WCardAction(
                            actionType: ActionType.course,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 5,
                                right: 10
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          WCardAction(
                            actionType: ActionType.curriculumGride,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 10,
                                bottom: 10,
                                right: 5
                            ),
                          ),
                          WCardAction(
                            actionType: ActionType.classroom,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 5,
                                bottom: 10,
                                right: 10
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.user.userType != 3,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      WCardAction(
                        actionType: ActionType.frequency,
                        padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 5
                        ),
                      ),
                      WCardAction(
                        actionType: ActionType.grade,
                        padding: EdgeInsets.only(
                            top: 10,
                            left: 5,
                            right: 10
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: widget.user.userType == 1,
                child: Expanded(
                  child: SingleChildScrollView(

                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _createPopupMenuButton() {
    return PopupMenuButton(
      icon: Icon(
        Icons.settings,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'change_password',
          child: Row(
            children: [
              Icon(
                Icons.password,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 10),
              Text(
                'Mudar senha',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'about',
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 10),
              Text(
                'Sobre',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 10),
              Text(
                'Sair',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (result) {
        _onSelectedPopup(result);
      },
    );
  }

  void _onSelectedPopup(Object? result) async {
    if (result == 'change_password') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PasswordPage(user: _user!)
          )
      );
    }
    else if (result == 'about') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AboutPage()
          )
      );
    }
    else if (result == 'logout') {
      await (await SharedPreferences.getInstance()).remove('user_logged_in');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage()
          )
      );
    }
  }
}
