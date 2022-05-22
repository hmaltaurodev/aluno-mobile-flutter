import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WSlidable extends StatelessWidget {
  final String title;
  final List<Widget>? slideableActions;
  final EdgeInsets padding;

  const WSlidable({
    required this.title,
    this.slideableActions,
    this.padding = const EdgeInsets.all(5),
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.white,
        elevation: 0,
        child: Slidable(
          child: ListTile(
            title: Text(title),
          ),
          startActionPane: _createStartActionPane(),
        ),
      )
    );
  }

  ActionPane? _createStartActionPane() {
    if (slideableActions != null) {
      return ActionPane(
        motion: const DrawerMotion(),
        children: slideableActions!,
      );
    }

    return null;
  }
}
