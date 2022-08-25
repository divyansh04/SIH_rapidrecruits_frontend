import 'package:flutter/material.dart';

import 'input_field.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.color,
      this.validatorError})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final Color color;

  final String? validatorError;
  @override
  Widget build(BuildContext context) {
    return InputContainer(
        color: color,
        child: TextFormField(
          controller: controller,
          cursorColor: color,
          validator: (data) {
            if (data!.isNotEmpty) {
              return null;
            } else {
              return validatorError ?? "Required Field";
            }
          },
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock, color: color),
              hintText: hint,
              border: InputBorder.none),
        ));
  }
}
