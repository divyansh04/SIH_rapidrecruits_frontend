import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/controller/approach_candidate_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/models/candidates_model.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/widgets/experience_card.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/widgets/qualifications_card.dart';
import 'package:RapidRecruits/services/dynamic_links.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../components/full_screen_image.dart';

class SuitableCandidateProfile extends StatefulWidget {
  const SuitableCandidateProfile(
      {Key? key, required this.data, required this.vacId})
      : super(key: key);
  final CandidatesModel data;
  final int vacId;
  @override
  State<SuitableCandidateProfile> createState() =>
      _SuitableCandidateProfileState();
}

class _SuitableCandidateProfileState extends State<SuitableCandidateProfile> {
  final controller = GetIt.I<ApproachCandidateController>();
  DynamicLinkService service = DynamicLinkService();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColorInstitute,
        ),
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text('Candidate Details'),
            backgroundColor: kPrimaryColorInstitute,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: kPrimaryColorInstitute),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 4,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: Get.width,
                      height: 200,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: kPrimaryColorInstitute,
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 46,
                                  backgroundImage: widget.data.personaldetails!
                                              .profilePic! ==
                                          ''
                                      ? null
                                      : NetworkImage(widget
                                          .data.personaldetails!.profilePic!),
                                  child: widget.data.personaldetails!
                                              .profilePic! ==
                                          ''
                                      ? const Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 35,
                                          color: kPrimaryColorInstitute,
                                        )
                                      : null),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.data.personaldetails!.fullName}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text('${widget.data.personaldetails!.phoneNumber}'),
                            const SizedBox(height: 8),
                            Text('${widget.data.personaldetails!.description}'),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Experience : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  widget.data.experiencedetails!.isEmpty
                      ? const Text('No Experiences Found!')
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.data.experiencedetails!.length,
                              itemBuilder: (_, i) {
                                var element = widget.data.experiencedetails![i];
                                return ApplicantExperienceCard(
                                    element: element);
                              }),
                        ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Qualifications : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  widget.data.qualificationdetails!.isEmpty
                      ? const Text('No Qualifications Found!')
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  widget.data.qualificationdetails!.length,
                              itemBuilder: (_, i) {
                                var element =
                                    widget.data.qualificationdetails![i];
                                return ApplicantQualificationCard(
                                    element: element);
                              }),
                        ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Resume: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  widget.data.personaldetails!.resume == ''
                      ? const Text('No Resume Found!')
                      : GestureDetector(
                          onTap: () {
                            Get.to(
                              FullScreenImage(
                                  url: widget.data.personaldetails!.resume!),
                            );
                          },
                          child: Hero(
                            tag: 'hero',
                            child: Container(
                              height: 200,
                              width: 160,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Image.network(
                                widget.data.personaldetails!.resume == null
                                    ? ""
                                    : widget.data.personaldetails!.resume!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  RoundedButton(
                      title: 'Approach Candidate',
                      onTap: () async {
                        Uri link =
                            await service.createDynamicLink(widget.vacId);
                        print(link.toString());
                        controller.approachCandidate(
                          widget.data.personaldetails!.username!,
                          widget.vacId,
                          link.toString(),
                        );
                      },
                      color: kPrimaryColorInstitute)
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
