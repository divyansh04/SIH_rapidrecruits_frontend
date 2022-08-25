import 'package:RapidRecruits/screens/applicant_screens/vacancies_module/controller/vacancies_controller.dart';
import 'package:RapidRecruits/screens/applicant_screens/vacancies_module/vacancy_details_view.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class AllVacancies extends StatefulWidget {
  final bool showCustomizedVacancies;
  const AllVacancies({Key? key, required this.showCustomizedVacancies})
      : super(key: key);

  @override
  State<AllVacancies> createState() => _AllVacanciesState();
}

class _AllVacanciesState extends State<AllVacancies> {
  final controller = GetIt.I<VacanciesController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.showCustomizedVacancies) {
        return _buildCustomizedVacancies();
      } else {
        return _buildAllVacancies();
      }
    });
  }

  Widget _buildAllVacancies() {
    return controller.loading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColorApplicant,
            ),
          )
        : controller.allVacancies.isEmpty
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
                    itemCount: controller.allVacancies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              Get.to(VacancyDetailsView(
                                details: controller.allVacancies[index],
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          controller
                                                  .allVacancies[index].title ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(children: [
                                          for (String i in controller
                                              .allVacancies[index].skills!)
                                            Text(
                                              "$i, ",
                                              style: TextStyle(
                                                  color:
                                                      Colors.black.withOpacity(
                                                    0.7,
                                                  ),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                        ]),
                                        Text(
                                          "Qualifications: ${controller.allVacancies[index].qualifications ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(
                                                0.7,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "Min Experience: ${controller.allVacancies[index].experience ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(
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
                                          Container(
                                            height: 28,
                                            width: 95,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: controller
                                                        .allVacancies[index]
                                                        .state!
                                                    ? Colors.green
                                                        .withOpacity(0.3)
                                                    : Colors.red
                                                        .withOpacity(0.3)),
                                            child: Center(
                                              child: controller
                                                      .allVacancies[index]
                                                      .state!
                                                  ? const Text(
                                                      'Accepting',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  : const Text(
                                                      "Not Accepting",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                            ),
                                          ),
                                          Text(
                                            controller.allVacancies[index]
                                                    .dateOfPosting ??
                                                "",
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.7),
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
              );
  }

  Widget _buildCustomizedVacancies() {
    return controller.loading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColorApplicant,
            ),
          )
        : controller.customizedVacancies.isEmpty
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
                      "No Suitable Vacancies Found",
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
                    itemCount: controller.customizedVacancies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              Get.to(VacancyDetailsView(
                                details: controller.customizedVacancies[index],
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          controller.customizedVacancies[index]
                                                  .title ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(children: [
                                          for (String i in controller
                                              .customizedVacancies[index]
                                              .skills!)
                                            Text(
                                              "$i, ",
                                              style: TextStyle(
                                                  color:
                                                      Colors.black.withOpacity(
                                                    0.7,
                                                  ),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                        ]),
                                        Text(
                                          "Qualifications: ${controller.customizedVacancies[index].qualifications ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(
                                                0.7,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "Min Experience: ${controller.customizedVacancies[index].experience ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(
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
                                          Container(
                                            height: 28,
                                            width: 95,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: controller
                                                        .allVacancies[index]
                                                        .state!
                                                    ? Colors.green
                                                        .withOpacity(0.3)
                                                    : Colors.red
                                                        .withOpacity(0.3)),
                                            child: Center(
                                              child: controller
                                                      .customizedVacancies[
                                                          index]
                                                      .state!
                                                  ? const Text(
                                                      'Accepting',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  : const Text(
                                                      "Not Accepting",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                            ),
                                          ),
                                          Text(
                                            controller
                                                    .customizedVacancies[index]
                                                    .dateOfPosting ??
                                                "",
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.7),
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
              );
  }
}
