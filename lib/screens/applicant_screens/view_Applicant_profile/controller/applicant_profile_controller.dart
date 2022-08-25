import 'package:RapidRecruits/models/applicant_details.dart';
import 'package:RapidRecruits/models/applicant_experience_details.dart';
import 'package:RapidRecruits/models/applicant_qualification_details.dart';
import 'package:RapidRecruits/screens/applicant_screens/add_personal_data/controller/personal_data_controller.dart';
import 'package:RapidRecruits/services/rest.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class ApplicantProfileController extends GetxController {
  RxBool loading = false.obs;

  final apiHelper = GetIt.I<ApiBaseHelper>();

  RxBool exp_loading = false.obs;
  RxBool qua_loading = false.obs;

  TextEditingController designation = TextEditingController();
  TextEditingController institute = TextEditingController();
  TextEditingController qualif_institute = TextEditingController();
  TextEditingController score = TextEditingController();
  TextEditingController detailsField = TextEditingController();
  TextEditingController title = TextEditingController();
  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxString passingYear = ''.obs;

  var applicantExperienceDetails = ApplicantExperienceDetailsModel().obs;
  var applicantQualificationDetails = ApplicantQualificationDetailsModel().obs;

  getExperienceDetails() async {
    exp_loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.getHTTP("${ApiEndpoints.userExperience}/$userName/");
    exp_loading.value = false;
    if (response.hasData) {
      if (response.data!.statusCode == 200) {
        applicantExperienceDetails.value.data =
            ApplicantExperienceDetailsModel.fromJson(response.data!.data).data;
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }

  Future<void> getQualificationDetails() async {
    qua_loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.getHTTP("${ApiEndpoints.userQualification}/$userName/");
    qua_loading.value = false;
    if (response.hasData) {
      if (response.data!.statusCode == 200) {
        applicantQualificationDetails.value.data =
            ApplicantQualificationDetailsModel.fromJson(response.data!.data)
                .data;
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }

  DateFormat formatter = DateFormat('dd/MM/yyyy');

  String userName = '';

  getUserName() async {
    Box? box = await Hive.openBox('userBox');
    userName = box.get("userName");
  }

  // RxBool loading = false.obs;
  submitExperience() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    userName = box.get("userName");
    final response =
        await apiHelper.postHTTP("${ApiEndpoints.userExperience}/$userName/", {
      "designation": designation.text,
      "from_date": fromDate.value,
      "to_date": toDate.value,
      "institute": institute.text,
      "details": detailsField.text
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data!.statusCode == 202) {
        Get.back();
      } else {
        Fluttertoast.showToast(msg: response.data!.data['mssg']);
        Get.back();
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }

  submitQualifications() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    userName = box.get("userName");
    final response = await apiHelper
        .postHTTP("${ApiEndpoints.userQualification}/$userName/", {
      "qualification_title": title.text,
      "institute": qualif_institute.text,
      "passing_year": int.parse(passingYear.value),
      "marks": int.parse(score.text)
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data!.statusCode == 202) {
        Get.back();
      } else {
        Fluttertoast.showToast(msg: response.data!.data['mssg']);
        Get.back();
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }

  ApplicantDetails? details;
  Future<bool> getDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.getHTTP("${ApiEndpoints.applicantAuth}$userName/");
    loading.value = false;
    if (response.hasData) {
      if (response.data!.data['mssg'] == "profile not updated!") {
        return false;
      } else {
        details = ApplicantDetails.fromJson(response.data!.data);
        return true;
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
    return false;
  }
}
