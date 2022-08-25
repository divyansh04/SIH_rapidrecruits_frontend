import 'package:RapidRecruits/screens/institute_screens/add_details/add_details_screen.dart';
import 'package:RapidRecruits/screens/institute_screens/dashboard/dashboard_institute.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:RapidRecruits/main.dart';
import 'package:RapidRecruits/services/rest.dart';

class AuthControllerInstitute extends GetxController {
  RxBool signupLoading = false.obs;
  RxBool loginLoading = false.obs;
  final apiHelper = GetIt.I<ApiBaseHelper>();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> signup() async {
    signupLoading.value = true;
    final response = await apiHelper.postHTTP(ApiEndpoints.instituteAuth, {
      "purpose": "signup",
      "username": userName.text,
      "email": email.text,
      "password": password.text,
      "confirm_password": confirmPassword.text
    });
    signupLoading.value = false;
    if (response.hasData) {
      if (response.data!.data['mssg'] == "user signed up successfully!") {
        Box? box = await Hive.openBox('userBox');
        box.put("token", true);
        box.put("userType", 'institute');
        box.put("userName", userName.text);
        Get.offAll(const AddDetailsScreen());
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  Future<void> login() async {
    loginLoading.value = true;
    final response = await apiHelper.postHTTP(ApiEndpoints.instituteAuth, {
      "purpose": "login",
      "username": userName.text,
      "password": password.text
    });
    loginLoading.value = false;
    if (response.hasData) {
      if (response.data!.data['mssg'] == "user logedin successfully!") {
        Box? box = await Hive.openBox('userBox');
        box.put("token", true);
        box.put("userType", 'institute');
        box.put("userName", userName.text);
        Get.offAll(const DashBoardInstitute());
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
}