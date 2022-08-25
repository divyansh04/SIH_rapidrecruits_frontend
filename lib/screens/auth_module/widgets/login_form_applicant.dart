import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/components/rounded_password_input.dart';

import '../../../utilities/constants.dart';
import '../auth_screen_institute.dart';
import '../controller/auth_controller_applicant.dart';

class LoginFormApplicant extends StatefulWidget {
  const LoginFormApplicant({
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
  State<LoginFormApplicant> createState() => _LoginFormApplicantState();
}

class _LoginFormApplicantState extends State<LoginFormApplicant> {
  final controller = GetIt.I<AuthControllerApplicant>();
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
                    'Welcome Back\nApplicant',
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
                    color: kPrimaryColorApplicant,
                  ),
                  RoundedPasswordInput(
                    hint: 'Password',
                    controller: controller.password,
                    color: kPrimaryColorApplicant,
                  ),
                  const SizedBox(height: 10),
                  RoundedButton(
                    color: kPrimaryColorApplicant,
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
                        Get.offAll(const AuthScreenInstitute());
                      },
                      child: const Text(
                        "LogIn as Institute/University?",
                        style: TextStyle(
                            color: kPrimaryColorApplicant, fontSize: 18),
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
