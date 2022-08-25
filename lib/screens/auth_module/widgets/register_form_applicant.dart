import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/components/rounded_password_input.dart';
import 'package:RapidRecruits/screens/auth_module/controller/auth_controller_applicant.dart';
import 'package:RapidRecruits/utilities/constants.dart';

class RegisterFormApplicant extends StatefulWidget {
  const RegisterFormApplicant({
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
  State<RegisterFormApplicant> createState() => _RegisterFormApplicantState();
}

class _RegisterFormApplicantState extends State<RegisterFormApplicant> {
  final controller = GetIt.I<AuthControllerApplicant>();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration * 5,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
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
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 40),
                    SvgPicture.asset('assets/images/register.svg'),
                    const SizedBox(height: 40),
                    RoundedInput(
                        icon: Icons.face_rounded,
                        hint: 'User Name',
                        controller: controller.userName,
                        color: kPrimaryColorApplicant),
                    RoundedInput(
                      icon: Icons.mail,
                      hint: 'Email',
                      controller: controller.email,
                      color: kPrimaryColorApplicant,
                    ),
                    RoundedPasswordInput(
                      hint: 'Password',
                      controller: controller.password,
                      color: kPrimaryColorApplicant,
                    ),
                    RoundedPasswordInput(
                      hint: 'Confirm Password',
                      controller: controller.confirmPassword,
                      color: kPrimaryColorApplicant,
                    ),
                    const SizedBox(height: 10),
                    RoundedButton(
                      color: kPrimaryColorApplicant,
                      title: 'SIGN UP',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.signup();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
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
