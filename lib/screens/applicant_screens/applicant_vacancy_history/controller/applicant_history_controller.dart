import 'package:RapidRecruits/screens/institute_screens/vacancy/models/VacancyModel.dart';
import 'package:RapidRecruits/services/rest.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class ApplicantHistoryController extends GetxController {
  RxBool loading = false.obs;
  RxInt selectedStateRadio = 0.obs;
  RxList<String> skills = <String>[].obs;
  List<VacancyModel> appliedVacancies = <VacancyModel>[];
  final apiHelper = GetIt.I<ApiBaseHelper>();

  TextEditingController title = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController compensation = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController responsibilities = TextEditingController();

  getAppliedVacancies() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response = await apiHelper
        .getHTTP("${ApiEndpoints.getVacancyApplicatonHistory}$userName");
    loading.value = false;
    if (response.hasData) {
      appliedVacancies.clear();
      for (var each in response.data!.data['vacancies']) {
        appliedVacancies.add(VacancyModel.fromJson(each));
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }
}
