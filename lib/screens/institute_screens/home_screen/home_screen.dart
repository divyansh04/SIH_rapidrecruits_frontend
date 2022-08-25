import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../employee/employees_list_screen.dart';
import '../vacancy/vacancies_screen.dart';
import 'controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = GetIt.I<DashboardController>();

  @override
  void initState() {
    controller.getDashboardDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Center(
                child: SizedBox(
                    height: 150, child: Image.asset('assets/images/logo.png')),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const EmployeesScreen(
                        showBackButton: true,
                      ));
                    },
                    child: Stack(children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 160,
                            width: Get.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/total.png')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Total Employees',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: kPrimaryColorInstitute,
                          child: Text(
                            controller.employeeCount.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const VacanciesScreen());
                    },
                    child: Stack(children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 160,
                            width: Get.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/vacancy.png')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Open Vacancies',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: kPrimaryColorInstitute,
                          child: Text(
                            controller.vacanciesCount.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const EmployeesScreen(
                        showBackButton: true,
                        employeeType: 'active',
                      ));
                    },
                    child: Stack(children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 160,
                            width: Get.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/active.png')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Active Employees',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: kPrimaryColorInstitute,
                          child: Text(
                            controller.activeCount.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const EmployeesScreen(
                        showBackButton: true,
                        employeeType: 'notActive',
                      ));
                    },
                    child: Stack(children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 160,
                            width: Get.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/not_active.png')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Employees on \n Notice Period',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: kPrimaryColorInstitute,
                          child: Text(
                            controller.nonActiveCount.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
