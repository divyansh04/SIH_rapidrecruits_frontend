import 'package:RapidRecruits/screens/institute_screens/recruitment_committee/models/recruitment_committee.dart';
import 'package:RapidRecruits/services/rest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../../main.dart';
import '../../employee/models/EmployeeModel.dart';
import '../../vacancy/controllers/vacancy_controller.dart';

class AddRecruitmentCommitteeController extends GetxController {
  RxBool loading = false.obs;
  final apiHelper = GetIt.I<ApiBaseHelper>();
  List<EmployeeModel> data = <EmployeeModel>[];
  List<RecruitmentCommittee> committee = <RecruitmentCommittee>[];
  RxList<int> selected = <int>[].obs;

  getRecruitmentCommittee(int id) async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response = await apiHelper
        .getHTTP("${ApiEndpoints.recruitmentCommittee}$userName/$id");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      committee.clear();
      for (var each in response.data!.data['data']) {
        committee.add(RecruitmentCommittee.fromJson(each));
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  getEmployees() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response =
        await apiHelper.getHTTP("${ApiEndpoints.employee}$userName");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      data.clear();
      for (var each in response.data!.data['employees']) {
        data.add(EmployeeModel.fromJson(each));
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  Future<void> addRecruitmentCommittee(int id) async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response = await apiHelper
        .postHTTP("${ApiEndpoints.recruitmentCommittee}$userName/$id/", {
      'first': selected[0],
      "second": selected[1],
      'third': selected[2],
      'forth': selected[3],
      'fifth': selected[4],
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data?.statusCode == 204 ||
          response.data!.data['mssg'] == "committee added successfully") {
        final controller = GetIt.I<AddVacancyController>();
        controller.getVacancies();
        Get.back();
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  Future<void> updateRecruitmentCommittee(int id) async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response = await apiHelper
        .putHTTP("${ApiEndpoints.recruitmentCommittee}$userName/$id/", {
      'first': selected[0],
      "second": selected[1],
      'third': selected[2],
      'forth': selected[3],
      'fifth': selected[4],
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data?.statusCode == 204) {
        final controller = GetIt.I<AddVacancyController>();
        controller.getVacancies();
        selected.clear();
        Get.back();
      }
      Fluttertoast.showToast(msg: "Recruitment Committee Updated Successfully");
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
}
