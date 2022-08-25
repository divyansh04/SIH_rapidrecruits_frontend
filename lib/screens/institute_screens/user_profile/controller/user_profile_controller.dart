import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../../../main.dart';
import '../../../../services/rest.dart';
import '../../add_details/models/institute_details.dart';

class UserProfileController extends GetxController {
  RxBool loading = false.obs;
  TextEditingController empId = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController dirMail = TextEditingController();
  TextEditingController regMail = TextEditingController();
  InstituteDetails? details;
  RxString imageUrl = ''.obs;
  final apiHelper = GetIt.I<ApiBaseHelper>();
  setInitials() async {
    loading.value = true;
    // imageUrl=details.
    empId = TextEditingController(text: details?.empid.toString());
    location = TextEditingController(text: details?.location.toString());
    username = TextEditingController(text: details?.username.toString());
    email = TextEditingController(text: details?.email.toString());
    website = TextEditingController(text: details?.website.toString());
    dirMail = TextEditingController(text: details?.directorMail.toString());
    regMail = TextEditingController(text: details?.registrarMail.toString());
    loading.value = false;
  }

  Future getDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.getHTTP("${ApiEndpoints.instituteAuth}/$userName/");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      details = InstituteDetails.fromJson(response.data!.data);
      setInitials();
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
}
