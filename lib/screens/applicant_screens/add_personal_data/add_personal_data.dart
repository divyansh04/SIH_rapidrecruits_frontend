import 'package:RapidRecruits/components/date_formatter.dart';
import 'package:RapidRecruits/components/full_screen_image.dart';
import 'package:RapidRecruits/components/input_field.dart';
import 'package:RapidRecruits/components/reusable_radio_button.dart';
import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/components/searchable_dropdown.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'controller/personal_data_controller.dart';
import 'image_screen.dart';

class AddApplicantPersonalData extends StatefulWidget {
  final bool editProfile;
  const AddApplicantPersonalData({Key? key, this.editProfile = false})
      : super(key: key);

  @override
  State<AddApplicantPersonalData> createState() =>
      _AddApplicantPersonalDataState();
}

class _AddApplicantPersonalDataState extends State<AddApplicantPersonalData> {
  final controller = GetIt.I<ApplicantPersonalDataController>();
  @override
  void initState() {
    controller.getUserName();
    controller.loadStates();

    if (widget.editProfile) {
      controller.getDetails();
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: widget.editProfile == true
              ? AppBar(
                  title: const Text(
                    'Edit Personal Info',
                    style: TextStyle(color: Colors.black, fontSize: 21),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black)),
                  backgroundColor: Colors.white,
                  elevation: 2,
                )
              : AppBar(
                  title: const Text(
                    'Add Personal Info',
                    style: TextStyle(color: Colors.black, fontSize: 21),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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
                      const SizedBox(height: 80),
                      GestureDetector(
                        onTap: () {
                          controller.uploadProfileImage();
                        },
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: kPrimaryColorApplicant,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 46,
                              backgroundImage:
                                  controller.profileImageUrl.value == ''
                                      ? null
                                      : NetworkImage(
                                          controller.profileImageUrl.value),
                              child: controller.profileImageUrl.value == ''
                                  ? const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 35,
                                      color: kPrimaryColorApplicant,
                                    )
                                  : null),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RoundedInput(
                        icon: Icons.face_rounded,
                        hint: 'Full Name',
                        controller: controller.fullName,
                        validatorError: 'Full name is required',
                        color: kPrimaryColorApplicant,
                      ),
                      widget.editProfile
                          ? RoundedInput(
                              validatorError: 'Email is required',
                              icon: Icons.email_sharp,
                              hint: 'E-mail',
                              controller: controller.email,
                              color: kPrimaryColorApplicant,
                            )
                          : Container(),
                      RoundedInput(
                        validatorError: ' Description is required',
                        icon: Icons.description,
                        hint: 'Description',
                        maxLines: 6,
                        controller: controller.description,
                        color: kPrimaryColorApplicant,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundedInput(
                              validatorError: 'PinCode is required',
                              icon: Icons.location_on_outlined,
                              hint: 'Pin Code',
                              controller: controller.pinCode,
                              color: kPrimaryColorApplicant,
                            ),
                          ),
                          const SizedBox(width: 8),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        color: kPrimaryColorApplicant),
                                    Text(
                                      controller.dob.value == ''
                                          ? 'Date of Birth'
                                          : '${controller.dob}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: controller.dob.value == ''
                                              ? Colors.grey
                                              : Colors.black54),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  DateTime? dob =
                                      await DatePickerClass.selectDate(context);
                                  if (dob != null) {
                                    final age = controller.calculateAge(dob);
                                    if (age < 18) {
                                      controller.dob.value = '';
                                      Fluttertoast.showToast(
                                          msg: 'Age should be 18+');
                                    } else {
                                      controller.dob.value =
                                          controller.formatter.format(dob);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      RoundedInput(
                        icon: Icons.numbers,
                        validatorError: "Address is required",
                        hint: 'Address',
                        maxLines: 3,
                        controller: controller.address,
                        color: kPrimaryColorApplicant,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SearchableDD(
                              color: kPrimaryColorApplicant,
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
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  controller.newState = value!;
                                  controller.loadCities(controller.newState);
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SearchableDD(
                              color: kPrimaryColorApplicant,
                              validate: (city) {
                                if (controller.city.trim() == '') {
                                  return 'City is required';
                                }
                                return '';
                              },
                              hintText: 'Search City',
                              label: 'City',
                              items: controller.cities,
                              selectedItem: controller.city,
                              onChanged: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                controller.city = value!;
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SearchableDD(
                              color: kPrimaryColorApplicant,
                              validate: (gender) {
                                if (controller.gender.trim() == '') {
                                  return 'Gender is required';
                                }
                                return '';
                              },
                              hintText: 'Select Gender',
                              label: 'Gender',
                              items: const ['Male', 'Female', 'Others'],
                              selectedItem: controller.gender,
                              showSearchBox: false,
                              onChanged: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                controller.gender = value!;
                                // setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SearchableDD(
                              color: kPrimaryColorApplicant,
                              validate: (category) {
                                if (controller.category.trim() == '') {
                                  return 'Category is required';
                                }
                                return '';
                              },
                              hintText: 'Select Category',
                              label: 'Category',
                              items: const ['General', 'Reserved'],
                              selectedItem: controller.category,
                              showSearchBox: false,
                              onChanged: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                controller.category = value!;
                                // setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(6),
                              child: ReusableRadioButton(
                                color: kPrimaryColorApplicant,
                                title: 'Married',
                                groupValue: controller.maritalStatus,
                                onpressed: (value) {
                                  setState(() {
                                    controller.maritalStatus = value!;
                                  });
                                },
                              )),
                          Padding(
                              padding: const EdgeInsets.all(6),
                              child: ReusableRadioButton(
                                color: kPrimaryColorApplicant,
                                title: 'Unmarried',
                                groupValue: controller.maritalStatus,
                                onpressed: (value) {
                                  setState(() {
                                    controller.maritalStatus = value!;
                                  });
                                },
                              )),
                        ],
                      ),
                      RoundedInput(
                        validatorError: 'Phone Number is Required',
                        icon: Icons.phone,
                        hint: 'Phone Number',
                        controller: controller.phone,
                        color: kPrimaryColorApplicant,
                        keyboardType: TextInputType.phone,
                      ),
                      RoundedInput(
                        validatorError: "Experience is required",
                        icon: Icons.work,
                        hint: 'Total Experience (in years)',
                        controller: controller.experience,
                        color: kPrimaryColorApplicant,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
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
                            alignLabelWithHint: true,
                            icon: const Icon(Icons.list,
                                color: kPrimaryColorApplicant),
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
                                    BorderSide(color: kPrimaryColorApplicant)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColorApplicant),
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
                                  backgroundColor: kPrimaryColorApplicant,
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
                      const SizedBox(height: 10),
                      controller.resumeImageUrl.value == ''
                          ? GestureDetector(
                              onTap: () {
                                controller.uploadResumeImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        kPrimaryColorApplicant.withAlpha(50)),
                                height: 46,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: controller.resumeImageUrl.value == ''
                                    ? const Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 35,
                                        color: kPrimaryColorApplicant,
                                      )
                                    : Image.network(
                                        controller.resumeImageUrl.value),
                              ),
                            )
                          : GestureDetector(
                              child: Hero(
                                tag: 'imageHero',
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          controller.resumeImageUrl.value,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 150,
                                ),
                              ),
                              onTap: () {
                                Get.to(
                                  FullScreenImage(
                                    url: controller.resumeImageUrl.value,
                                  ),
                                );
                              },
                            ),
                      controller.resumeImageUrl.value == ''
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                controller.uploadResumeImage();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:
                                          kPrimaryColorApplicant.withAlpha(50)),
                                  height: 46,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.edit,
                                        size: 35,
                                        color: kPrimaryColorApplicant,
                                      ),
                                      Text('Edit Image')
                                    ],
                                  )),
                            ),
                      const SizedBox(height: 20),
                      widget.editProfile
                          ? RoundedButton(
                              color: kPrimaryColorApplicant,
                              title: 'SAVE',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.editProfile();
                                }
                              },
                            )
                          : RoundedButton(
                              color: kPrimaryColorApplicant,
                              title: 'SUBMIT',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.submit();
                                }
                              },
                            ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
