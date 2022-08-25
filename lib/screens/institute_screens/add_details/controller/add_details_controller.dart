import 'package:RapidRecruits/screens/institute_screens/dashboard/dashboard_institute.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../../../main.dart';
import '../../../../services/rest.dart';
import '../models/institute_details.dart';

class AddDetailsControllerInstitute extends GetxController {
  RxBool loading = false.obs;
  TextEditingController empId = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController dirMail = TextEditingController();
  TextEditingController regMail = TextEditingController();
  InstituteDetails? details;
  RxString imageUrl=''.obs;
  final apiHelper = GetIt.I<ApiBaseHelper>();
  Future<void> addDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.postHTTP(ApiEndpoints.instituteAuth, {
      "purpose": "fill details",
      "username": userName,
      "details": {
        "empid": empId.text,
        "empid_pic": imageUrl.value,
        "location": location.text  ,
        "website": website.text,
        "director_mail": dirMail.text,
        "registrar_mail": regMail.text,
        "hod_mail": "ankitwadhwa666@gmail.com"
      }
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data!.data['mssg'] == "data updated successfully!") {
        Get.offAll(const DashBoardInstitute());
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
  Future<bool> getDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =await apiHelper.getHTTP("${ApiEndpoints.instituteAuth}/$userName/");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      if(response.data!.data['mssg']=="profile not updated!"){
        return false;
      }else{
        details=InstituteDetails.fromJson(response.data!.data);
        return true;
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
    return false;
  }
}
