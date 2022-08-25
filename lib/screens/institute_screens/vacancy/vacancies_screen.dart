import 'package:RapidRecruits/screens/institute_screens/applicants/applicants_applied.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/suitable_candidates.dart';
import 'package:RapidRecruits/screens/institute_screens/recruitment_committee/add_recruitment_committee.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/add_vacancy.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/controllers/vacancy_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/vacancy_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../utilities/constants.dart';

class VacanciesScreen extends StatefulWidget {
  const VacanciesScreen({Key? key,this.showBackButton=false}) : super(key: key);
  final bool showBackButton;
  @override
  State<VacanciesScreen> createState() => _VacanciesScreenState();
}

class _VacanciesScreenState extends State<VacanciesScreen> {
  @override
  void initState() {
    controller.getVacancies();
    super.initState();
  }

  final controller = GetIt.I<AddVacancyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: widget.showBackButton,
          centerTitle: true,
          title: const Text('Vacancies'),
          backgroundColor: kPrimaryColorInstitute,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(const AddVacancyScreen());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_circle_outline,
                      size: 30,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Add Vacancy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            )
          ],
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
                          "No Vacancies Found",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                : SizedBox(
                    height: Get.height - 120,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
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
                                      GestureDetector(
                                          onTap: () {
                                            Get.to(VacancyDetails(
                                              details: controller.data[index],
                                            ));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                controller.data[index].title ??
                                                    "",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Row(children: [
                                                for (String i in controller
                                                    .data[index].skills!)
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
                                                "Qualifications: ${controller.data[index].qualifications ?? ""}",
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(
                                                      0.7,
                                                    ),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "Min Experience: ${controller.data[index].experience ?? ""}",
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(
                                                      0.7,
                                                    ),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                controller.data[index]
                                                        .dateOfPosting ??
                                                    "",
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 28,
                                              width: 95,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: controller
                                                          .data[index].state!
                                                      ? Colors.green
                                                          .withOpacity(0.3)
                                                      : Colors.red
                                                          .withOpacity(0.3)),
                                              child: Center(
                                                child: controller
                                                        .data[index].state!
                                                    ? const Text(
                                                        'Accepting',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    : const Text(
                                                        "Not Accepting",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.actions[index] =
                                                    !controller.actions[index];
                                              },
                                              child: Obx(
                                                () => Row(
                                                  children: [
                                                    Text(
                                                      controller.actions[index]
                                                          ? 'Hide Actions'
                                                          : 'Show Actions',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Icon(
                                                      !controller.actions[index]
                                                          ? Icons
                                                              .arrow_drop_down_sharp
                                                          : Icons
                                                              .arrow_drop_up_sharp,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ])
                                    ],
                                  ),
                                ),
                              ),
                              !controller.data[index].recruitmentCommittee!
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          'Recruitment Committee not added!!',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              Obx(
                                () => Visibility(
                                    visible: controller.actions[index],
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MaterialButton(
                                            height: 40,
                                            onPressed: () {
                                              Get.to(AddRecruitmentCommittee(
                                                data: controller.data[index],
                                              ));
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: kPrimaryColorInstitute,
                                            child: const Text(
                                              '  Recruitment \nCommittee  ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          MaterialButton(
                                            height: 40,
                                            onPressed: () {
                                              Get.to(SuitableCandidates(
                                                  id: controller
                                                      .data[index].id!));
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: kPrimaryColorInstitute,
                                            child: const Text(
                                              '  Suitable \nCandidates  ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          MaterialButton(
                                            height: 40,
                                            onPressed: () {
                                              Get.to(ApplicantsApplied(
                                                  id: controller
                                                      .data[index].id!));
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: kPrimaryColorInstitute,
                                            child: const Text(
                                              '  Applicants \nApplied   ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
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
