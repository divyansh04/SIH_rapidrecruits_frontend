import 'package:RapidRecruits/components/date_formatter.dart';
import 'package:RapidRecruits/components/input_field.dart';
import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/screens/applicant_screens/view_Applicant_profile/controller/applicant_profile_controller.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({Key? key}) : super(key: key);

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

final _formKey = GlobalKey<FormState>();

class _AddExperienceState extends State<AddExperience> {
  final controller = GetIt.I<ApplicantProfileController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Add Experience Info',
              style: TextStyle(color: Colors.black, fontSize: 21),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 2,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  RoundedInput(
                    validatorError: 'Designation is required',
                    icon: Icons.description,
                    hint: 'Designation',
                    controller: controller.designation,
                    color: kPrimaryColorApplicant,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputContainer(
                          color: kPrimaryColorApplicant,
                          child: MaterialButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // side: const BorderSide(
                              //     color: kPrimaryColorApplicant)
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            // color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.calendar_month,
                                    color: kPrimaryColorApplicant),
                                Text(
                                  controller.fromDate.value == ''
                                      ? 'Start Date'
                                      : '${controller.fromDate}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: controller.fromDate.value == ''
                                          ? Colors.grey
                                          : Colors.black54),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? dob =
                                  await DatePickerClass.selectDate(context);
                              if (dob != null) {
                                controller.fromDate.value =
                                    controller.formatter.format(dob);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InputContainer(
                          color: kPrimaryColorApplicant,
                          child: MaterialButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // side: const BorderSide(
                              //     color: kPrimaryColorApplicant)
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            // color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.calendar_month,
                                    color: kPrimaryColorApplicant),
                                Text(
                                  controller.toDate.value == ''
                                      ? 'End Date'
                                      : '${controller.toDate}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: controller.toDate.value == ''
                                          ? Colors.grey
                                          : Colors.black54),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? dob =
                                  await DatePickerClass.selectDate(context);
                              if (dob != null) {
                                controller.toDate.value =
                                    controller.formatter.format(dob);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  RoundedInput(
                    validatorError: 'Institute is required',
                    icon: Icons.account_balance,
                    hint: 'Institute',
                    maxLines: 6,
                    controller: controller.institute,
                    color: kPrimaryColorApplicant,
                  ),
                  RoundedInput(
                    validatorError: 'Details is required',
                    icon: Icons.description,
                    hint: 'Details',
                    maxLines: 6,
                    controller: controller.detailsField,
                    color: kPrimaryColorApplicant,
                  ),
                  const SizedBox(height: 20),
                  RoundedButton(
                    color: kPrimaryColorApplicant,
                    title: 'SUBMIT',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.submitExperience();
                      }
                    },
                  ),
                ],
              ),
            )),
          )),
        ),
      ),
    );
  }
}
