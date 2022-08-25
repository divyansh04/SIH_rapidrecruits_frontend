import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/components/rounded_input.dart';
import 'package:RapidRecruits/components/rounded_password_input.dart';
import 'package:RapidRecruits/screens/auth_module/controller/auth_controller_institute.dart';
import 'package:RapidRecruits/utilities/constants.dart';

class RegisterFormInstitute extends StatefulWidget {
  const RegisterFormInstitute({
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
  State<RegisterFormInstitute> createState() => _RegisterFormInstituteState();
}

class _RegisterFormInstituteState extends State<RegisterFormInstitute> {
  final controller = GetIt.I<AuthControllerInstitute>();

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
                        color: kPrimaryColorInstitute),
                    RoundedInput(
                      icon: Icons.mail,
                      hint: 'Email',
                      controller: controller.email,
                      color: kPrimaryColorInstitute,
                    ),
                    RoundedPasswordInput(
                      hint: 'Password',
                      controller: controller.password,
                      color: kPrimaryColorInstitute,
                    ),
                    RoundedPasswordInput(
                      hint: 'Confirm Password',
                      controller: controller.confirmPassword,
                      color: kPrimaryColorInstitute,
                    ),
                    const SizedBox(height: 10),
                    RoundedButton(
                      color: kPrimaryColorInstitute,
                      title: 'SIGN UP',
                      onTap: () {
                        controller.signup();
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
