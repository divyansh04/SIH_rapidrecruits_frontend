import 'package:RapidRecruits/screens/institute_screens/applicants/models/candidates_model.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/widgets/experience_card.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/widgets/qualifications_card.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../components/full_screen_image.dart';
import '../../events_schedule_module.dart/login_screen.dart';
import 'controller/applied_applicants_controller.dart';

class AppliedApplicantProfile extends StatefulWidget {
  const AppliedApplicantProfile(
      {Key? key, required this.data, required this.vacId})
      : super(key: key);
  final CandidatesModel data;
  final int vacId;
  @override
  State<AppliedApplicantProfile> createState() =>
      _AppliedApplicantProfileState();
}

class _AppliedApplicantProfileState extends State<AppliedApplicantProfile> {
  final controller = GetIt.I<AppliedApplicantsController>();
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
            title: const Text('Applicant Details'),
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
                ],
              ),
            ),
          )),
          bottomNavigationBar: widget.data.status == 'hired'
              ? MaterialButton(
                  height: 50,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green,
                  child: const Text('Hired',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                )
              : widget.data.status == 'rejected'
                  ? MaterialButton(
                      height: 50,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      child: const Text('Rejected',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ):widget.data.status == 'meet scheduled'?
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10),
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {
                      controller.changeStatus('hired', widget.vacId,
                          widget.data.personaldetails!.username!);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: kPrimaryColorInstitute,
                    child: const Text('Hire',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 4.0),
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {
                      controller.changeStatus(
                          'rejected',
                          widget.vacId,
                          widget.data.personaldetails!.username!);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: kPrimaryColorInstitute,
                    child: const Text('Reject',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MaterialButton(
                      height: 50,
                      onPressed: () {

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: kPrimaryColorInstitute,
                      child: const Text(
                        'Edit Meet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      )),
                ),
              ),
            ],
          )
                  : Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: MaterialButton(
                              height: 50,
                              onPressed: () {
                                controller.changeStatus('hired', widget.vacId,
                                    widget.data.personaldetails!.username!);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: kPrimaryColorInstitute,
                              child: const Text('Hire',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: MaterialButton(
                              height: 50,
                              onPressed: () {
                                controller.changeStatus(
                                    'rejected',
                                    widget.vacId,
                                    widget.data.personaldetails!.username!);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: kPrimaryColorInstitute,
                              child: const Text('Reject',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MaterialButton(
                                height: 50,
                                onPressed: () {
                                  Get.to(const SignInGoogle());
                                  // controller.changeStatus(
                                  //     'meet scheduled',
                                  //     widget.vacId,
                                  //     widget.data.personaldetails!.username!);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: kPrimaryColorInstitute,
                                child: const Text(
                                  'Schedule Meet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
