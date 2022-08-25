import 'package:RapidRecruits/screens/institute_screens/applicants/controller/suitable_candidates_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/suitable_candidates_profile.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SuitableCandidates extends StatefulWidget {
  const SuitableCandidates({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<SuitableCandidates> createState() => _SuitableCandidatesState();
}

class _SuitableCandidatesState extends State<SuitableCandidates> {
  @override
  void initState() {
    controller.getSuitableCandidates(widget.id);
    super.initState();
  }

  final controller = GetIt.I<SuitableCandidatesController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text('Suitable Candidates'),
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
                          "No Candidates Found",
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
                                    Get.to(SuitableCandidateProfile(data: controller.data[index],vacId: widget.id,));
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
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundColor:
                                                  kPrimaryColorInstitute,
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundColor: Colors.white,
                                                backgroundImage: NetworkImage(
                                                    controller
                                                        .data[index]
                                                        .personaldetails!
                                                        .profilePic!),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
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
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Experience: ${controller.data[index].personaldetails!.totalExperience.toString()} Years",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Flexible(
                                                  child: Text("Skills: ${
                                                      controller
                                                          .data[index]
                                                          .personaldetails!
                                                          .skillSet!
                                                          .join(', ')}",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                            0.7),
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        overflow:
                                                        TextOverflow
                                                            .visible,),
                                                  ),
                                                ),
                                              ],
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
                          }),
                    ),
                  ),
      ),
    );
  }
}
