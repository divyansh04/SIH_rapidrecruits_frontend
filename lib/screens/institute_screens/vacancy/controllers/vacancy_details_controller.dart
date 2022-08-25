import 'package:RapidRecruits/screens/institute_screens/vacancy/controllers/vacancy_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/models/VacancyModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../../../main.dart';
import '../../../../services/rest.dart';

class VacancyDetailsController extends GetxController {
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
  int? id;
  List<VacancyModel> data = <VacancyModel>[];
  final apiHelper = GetIt.I<ApiBaseHelper>();
  setInitials(VacancyModel details) async {
    loading.value = true;
    id = details.id;
    title = TextEditingController(text: details.title.toString());
    type = TextEditingController(text: details.type.toString());
    experience = TextEditingController(text: details.experience.toString());
    compensation = TextEditingController(text: details.compensation.toString());
    description = TextEditingController(text: details.description.toString());
    qualification =
        TextEditingController(text: details.qualifications.toString());
    responsibilities =
        TextEditingController(text: details.responsibilities.toString());
    skills.value = details.skills!;
    selectedStateRadio.value = details.state! ? 0 : 1;
    loading.value = false;
  }

  Future<void> updateVacancy() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.putHTTP("${ApiEndpoints.vacancy}$userName/", {
      "id": id,
      "title": title.text,
      "type": type.text,
      "experience": experience.text,
      "date_of_posting":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "state": selectedStateRadio.value==0?true:false,
      "description": description.text,
      "responsibilities": responsibilities.text,
      "qualifications": qualification.text,
      "skills": skills,
      "compensation": double.parse(compensation.text)
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data?.statusCode == 204 ) {
        clear();
        final controller = GetIt.I<AddVacancyController>();
        controller.getVacancies();
        Get.back();
      }
      Fluttertoast.showToast(msg: "Updated Vacancy Successfully!");
      logger.d(response.data!.data);
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
