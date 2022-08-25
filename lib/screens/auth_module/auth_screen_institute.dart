import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:RapidRecruits/screens/auth_module/controller/auth_controller_institute.dart';
import 'package:RapidRecruits/screens/auth_module/widgets/login_form_institute.dart';
import 'package:RapidRecruits/screens/auth_module/widgets/register_form_institute.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'widgets/cancel_button.dart';

class AuthScreenInstitute extends StatefulWidget {
  const AuthScreenInstitute({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthScreenInstituteState createState() => _AuthScreenInstituteState();
}

class _AuthScreenInstituteState extends State<AuthScreenInstitute>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = const Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
  final controller = GetIt.I<AuthControllerInstitute>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context)
        .viewInsets
        .bottom; // we are using this to determine Keyboard is opened or not
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize =
        Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize)
            .animate(CurvedAnimation(
            parent: animationController!, curve: Curves.linear));

    return Obx(()=>
        ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(color: kPrimaryColorInstitute,),
          inAsyncCall: controller.loginLoading.value,
          child: ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(color: kPrimaryColorInstitute,),
            inAsyncCall: controller.signupLoading.value,
            child: Scaffold(
              body: Stack(
                children: [
                  // Lets add some decorations
                  Positioned(
                      top: 100,
                      right: -50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: kPrimaryColorInstitute),
                      )),

                  Positioned(
                      top: -50,
                      left: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: kPrimaryColorInstitute),
                      )),

                  // Cancel Button
                  CancelButton(
                    color: kPrimaryColorInstitute,
                    isLogin: isLogin,
                    animationDuration: animationDuration,
                    size: size,
                    animationController: animationController,
                    tapEvent: isLogin
                        ? null
                        : () {
                      // returning null to disable the button
                      animationController!.reverse();
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                  ),

                  // Login Form
                  LoginFormInstitute(
                      isLogin: isLogin,
                      animationDuration: animationDuration,
                      size: size,
                      defaultLoginSize: defaultLoginSize),

                  // Register Container
                  AnimatedBuilder(
                    animation: animationController!,
                    builder: (context, child) {
                      if (viewInset == 0 && isLogin) {
                        return buildRegisterContainer();
                      } else if (!isLogin) {
                        return buildRegisterContainer();
                      }

                      // Returning empty container to hide the widget
                      return Container();
                    },
                  ),

                  // Register Form
                  RegisterFormInstitute(
                      isLogin: isLogin,
                      animationDuration: animationDuration,
                      size: size,
                      defaultLoginSize: defaultRegisterSize),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              topRight: Radius.circular(100),
            ),
            color: kBackgroundColor),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin
              ? null
              : () {
            animationController!.forward();

            setState(() {
              isLogin = !isLogin;
            });
          },
          child: isLogin
              ? const Text(
            "Don't have an account? Sign up",
            style: TextStyle(color: kPrimaryColorInstitute, fontSize: 18),
          )
              : null,
        ),
      ),
    );
  }
}
