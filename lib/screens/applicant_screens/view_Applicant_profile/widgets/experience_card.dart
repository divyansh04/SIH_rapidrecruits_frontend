import 'package:RapidRecruits/models/applicant_experience_details.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    Key? key,
    required this.element,
  }) : super(key: key);

  final ExperienceData element;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: kPrimaryColorApplicant),
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${element.designation}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                "${element.institute}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                "${element.fromDate} - ${element.toDate}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "${element.details}",
                style: const TextStyle(fontSize: 18),
              ),
            ]),
      ),
    );
  }
}
