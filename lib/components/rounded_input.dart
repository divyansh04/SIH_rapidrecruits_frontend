import 'package:flutter/material.dart';

import 'input_field.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput(
      {Key? key,
      this.icon,
      required this.hint,
      required this.controller,
      required this.color,
      this.validatorError,
      this.maxLines,
      this.keyboardType,
      this.initialValue})
      : super(key: key);

  final IconData? icon;
  final String? validatorError;
  final String hint;
  final TextEditingController controller;
  final Color color;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return InputContainer(
        color: color,
        child: TextFormField(
          controller: controller,
          cursorColor: color,
          initialValue: initialValue,
          maxLines: maxLines,
          validator: (data) {
            if (data!.isNotEmpty) {
              return null;
            } else {
              return validatorError ?? "Required Field";
            }
          },
          keyboardType: keyboardType,
          decoration: InputDecoration(
              icon: Icon(icon, color: color),
              alignLabelWithHint: true,
              hintText: hint,
              border: InputBorder.none),
        ));
  }
}
