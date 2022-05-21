import 'package:flutter/material.dart';

class WLabelInputDecoration extends StatelessWidget {
  final String labelText;

  const WLabelInputDecoration({
    required this.labelText,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(labelText),
      ),
    );
  }
}
