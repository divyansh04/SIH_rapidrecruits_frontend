import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'applied_vacancy_details.dart';
import 'controller/applicant_history_controller.dart';

class ApplicationsHistoryScreen extends StatefulWidget {
  const ApplicationsHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationsHistoryScreen> createState() =>
      _ApplicationsHistoryScreenState();
}

class _ApplicationsHistoryScreenState extends State<ApplicationsHistoryScreen> {
  final controller = GetIt.I<ApplicantHistoryController>();
  @override
  void initState() {
    controller.getAppliedVacancies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Vacancies Application History'),
          backgroundColor: kPrimaryColorApplicant,
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColorApplicant,
                ),
              )
            : controller.appliedVacancies.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_outline,
                          color: kPrimaryColorApplicant,
                          size: 55,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No Applied Vacancies Yet",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: Get.height - 120,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.appliedVacancies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(AppliedVacancyDetails(
                                    details: controller.appliedVacancies[index],
                                  ));
                                },
                                child: Container(
                                  height: 100,
                                  width: Get.width,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              controller.appliedVacancies[index]
                                                      .title ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(children: [
                                              for (String i in controller
                                                  .appliedVacancies[index]
                                                  .skills!)
                                                Text(
                                                  "$i, ",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(
                                                        0.7,
                                                      ),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                            ]),
                                            Text(
                                              "Qualifications: ${controller.appliedVacancies[index].qualifications ?? ""}",
                                              style: TextStyle(
                                                  color:
                                                      Colors.black.withOpacity(
                                                    0.7,
                                                  ),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "Min Experience: ${controller.appliedVacancies[index].experience ?? ""}",
                                              style: TextStyle(
                                                  color:
                                                      Colors.black.withOpacity(
                                                    0.7,
                                                  ),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              // Container(
                                              //   height: 28,
                                              //   width: 95,
                                              //   decoration: BoxDecoration(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               10),
                                              //       color: controller
                                              //               .appliedVacancies[
                                              //                   index]
                                              //               .state!
                                              //           ? Colors.green
                                              //               .withOpacity(0.3)
                                              //           : Colors.red
                                              //               .withOpacity(0.3)),
                                              //   child: Center(
                                              //     child: controller
                                              //             .appliedVacancies[
                                              //                 index]
                                              //             .state!
                                              //         ? const Text(
                                              //             'Accepting',
                                              //             style: TextStyle(
                                              //                 fontSize: 13,
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .w500),
                                              //           )
                                              //         : const Text(
                                              //             "Not Accepting",
                                              //             style: TextStyle(
                                              //                 fontSize: 13,
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .w500),
                                              //           ),
                                              //   ),
                                              // ),
                                              Text(
                                                controller
                                                        .appliedVacancies[index]
                                                        .dateOfPosting ??
                                                    "",
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ])
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider()
                            ],
                          );
                        }),
                  ),
      ),
    );
  }
}
