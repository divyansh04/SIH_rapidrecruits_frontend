import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NonEditableRoundedInput extends StatelessWidget {
  const NonEditableRoundedInput(
      {Key? key,
        this.icon,
        required this.hint,
        required this.controller,
        required this.color,
        this.maxLines,
        this.keyboardType})
      : super(key: key);

  final IconData? icon;
  final String hint;
  final TextEditingController controller;
  final Color color;
  final int? maxLines;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$hint:",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
        Container(
            height: 52,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: Get.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color.withAlpha(50)),
            child: TextFormField(
              enabled: false,
              controller: controller,
              cursorColor: color,
              maxLines: maxLines,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  icon: Icon(icon, color: color),
                  alignLabelWithHint: true,
                  hintText: hint,
                  border: InputBorder.none),
            )),
      ],
    );
  }
}