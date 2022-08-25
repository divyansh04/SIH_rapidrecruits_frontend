import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/components/rounded_password_input.dart';
import 'package:RapidRecruits/screens/auth_module/auth_screen_applicant.dart';
import 'package:RapidRecruits/screens/auth_module/controller/auth_controller_institute.dart';
import '../../../utilities/constants.dart';

class LoginFormInstitute extends StatefulWidget {
  const LoginFormInstitute({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  State<LoginFormInstitute> createState() => _LoginFormInstituteState();
}

class _LoginFormInstituteState extends State<LoginFormInstitute> {
  final controller = GetIt.I<AuthControllerInstitute>();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Welcome Back \n Institute/University',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 40),
                  SvgPicture.asset('assets/images/login.svg'),
                  const SizedBox(height: 40),
                  RoundedInput(
                    icon: Icons.face_rounded,
                    hint: 'User Name',
                    controller: controller.userName,
                    color: kPrimaryColorInstitute,
                  ),
                  RoundedPasswordInput(
                    hint: 'Password',
                    controller: controller.password,
                    color: kPrimaryColorInstitute,
                  ),
                  const SizedBox(height: 10),
                  RoundedButton(
                    color: kPrimaryColorInstitute,
                    title: 'LOGIN',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.login();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        Get.offAll(const AuthScreenApplicant());
                      },
                      child: const Text(
                        "LogIn as Applicant?",
                        style: TextStyle(
                            color: kPrimaryColorInstitute, fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
