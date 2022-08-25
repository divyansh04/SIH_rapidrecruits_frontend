import 'package:RapidRecruits/screens/institute_screens/applicants/applied_applicant_profile.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/controller/applied_applicants_controller.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class ApplicantsApplied extends StatefulWidget {
  const ApplicantsApplied({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<ApplicantsApplied> createState() => _ApplicantsAppliedState();
}

class _ApplicantsAppliedState extends State<ApplicantsApplied> {
  @override
  void initState() {
    controller.getAppliedCandidates(widget.id);
    super.initState();
  }

  final controller = GetIt.I<AppliedApplicantsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text('Applicants Applied'),
          backgroundColor: kPrimaryColorInstitute,
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColorInstitute,
                ),
              )
            : controller.data.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_outline,
                          color: kPrimaryColorInstitute,
                          size: 55,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No Applicants Found",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: SizedBox(
                      height: Get.height - 120,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Get.to(AppliedApplicantProfile(
                                        vacId: widget.id,
                                        data: controller.data[index],
                                      ));
                                    },
                                    child: Container(
                                      height: 90,
                                      width: Get.width,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundColor:
                                                      kPrimaryColorInstitute,
                                                  child: CircleAvatar(
                                                    radius: 38,
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage:
                                                        NetworkImage(controller
                                                            .data[index]
                                                            .personaldetails!
                                                            .profilePic!),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        controller
                                                                .data[index]
                                                                .personaldetails!
                                                                .fullName ??
                                                            "",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "Experience: ${controller.data[index].personaldetails!.totalExperience.toString()} Years",
                                                        style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "Skills: ${controller.data[index].personaldetails!.skillSet!.join(', ')}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 3),
                                                  child: Text(
                                                    controller
                                                        .data[index].status
                                                        .toString()
                                                        .toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: controller
                                                                    .data[index]
                                                                    .status ==
                                                                "under review"
                                                            ? Colors.black
                                                            : controller
                                                                        .data[
                                                                            index]
                                                                        .status ==
                                                                    'rejected'
                                                                ? Colors.red
                                                                : controller
                                                                            .data[
                                                                                index]
                                                                            .status ==
                                                                        'meet scheduled'
                                                                    ? kPrimaryColorInstitute
                                                                    : Colors
                                                                        .green,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              )
                                            ]),
                                      ),
                                    )),
                                const Divider()
                              ],
                            );
                          }),
                    ),
                  ),
      ),
    );
  }
}
