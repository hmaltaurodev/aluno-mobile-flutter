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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                        icon: const Icon(
                          Icons.settings,
                          size: 30,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'change_password',
                            child: Row(
                              children: const [
                                Icon(Icons.password),
                                SizedBox(width: 10),
                                Text('Mudar senha'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'about',
                            child: Row(
                              children: const [
                                Icon(Icons.info_outline),
                                SizedBox(width: 10),
                                Text('Sobre'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'logout',
                            child: Row(
                              children: const [
                                Icon(Icons.logout),
                                SizedBox(width: 10),
                                Text('Logout'),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (result) {
                          _onSelectedPopup(result);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          _user!.getIconLoggedIn(),
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Olá, ' + _user!.getUsernameLoggedIn(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.user.userType == 3,
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
                          right: 5
                      ),
                    ),
                    WCardAction(
                      actionType: ActionType.classroom,
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 10
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
