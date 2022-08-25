import 'package:RapidRecruits/components/non_editable_rounded_field.dart';
import 'package:RapidRecruits/screens/auth_module/auth_screen_institute.dart';
import 'package:RapidRecruits/screens/institute_screens/user_profile/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../utilities/constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    controller.getDetails();
    super.initState();
  }

  final controller = GetIt.I<UserProfileController>();

  final _googleSignIn = GoogleSignIn();
  Future<void> _handleSignOut() => _googleSignIn.disconnect();
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
            title: const Text(
              'User Details',
              style: TextStyle(color: Colors.black, fontSize: 21),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () async {
                    Box? box = await Hive.openBox('userBox');
                    box.put("token", false);
                    box.clear();
                 await _handleSignOut();
                    Get.offAll(() => const AuthScreenInstitute());
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NonEditableRoundedInput(
                        color: kPrimaryColorInstitute,
                        icon: Icons.perm_identity,
                        controller: controller.empId,
                        hint: 'Employee Id'),
                    NonEditableRoundedInput(
                        color: kPrimaryColorInstitute,
                        icon: Icons.perm_identity,
                        controller: controller.username,
                        hint: 'User Name'),
                    NonEditableRoundedInput(
                        color: kPrimaryColorInstitute,
                        icon: Icons.email_outlined,
                        controller: controller.email,
                        hint: 'Email'),
                    NonEditableRoundedInput(
                        color: kPrimaryColorInstitute,
                        icon: Icons.location_on_outlined,
                        controller: controller.location,
                        hint: 'Location'),
                    NonEditableRoundedInput(
                        color: kPrimaryColorInstitute,
                        icon: Icons.web_sharp,
                        controller: controller.website,
                        hint: 'Website'),
                    NonEditableRoundedInput(
                        color: kPrimaryColorInstitute,
                        icon: Icons.email_outlined,
                        controller: controller.dirMail,
                        hint: 'Director mail id'),
                    NonEditableRoundedInput(
                        color: kPrimaryColorInstitute,
                        icon: Icons.email_outlined,
                        controller: controller.regMail,
                        hint: 'Registrar mail id'),
                    const SizedBox(
                      height: 10,
                    ),
                    // SizedBox(
                    //   width: Get.width-80,
                    //   child: MaterialButton(
                    //     height: 50,
                    //     onPressed: () async {
                    //       Box? box = await Hive.openBox('userBox');
                    //       box.clear();
                    //       Get.offAll(const AuthScreenInstitute());
                    //     },
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15)),
                    //     color: kPrimaryColorInstitute,
                    //     child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    //       children: const [
                    //         Text('Log Out',
                    //             style: TextStyle(color: Colors.white, fontSize: 18)),
                    //         SizedBox(width: 10,),
                    //         Icon(Icons.logout_outlined,color: Colors.white,)
                    //       ],
                    //     ),
                    //   ),
                    // )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
