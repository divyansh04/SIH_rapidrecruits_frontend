import 'package:RapidRecruits/screens/institute_screens/employee/employee_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../utilities/constants.dart';
import 'controller/add_employee_controller.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen(
      {Key? key, this.showBackButton = false, this.employeeType = 'all'})
      : super(key: key);
  final bool showBackButton;
  final String employeeType;
  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  @override
  void initState() {
    controller.getEmployeeDetails();
    super.initState();
  }

  final controller = GetIt.I<AddEmployeeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: widget.showBackButton,
          centerTitle: true,
          title: const Text('Employees'),
          backgroundColor: kPrimaryColorInstitute,
          actions: [
            IconButton(
              onPressed: () {
                controller.searchBar.value = true;
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
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
                          "No Employees Found",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Visibility(
                            visible: controller.searchBar.value,
                            child: searchBar()),
                        SizedBox(
                          height: Get.height - 120,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: controller.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (widget.employeeType == 'active') {
                                  if (controller.data[index].status ==
                                      "Active") {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(EmployeeDetails(
                                              details: controller.data[index],
                                            ));
                                          },
                                          child: Container(
                                            height: 90,
                                            width: Get.width,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "${controller.data[index].name ?? ""} (${controller.data[index].empId ?? ""})",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(controller
                                                              .data[index]
                                                              .email ??
                                                          ""),
                                                      Text(controller
                                                              .data[index]
                                                              .designation ??
                                                          ""),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 28,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: controller
                                                                    .data[index]
                                                                    .status
                                                                    ?.toUpperCase() ==
                                                                'ACTIVE'
                                                            ? Colors.green
                                                                .withOpacity(
                                                                    0.3)
                                                            : Colors.red
                                                                .withOpacity(
                                                                    0.3)),
                                                    child: Center(
                                                      child: controller
                                                                  .data[index]
                                                                  .status ==
                                                              'Non Active'
                                                          ? const Text(
                                                              'Notice Period',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          : const Text(
                                                              "Working",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider()
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else if (widget.employeeType == 'notActive') {
                                  if (controller.data[index].status ==
                                      "Non Active") {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(EmployeeDetails(
                                              details: controller.data[index],
                                            ));
                                          },
                                          child: Container(
                                            height: 90,
                                            width: Get.width,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "${controller.data[index].name ?? ""} (${controller.data[index].empId ?? ""})",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(controller
                                                              .data[index]
                                                              .email ??
                                                          ""),
                                                      Text(controller
                                                              .data[index]
                                                              .designation ??
                                                          ""),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 28,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: controller
                                                                    .data[index]
                                                                    .status
                                                                    ?.toUpperCase() ==
                                                                'ACTIVE'
                                                            ? Colors.green
                                                                .withOpacity(
                                                                    0.3)
                                                            : Colors.red
                                                                .withOpacity(
                                                                    0.3)),
                                                    child: Center(
                                                      child: controller
                                                                  .data[index]
                                                                  .status ==
                                                              'Non Active'
                                                          ? const Text(
                                                              'Notice Period',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          : const Text(
                                                              "Working",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider()
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(EmployeeDetails(
                                            details: controller.data[index],
                                          ));
                                        },
                                        child: Container(
                                          height: 90,
                                          width: Get.width,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "${controller.data[index].name ?? ""} (${controller.data[index].empId ?? ""})",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(controller.data[index]
                                                            .email ??
                                                        ""),
                                                    Text(controller.data[index]
                                                            .designation ??
                                                        ""),
                                                  ],
                                                ),
                                                Container(
                                                  height: 28,
                                                  width: 110,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: controller
                                                                  .data[index]
                                                                  .status
                                                                  ?.toUpperCase() ==
                                                              'ACTIVE'
                                                          ? Colors.green
                                                              .withOpacity(0.3)
                                                          : Colors.red
                                                              .withOpacity(
                                                                  0.3)),
                                                  child: Center(
                                                    child: controller
                                                                .data[index]
                                                                .status ==
                                                            'Non Active'
                                                        ? const Text(
                                                            'Notice Period',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        : const Text(
                                                            "Working",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Divider()
                                    ],
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black38.withAlpha(10),
          border: Border.all(color: Colors.black.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller.search,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Search Employee Id",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withAlpha(120),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                cursorColor: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                controller.getSearchedEmployeeDetails(controller.search.text);
              },
              icon: Icon(
                Icons.search,
                color: Colors.black.withAlpha(120),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.searchBar.value = false;
                controller.getEmployeeDetails();
              },
              icon: Icon(
                Icons.clear,
                color: Colors.black.withAlpha(120),
              ),
            )
          ],
        ),
      ),
    );
  }
}
