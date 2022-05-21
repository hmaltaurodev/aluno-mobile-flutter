import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class LancFrequencyPage extends StatefulWidget {
  const LancFrequencyPage({Key? key}) : super(key: key);

  @override
  State<LancFrequencyPage> createState() => _LancFrequencyPageState();
}

class _LancFrequencyPageState extends State<LancFrequencyPage> {
  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Lançamento de Frequencias',
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
