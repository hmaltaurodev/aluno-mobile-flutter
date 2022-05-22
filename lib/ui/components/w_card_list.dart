import 'package:flutter/material.dart';

class WCardList extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const WCardList({
    required this.child,
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
        child: child,
      )
  );
  }
}
