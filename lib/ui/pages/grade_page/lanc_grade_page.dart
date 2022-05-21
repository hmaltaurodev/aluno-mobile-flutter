import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class LancGradePage extends StatefulWidget {
  const LancGradePage({Key? key}) : super(key: key);

  @override
  State<LancGradePage> createState() => _LancGradePageState();
}

class _LancGradePageState extends State<LancGradePage> {
  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Lançamento de Notas',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }

  void _save() {

  }
}
