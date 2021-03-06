import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class WScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  const WScaffold({
    required this.title,
    required this.body,
    this.floatingActionButton,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WAnnotatedRegion(
      scaffold: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.blueGrey.shade50,
            foregroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          body: body,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}
