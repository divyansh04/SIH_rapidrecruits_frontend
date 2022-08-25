import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerClass {
  static DateFormat formatter = DateFormat('dd/MM/yyyy');

  static Future<String> selectYear(BuildContext context) async {
    String? picked = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        DateTime selectedDate = DateTime.now();
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(1940),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              selectedDate: selectedDate,
              onChanged: (DateTime dateTime) {
                Navigator.pop(context, dateTime.year.toString());
              },
            ),
          ),
        );
      },
    );

    if (picked != null) {
      return picked;
    } else {
      return '';
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    // final DateTime picked = await showDatePicker(
    //     context: context,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime(1940),
    //     lastDate: DateTime.now());
    // if (picked != null && picked != DateTime.now()) {
    //   return picked;
    // } else {
    //   return null;
    // }
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime.now());
    // if (picked != null) {
    //String formatted = formatter.format(picked);
    return picked;
    // }
    //  else {
    //   return null;
    // }
  }

  static String dateFormatterMethod(DateTime date) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formatted = formatter.format(date);
    return formatted;
  }

  static String dateFormatterMonths(DateTime date) {
    DateFormat formatter = DateFormat.yMMMMd();
    String formatted = formatter.format(date);
    return formatted;
  }
}
