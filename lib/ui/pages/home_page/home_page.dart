import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

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
  Teacher? _teacher;
  Student? _student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Row(
                              children: const [
                                Icon(Icons.password),
                                SizedBox(width: 10),
                                Text('Mudar senha'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: const [
                                Icon(Icons.logout),
                                SizedBox(width: 10),
                                Text('Logout'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: const [
                                Icon(Icons.info_outline),
                                SizedBox(width: 10),
                                Text('Sobre'),
                              ],
                            ),
                          ),
                        ],
                        icon: const Icon(
                          Icons.settings,
                          size: 30,
                          color: Colors.white,
                        ),
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
                          _getIconLoggedIn(),
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Olá, ' + _getUsernameLoggedIn(),
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
            visible: widget.user.isActive == 1,
            child: SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: 6,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  return WCardActionList(actionType: ActionType.values.elementAt(index));
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.user.isActive != 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Theme.of(context).primaryColorLight,
                    elevation: 2,
                    child: SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.school),
                            Text(
                                'Aluno'
                            )
                          ],
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      height: 120,
                      child: Row(
                        children: const [
                          WCardAction(),
                          SizedBox(width: 10),
                          WCardAction()
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getUsernameLoggedIn() {
    if (_teacher?.name != null) {
      return _teacher!.name.toUpperCase();
    }

    if (_student?.name != null) {
      return _student!.name.toUpperCase();
    }

    return widget.user.username.toUpperCase();
  }

  IconData _getIconLoggedIn() {
    if (_teacher?.name != null) {
      return Icons.person;
    }

    if (_student?.name != null) {
      return Icons.school;
    }

    return Icons.admin_panel_settings;
  }
}
