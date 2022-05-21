import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class WTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final TextInputType textInputType;
  final Icon? prefixIcon;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final bool obscureText;

  const WTextField({
    required this.textEditingController,
    required this.labelText,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.paddingTop = 10,
    this.paddingBottom = 10,
    this.paddingLeft = 30,
    this.paddingRight = 30,
    this.obscureText = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
          left: paddingLeft,
          right: paddingRight
      ),
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          label: WLabelInputDecoration(
            labelText: labelText
          ),
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
