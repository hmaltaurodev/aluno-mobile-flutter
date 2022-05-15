import 'package:flutter/material.dart';

class WCardAction extends StatelessWidget {
  const WCardAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Theme.of(context).primaryColorLight,
        elevation: 2,
        child: SizedBox(
            width: 120,
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
    );
  }
}
