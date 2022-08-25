// ignore_for_file: deprecated_member_use
import 'package:RapidRecruits/components/input_field.dart';
import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/controllers/vacancy_controller.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddVacancyScreen extends StatefulWidget {
  const AddVacancyScreen({Key? key}) : super(key: key);

  @override
  State<AddVacancyScreen> createState() => _AddVacancyScreenState();
}

class _AddVacancyScreenState extends State<AddVacancyScreen> {
  final controller = GetIt.I<AddVacancyController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColorInstitute,
        ),
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text('Add Vacancy'),
            backgroundColor: kPrimaryColorInstitute,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedInput(
                        icon: Icons.title,
                        hint: 'Title',
                        controller: controller.title,
                        color: kPrimaryColorInstitute),
                    RoundedInput(
                        icon: Icons.type_specimen_outlined,
                        hint: 'Type',
                        controller: controller.type,
                        color: kPrimaryColorInstitute),
                    RoundedInput(
                        icon: Icons.date_range_outlined,
                        hint: 'Experience',
                        controller: controller.experience,
                        color: kPrimaryColorInstitute),
                    RoundedInput(
                        icon: Icons.monetization_on_outlined,
                        hint: "Compensation",
                        keyboardType: TextInputType.number,
                        controller: controller.compensation,
                        color: kPrimaryColorInstitute),
                    RoundedInput(
                        icon: Icons.description_outlined,
                        hint: 'Description',
                        maxLines: 3,
                        controller: controller.description,
                        color: kPrimaryColorInstitute),
                    RoundedInput(
                        icon: Icons.list_alt,
                        hint: 'Responsibilities',
                        controller: controller.responsibilities,
                        color: kPrimaryColorInstitute),
                    RoundedInput(
                        icon: Icons.grading,
                        hint: 'Qualifications',
                        controller: controller.qualification,
                        color: kPrimaryColorInstitute),

                    InputContainer(
                      color: kPrimaryColorInstitute,
                      child: Center(
                        child: TextFieldTags(
                          textSeparators: const [','],
                          initialTags: controller.skills,
                          onTag: (tag) {
                            controller.skills.add(tag);
                          },
                          onDelete: (tag) {
                            controller.skills.remove(tag);
                          },
                          validator: (tag) {
                            //add validation for tags
                            if (tag.length < 3) {
                              return "Enter tag up to 3 characters.";
                            }
                            return null;
                          },
                          tagsStyler: TagsStyler(
                              //styling tag style
                              tagTextStyle: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              tagDecoration: BoxDecoration(
                                color: kPrimaryColorInstitute.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              tagCancelIcon: const Icon(Icons.cancel,
                                  size: 18.0, color: kPrimaryColorInstitute),
                              tagPadding: const EdgeInsets.all(6.0)),
                          textFieldStyler: TextFieldStyler(
                            icon: const Icon(
                              Icons.library_add_check_outlined,
                              color: kPrimaryColorInstitute,
                              size: 23,
                            ),
                            cursorColor: kPrimaryColorInstitute,
                            hintText: 'Add Skills',
                            helperText: 'Note: Use "," to separate tags',
                            //styling tag text field
                            textFieldBorder: InputBorder.none,
                            // OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(20),
                            //   borderSide: const BorderSide(
                            //       color: kPrimaryColorInstitute, width: 2),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               Radio(
                    //                 activeColor: kPrimaryColorInstitute,
                    //                 value: 0,
                    //                 groupValue:
                    //                 controller.selectedStateRadio.value,
                    //                 onChanged: (int? value) {
                    //                   setState(() {
                    //                     controller.selectedStateRadio.value =
                    //                     value!;
                    //                   });
                    //                 },
                    //               ),
                    //               const Flexible(
                    //                 child: Text(
                    //                   'Active',
                    //                   overflow: TextOverflow.clip,
                    //                 ),
                    //               ),
                    //             ]),
                    //       ),
                    //       Expanded(
                    //         child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               Radio(
                    //                   activeColor: kPrimaryColorInstitute,
                    //                   value: 1,
                    //                   groupValue:
                    //                   controller.selectedStateRadio.value,
                    //                   onChanged: (int? value) async {
                    //                     setState(() {
                    //                       controller.selectedStateRadio.value =
                    //                       value!;
                    //                     });
                    //                   }),
                    //               const Flexible(
                    //                 child: Text(
                    //                   'Filled',
                    //                   overflow: TextOverflow.clip,
                    //                 ),
                    //               ),
                    //             ]),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      height: 55,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.createVacancy();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: kPrimaryColorInstitute,
                      child: const Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
