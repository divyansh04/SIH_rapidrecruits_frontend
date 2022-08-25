import 'package:RapidRecruits/screens/applicant_screens/vacancies_module/vacancy_details_view.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/models/VacancyModel.dart';
import 'package:RapidRecruits/services/rest.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class VacanciesController extends GetxController {
  RxBool loading = false.obs;
  RxInt selectedStateRadio = 0.obs;
  RxList<String> skills = <String>[].obs;
  List<VacancyModel> allVacancies = <VacancyModel>[];
  List<VacancyModel> customizedVacancies = <VacancyModel>[];
  final apiHelper = GetIt.I<ApiBaseHelper>();
  VacancyModel? referred;
  TextEditingController title = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController compensation = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController responsibilities = TextEditingController();

  getVacancies() async {
    final response = await apiHelper.getHTTP(ApiEndpoints.vacancy);
    loading.value = false;
    if (response.hasData) {
      allVacancies.clear();
      for (var each in response.data!.data['vacancies']) {
        allVacancies.add(VacancyModel.fromJson(each));
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }

  getCustomizedVacancies() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response =
        await apiHelper.getHTTP("${ApiEndpoints.matchingVacancies}$userName");
    loading.value = false;
    if (response.hasData) {
      customizedVacancies.clear();
      for (var each in response.data!.data['vacancies']) {
        customizedVacancies.add(VacancyModel.fromJson(each));
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }

  applyVacancy(int id) async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response = await apiHelper
        .postHTTP("${ApiEndpoints.applyVacancy}$userName/", {"id": id});
    if (response.hasData) {
      if (response.data!.statusCode == 200) {
        loading.value = false;
        await getVacancies();
        await getCustomizedVacancies();
        Fluttertoast.showToast(msg: 'Applied');
        Get.back();
      } else {
        loading.value = false;
        Fluttertoast.showToast(msg: response.data!.data['mssg']);
        Get.back();
      }
    } else if (response.hasDioError) {
      loading.value = false;
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
    loading.value = false;
  }

  getVacancyById(int id) async {
    loading.value=true;
    final response = await apiHelper.getHTTP("${ApiEndpoints.vacancyById}/$id/");
    loading.value = false;
    if (response.hasData) {
      if (response.data?.statusCode == 200) {
        referred=VacancyModel.fromJson(response.data?.data['vacancy']);
        Get.to(VacancyDetailsView(details: referred!));
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
  }
}
