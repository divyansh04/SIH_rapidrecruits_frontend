import 'package:flutter/material.dart';

class ReusableRadioButton extends StatelessWidget {
  final String title;
  final Function(String?) onpressed;
  final String groupValue;
  final Color color;

  const ReusableRadioButton(
      {Key? key,
      required this.title,
      required this.onpressed,
      required this.groupValue,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: color,
          value: title,
          groupValue: groupValue,
          onChanged: onpressed,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black45),
        )
      ],
    );
  }
}
