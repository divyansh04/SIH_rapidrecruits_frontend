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

class AddQualification extends StatefulWidget {
  const AddQualification({Key? key}) : super(key: key);

  @override
  State<AddQualification> createState() => _AddQualificationState();
}

class _AddQualificationState extends State<AddQualification> {
  final controller = GetIt.I<ApplicantProfileController>();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add Qualification Info',
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
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: controller.loading.value,
          child: SingleChildScrollView(
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
                    validatorError: 'Title is required',
                    icon: Icons.description,
                    hint: 'Title',
                    controller: controller.title,
                    color: kPrimaryColorApplicant,
                  ),
                  InputContainer(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.calendar_month,
                              color: kPrimaryColorApplicant),
                          Text(
                            controller.passingYear.value == ''
                                ? 'Passing Year'
                                : '${controller.passingYear}',
                            style: TextStyle(
                                fontSize: 14,
                                color: controller.passingYear.value == ''
                                    ? Colors.grey
                                    : Colors.black54),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        String dob = await DatePickerClass.selectYear(context);
                        if (dob != null) {
                          controller.passingYear.value = dob;
                        }
                      },
                    ),
                  ),
                  RoundedInput(
                    validatorError: "Institute is required",
                    icon: Icons.account_balance,
                    hint: 'Institute',
                    maxLines: 6,
                    controller: controller.qualif_institute,
                    color: kPrimaryColorApplicant,
                  ),
                  RoundedInput(
                    validatorError: "Score is required",
                    icon: Icons.description,
                    hint: 'Score',
                    controller: controller.score,
                    color: kPrimaryColorApplicant,
                  ),
                  const SizedBox(height: 20),
                  RoundedButton(
                    color: kPrimaryColorApplicant,
                    title: 'SUBMIT',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.submitQualifications();
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
