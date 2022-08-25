import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/screens/institute_screens/employee/controller/employee_details_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/employee/models/EmployeeModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utilities/constants.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key, required this.details}) : super(key: key);
  final EmployeeModel details;
  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  final controller = GetIt.I<EmployeeDetailsController>();
  @override
  void initState() {
    controller.setInitials(widget.details);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColorInstitute,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              centerTitle: true,
              title: const Text('Employee Details'),
              backgroundColor: kPrimaryColorInstitute,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedInput(
                          icon: Icons.person_outlined,
                          hint: 'Name',
                          controller: controller.name,
                          color: kPrimaryColorInstitute),
                      RoundedInput(
                          icon: Icons.person_outlined,
                          hint: 'Employee Id',
                          controller: controller.empId,
                          color: kPrimaryColorInstitute),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    activeColor: kPrimaryColorInstitute,
                                    value: 0,
                                    groupValue:
                                        controller.selectedGenderRadio.value,
                                    onChanged: (int? value) {
                                      setState(() {
                                        controller.selectedGenderRadio.value =
                                            value!;
                                      });
                                    },
                                  ),
                                  const Flexible(
                                      child: Text(
                                    'Male',
                                    overflow: TextOverflow.clip,
                                  )),
                                ]),
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      activeColor: kPrimaryColorInstitute,
                                      value: 1,
                                      groupValue:
                                          controller.selectedGenderRadio.value,
                                      onChanged: (int? value) async {
                                        setState(() {
                                          controller.selectedGenderRadio.value =
                                              value!;
                                        });
                                      }),
                                  const Flexible(
                                      child: Text(
                                    'Female',
                                    overflow: TextOverflow.clip,
                                  )),
                                ]),
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      activeColor: kPrimaryColorInstitute,
                                      value: 2,
                                      groupValue:
                                          controller.selectedGenderRadio.value,
                                      onChanged: (int? value) async {
                                        setState(() {
                                          controller.selectedGenderRadio.value =
                                              value!;
                                        });
                                      }),
                                  const Flexible(
                                      child: Text(
                                    'Other',
                                    overflow: TextOverflow.clip,
                                  )),
                                ]),
                          ),
                        ],
                      ),
                      RoundedInput(
                          icon: Icons.date_range_outlined,
                          hint: 'Date of Birth',
                          controller: controller.dob,
                          color: kPrimaryColorInstitute),
                      Text(
                        '      Note: Please add Date Of Birth in "DD/MM/YYYY"',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                      RoundedInput(
                          icon: Icons.email_outlined,
                          hint: 'Email',
                          controller: controller.email,
                          color: kPrimaryColorInstitute),
                      RoundedInput(
                          icon: Icons.phone_iphone_outlined,
                          hint: 'Phone Number',
                          controller: controller.phoneNumber,
                          color: kPrimaryColorInstitute),
                      RoundedInput(
                          icon: Icons.category_outlined,
                          hint: 'Category',
                          controller: controller.category,
                          color: kPrimaryColorInstitute),
                      RoundedInput(
                          icon: Icons.abc,
                          hint: 'Designation',
                          controller: controller.designation,
                          color: kPrimaryColorInstitute),
                      RoundedInput(
                          icon: Icons.location_city,
                          hint: 'Department',
                          controller: controller.department,
                          color: kPrimaryColorInstitute),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    activeColor: kPrimaryColorInstitute,
                                    value: 0,
                                    groupValue:
                                        controller.selectedStatusRadio.value,
                                    onChanged: (int? value) {
                                      setState(() {
                                        controller.selectedStatusRadio.value =
                                            value!;
                                      });
                                    },
                                  ),
                                  const Flexible(
                                      child: Text(
                                    'Working',
                                    overflow: TextOverflow.clip,
                                  )),
                                ]),
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      activeColor: kPrimaryColorInstitute,
                                      value: 1,
                                      groupValue:
                                          controller.selectedStatusRadio.value,
                                      onChanged: (int? value) async {
                                        setState(() {
                                          controller.selectedStatusRadio.value =
                                              value!;
                                        });
                                      }),
                                  const Flexible(
                                      child: Text(
                                    'Notice period',
                                    overflow: TextOverflow.clip,
                                  )),
                                ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        height: 60,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.updateEmployeeDetails();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: kPrimaryColorInstitute,
                        child: const Text('Update',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
