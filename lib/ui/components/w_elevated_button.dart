import 'package:flutter/material.dart';

class WElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final EdgeInsetsGeometry padding;

  const WElevatedButton({
    required this.onPressed,
    this.child,
    this.padding = const EdgeInsets.all(0),
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
