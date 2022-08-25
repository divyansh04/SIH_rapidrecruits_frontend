import 'package:RapidRecruits/screens/institute_screens/recruitment_committee/controller/add_recruitment_comittee_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/models/VacancyModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../utilities/constants.dart';

class AddRecruitmentCommittee extends StatefulWidget {
  const AddRecruitmentCommittee({Key? key, required this.data})
      : super(key: key);
  final VacancyModel data;

  @override
  State<AddRecruitmentCommittee> createState() =>
      _AddRecruitmentCommitteeState();
}

class _AddRecruitmentCommitteeState extends State<AddRecruitmentCommittee> {
  @override
  void initState() {
    initial();
    super.initState();
  }

  initial() async {
    controller.getEmployees();
    if (widget.data.recruitmentCommittee!) {
      await controller.getRecruitmentCommittee(widget.data.id!);
      for (int i = 0; i < controller.committee.length; i++) {
        controller.selected.add(controller.committee[i].id!);
      }
    }
  }

  final controller = GetIt.I<AddRecruitmentCommitteeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text('Recruitment Committee'),
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
                                  onTap: () {},
                                  child: Container(
                                    height: 90,
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
                                                "${controller.data[index].name ?? ""} (${controller.data[index].empId ?? ""})",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(controller
                                                      .data[index].email ??
                                                  ""),
                                              Text(controller.data[index]
                                                      .designation ??
                                                  ""),
                                            ],
                                          ),
                                          Obx(() => IconButton(
                                                onPressed: () {
                                                  if (!controller.selected
                                                      .contains(controller
                                                          .data[index].id)) {
                                                    if (controller
                                                            .selected.length >=
                                                        5) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Maximum 5 can be added");
                                                    } else {
                                                      controller.selected.add(
                                                          controller
                                                              .data[index].id!);
                                                    }
                                                  } else {
                                                    controller.selected.remove(
                                                        controller
                                                            .data[index].id!);
                                                  }
                                                },
                                                color: kPrimaryColorInstitute,
                                                icon: controller.selected
                                                        .contains(controller
                                                            .data[index].id)
                                                    ? const Icon(
                                                        Icons.check_box)
                                                    : const Icon(Icons
                                                        .check_box_outline_blank),
                                              )),
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
        bottomNavigationBar: MaterialButton(
          height: 50,
          onPressed: () {
            if (widget.data.recruitmentCommittee!) {
              controller.updateRecruitmentCommittee(widget.data.id!);
            } else {
              controller.addRecruitmentCommittee(widget.data.id!);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: kPrimaryColorInstitute,
          child: Text(
            widget.data.recruitmentCommittee! ? 'Update' : 'Save',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.selected().clear();
    super.dispose();
  }
}
