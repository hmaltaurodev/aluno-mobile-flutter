import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  final User user;

  const PasswordPage({
    required this.user,
    Key? key
  }) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Alteração de senha',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _save,
      ),
      body: Container(

      ),
    );
  }

  void _save() {

  }
}
