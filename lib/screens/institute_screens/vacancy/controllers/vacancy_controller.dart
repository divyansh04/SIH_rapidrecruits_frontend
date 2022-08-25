import 'package:RapidRecruits/screens/institute_screens/vacancy/models/VacancyModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../../../main.dart';
import '../../../../services/rest.dart';

class AddVacancyController extends GetxController {
  RxBool loading = false.obs;
  RxInt selectedStateRadio = 0.obs;
  RxList<String> skills = <String>[].obs;
  TextEditingController title = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController compensation = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController responsibilities = TextEditingController();
  List<VacancyModel> data = <VacancyModel>[];
  RxList<bool> actions = <bool>[].obs;
  final apiHelper = GetIt.I<ApiBaseHelper>();
  Future<void> createVacancy() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.postHTTP("${ApiEndpoints.vacancy}$userName/", {
      "title": title.text,
      "type": type.text,
      "experience": experience.text,
      "date_of_posting":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "state": true,
      "description": description.text,
      "responsibilities": responsibilities.text,
      "qualifications": qualification.text,
      "skills": skills,
      "compensation": int.parse(compensation.text)
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data?.statusCode == 201 ||
          response.data!.data['mssg'] == "Vacancy posted successfully!") {
        clear();
        Get.back();
        getVacancies();
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  getVacancies() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response =
        await apiHelper.getHTTP("${ApiEndpoints.vacancy}$userName");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      data.clear();
      for (var each in response.data!.data['vacancies']) {
        data.add(VacancyModel.fromJson(each));
        actions.add(false);
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  clear() {
    title.clear();
    type.clear();
    experience.clear();
    compensation.clear();
    compensation.clear();
    description.clear();
    qualification.clear();
    responsibilities.clear();
    skills.clear();
    selectedStateRadio.value = 0;
  }
}
