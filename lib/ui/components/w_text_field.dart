import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final bool readOnly;
  final String? Function(String?)? validator;
  final int? maxLenght;

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
    this.readOnly = false,
    this.validator,
    this.maxLenght,
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
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textEditingController,
        keyboardType: textInputType,
        inputFormatters: _setInputFormatters(textInputType),
        maxLength: maxLenght,
        obscureText: obscureText,
        decoration: InputDecoration(
          counterText: '',
          prefixIcon: prefixIcon,
          label: WLabelInputDecoration(
            labelText: labelText
          ),
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
        ),
        readOnly: readOnly,
      ),
    );
  }

  List<TextInputFormatter>? _setInputFormatters(TextInputType textInputType) {
    if (textInputType == TextInputType.number) {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ];
    }

    return null;
  }
}
