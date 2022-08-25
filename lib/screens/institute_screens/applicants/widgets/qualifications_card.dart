import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/qualification_details.dart';

class ApplicantQualificationCard extends StatelessWidget {
  const ApplicantQualificationCard({
    Key? key,
    required this.element,
  }) : super(key: key);

  final QualificationDetails element;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: kPrimaryColorInstitute),
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        width: Get.width * 0.6,
        height: 150,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text(
                    "Course: ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "${element.qualificationTitle}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Institute: ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "${element.institute}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Year of passing: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )),
                  Text(
                    "${element.passingYear}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Percentage: ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "${element.marks}%",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
