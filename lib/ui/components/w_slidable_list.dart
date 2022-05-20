import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WSlidableList extends StatelessWidget {
  final String title;
  final void Function() functionEdit;
  final void Function() functionInactivate;

  const WSlidableList({
    required this.title,
    required this.functionEdit,
    required this.functionInactivate,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.blueGrey.shade50,
          elevation: 0,
          child: Slidable(
            child: ListTile(
              title: Text(title),
            ),
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  icon: Icons.edit,
                  label: 'Editar',
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  onPressed: (context) {
                    functionEdit;
                  },
                ),
                SlidableAction(
                  icon: Icons.blur_off,
                  label: 'Inativar',
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  onPressed: (context) {
                    functionInactivate;
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
