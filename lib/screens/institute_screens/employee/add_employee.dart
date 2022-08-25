// ignore_for_file: deprecated_member_use

import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/components/searchable_dropdown.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'controller/add_employee_controller.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final controller = GetIt.I<AddEmployeeController>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.loadStates();
    super.initState();
  }

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
              title: const Text('Add Employee'),
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
                      Container(
                        width: 150,
                        child: SearchableDD(
                          isFilled: true,
                          color: kPrimaryColorInstitute.withAlpha(50),
                          validate: (state) {
                            if (state == null) {
                              return 'State is required';
                            }
                            return '';
                          },
                          hintText: 'Search State',
                          label: 'State',
                          items: controller.allStates,
                          selectedItem: controller.newState,
                          onChanged: (value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              controller.newState = value!;
                            });
                          },
                        ),
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
                      AutoCompleteTextField(
                        key: controller.key,
                        textChanged: (value) {
                          if (value.endsWith(',')) {
                            value = value.split(',').first;
                            setState(() {
                              controller.keySkills.add(value);
                              controller.skillsController.clear();
                            });
                            value = '';
                          }
                        },
                        controller: controller.skillsController,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: kPrimaryColorInstitute.withAlpha(50),
                            alignLabelWithHint: true,
                            icon: const Icon(Icons.list,
                                color: kPrimaryColorInstitute),
                            hintStyle: const TextStyle(fontSize: 14),
                            labelStyle: const TextStyle(fontSize: 14),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 14),
                            hintText: ' Type like flutter,',
                            labelText: 'Key Skills',
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                    BorderSide(color: kPrimaryColorInstitute)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColorInstitute),
                                borderRadius: BorderRadius.circular(30))),
                        itemSubmitted: (item) {
                          setState(() {
                            controller.keySkills.add(item.toString());
                          });
                        },
                        suggestions: const [], //controller.keySkillsSuggestions,
                        itemBuilder: (context, item) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        },
                        itemSorter: (a, b) {
                          return a!.toString().compareTo(b.toString());
                        },
                        itemFilter: (item, query) {
                          return item!
                              .toString()
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                      ),
                      const SizedBox(height: 10),
                      controller.keySkills.isEmpty
                          ? Container()
                          : Wrap(
                              runSpacing: 6,
                              spacing: 6,
                              children: List<Widget>.generate(
                                  controller.keySkills.length, (index) {
                                return Chip(
                                  padding: const EdgeInsets.all(8),
                                  deleteIconColor: Colors.white,
                                  backgroundColor: kPrimaryColorInstitute,
                                  label: Text(
                                    controller.keySkills[index],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  onDeleted: () {
                                    setState(() {
                                      controller.keySkills.removeAt(index);
                                    });
                                  },
                                );
                              }),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: MaterialButton(
                              height: 60,
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                  controller.addEmployeeDetails(false);
                                // }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: kPrimaryColorInstitute,
                              child: const Text('Save and exit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: FlatButton(
                              height: 60,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.addEmployeeDetails(true);
                                  Get.to(const AddEmployeeScreen());
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: kPrimaryColorInstitute,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text('Save and add another',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kPrimaryColorInstitute,
                                      fontSize: 18)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
