import 'package:RapidRecruits/screens/applicant_screens/add_personal_data/add_personal_data.dart';
import 'package:RapidRecruits/screens/applicant_screens/view_Applicant_profile/widgets/add_qualifiation.dart';
import 'package:RapidRecruits/screens/auth_module/auth_screen_applicant.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'controller/applicant_profile_controller.dart';
import 'widgets/add_experience.dart';
import 'widgets/experience_card.dart';
import 'widgets/qualifications_card.dart';

class ViewApplicantProfile extends StatefulWidget {
  const ViewApplicantProfile({Key? key}) : super(key: key);

  @override
  State<ViewApplicantProfile> createState() => _ViewApplicantProfileState();
}

class _ViewApplicantProfileState extends State<ViewApplicantProfile> {
  final controller = GetIt.I<ApplicantProfileController>();

  @override
  void initState() {
    controller.getDetails();
    controller.getExperienceDetails();
    controller.getQualificationDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'User Details',
            style: TextStyle(color: Colors.black, fontSize: 21),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          actions: [
            IconButton(
                onPressed: () async {
                  Box? box = await Hive.openBox('userBox');
                  box.put("token", false);
                  box.clear();
                  Get.offAll(() => const AuthScreenApplicant());
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                ))
          ],
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColorApplicant,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const AddApplicantPersonalData(
                              editProfile: true));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: kPrimaryColorApplicant),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 4,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.edit_note_outlined,
                                  color: kPrimaryColorApplicant,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Column(children: [
                                  CircleAvatar(
                                    radius: 48,
                                    backgroundColor: kPrimaryColorApplicant,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 46,
                                        backgroundImage:
                                            controller.details!.profilePic == ''
                                                ? null
                                                : NetworkImage(controller
                                                    .details!.profilePic!),
                                        child: controller
                                                    .details!.profilePic! ==
                                                ''
                                            ? const Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 35,
                                                color: kPrimaryColorApplicant,
                                              )
                                            : null),
                                  ),
                                  Text('${controller.details!.fullName}'),
                                  const SizedBox(height: 8),
                                  Text('${controller.details!.phoneNumber}'),
                                  const SizedBox(height: 8),
                                  Text('${controller.details!.description}'),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Experiences : "),
                          MaterialButton(
                            onPressed: () async {
                              await Get.to(const AddExperience());
                              controller.getExperienceDetails();
                            },
                            color: kPrimaryColorApplicant,
                            child: const Text(
                              "+ Add Experience",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 32),
                      controller.exp_loading.value
                          ? const CircularProgressIndicator()
                          : (controller.applicantExperienceDetails.value.data ==
                                      null ||
                                  controller.applicantExperienceDetails.value
                                      .data!.isEmpty)
                              ? const Center(
                                  child:
                                      Text("No Experiences Information added"),
                                )
                              : SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller
                                          .applicantExperienceDetails
                                          .value
                                          .data!
                                          .length,
                                      itemBuilder: (_, i) {
                                        var element = controller
                                            .applicantExperienceDetails
                                            .value
                                            .data![i];
                                        return ExperienceCard(element: element);
                                      }),
                                ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Qualifications : "),
                          MaterialButton(
                            onPressed: () async {
                              await Get.to(const AddQualification());
                              controller.getQualificationDetails();
                            },
                            color: kPrimaryColorApplicant,
                            child: const Text(
                              "+ Add Qualifications",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 32),
                      controller.qua_loading.value
                          ? const CircularProgressIndicator()
                          : (controller.applicantQualificationDetails.value
                                          .data ==
                                      null ||
                                  controller.applicantQualificationDetails.value
                                      .data!.isEmpty)
                              ? const Center(
                                  child: Text(
                                      "No Qualifications Information added"),
                                )
                              : SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller
                                          .applicantQualificationDetails
                                          .value
                                          .data!
                                          .length,
                                      itemBuilder: (_, i) {
                                        var element = controller
                                            .applicantQualificationDetails
                                            .value
                                            .data![i];
                                        return QualificationCard(
                                            element: element);
                                      }),
                                ),
                    ],
                  ),
                ),
              )),
      ),
    );
  }
}
