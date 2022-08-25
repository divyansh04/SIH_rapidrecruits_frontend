import 'package:RapidRecruits/components/non_editable_rounded_field.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/models/VacancyModel.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'controller/applicant_history_controller.dart';

class AppliedVacancyDetails extends StatefulWidget {
  final VacancyModel details;
  const AppliedVacancyDetails({Key? key, required this.details})
      : super(key: key);

  @override
  State<AppliedVacancyDetails> createState() => _AppliedVacancyDetailsState();
}

class _AppliedVacancyDetailsState extends State<AppliedVacancyDetails> {
  final controller = GetIt.I<ApplicantHistoryController>();

  @override
  Widget build(BuildContext context) {
    controller.title.text = widget.details.title!;
    controller.type.text = widget.details.type!;
    controller.experience.text = widget.details.experience!;
    controller.compensation.text = widget.details.compensation!.toString();
    controller.description.text = widget.details.description!;
    controller.qualification.text = widget.details.qualifications!;
    controller.responsibilities.text = widget.details.responsibilities!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Vacancy Details'),
        backgroundColor: kPrimaryColorApplicant,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NonEditableRoundedInput(
                  icon: Icons.title,
                  hint: 'Title',
                  controller: controller.title,
                  color: kPrimaryColorApplicant),
              NonEditableRoundedInput(
                  icon: Icons.type_specimen_outlined,
                  hint: 'Type',
                  controller: controller.type,
                  color: kPrimaryColorApplicant),
              NonEditableRoundedInput(
                  icon: Icons.date_range_outlined,
                  hint: 'Experience',
                  controller: controller.experience,
                  color: kPrimaryColorApplicant),
              NonEditableRoundedInput(
                  icon: Icons.monetization_on_outlined,
                  hint: "Compensation",
                  keyboardType: TextInputType.number,
                  controller: controller.compensation,
                  color: kPrimaryColorApplicant),
              NonEditableRoundedInput(
                  icon: Icons.description_outlined,
                  hint: 'Description',
                  maxLines: 3,
                  controller: controller.description,
                  color: kPrimaryColorApplicant),
              NonEditableRoundedInput(
                  icon: Icons.list_alt,
                  hint: 'Responsibilities',
                  controller: controller.responsibilities,
                  color: kPrimaryColorApplicant),
              NonEditableRoundedInput(
                  icon: Icons.grading,
                  hint: 'Qualifications',
                  controller: controller.qualification,
                  color: kPrimaryColorApplicant),
              widget.details.skills!.isEmpty
                  ? Container()
                  : Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      children: List<Widget>.generate(
                          widget.details.skills!.length, (index) {
                        return Chip(
                          padding: const EdgeInsets.all(8),
                          deleteIconColor: Colors.white,
                          backgroundColor: kPrimaryColorApplicant,
                          label: Text(
                            widget.details.skills![index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          onDeleted: () {
                            setState(() {
                              widget.details.skills!.removeAt(index);
                            });
                          },
                        );
                      }),
                    ),
              // const SizedBox(height: 20),
              // MaterialButton(
              //   height: 55,
              //   onPressed: () {
              //     controller.applyVacancy(widget.details.id!);
              //   },
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   color: kPrimaryColorApplicant,
              //   child: const Text(
              //     'Apply',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(color: Colors.white, fontSize: 18),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
