import 'package:RapidRecruits/screens/institute_screens/applicants/models/candidates_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../main.dart';
import '../../../../services/rest.dart';

class AppliedApplicantsController extends GetxController {
  RxBool loading = false.obs;
  List<CandidatesModel> data = [];
  final apiHelper = GetIt.I<ApiBaseHelper>();

  getAppliedCandidates(int id) async {
    loading.value = true;
    final response =
        await apiHelper.getHTTP("${ApiEndpoints.applicantsApplied}$id");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      if (response.data?.statusCode == 200) {
        data.clear();
        for (var each in response.data!.data['applicants']) {
          data.add(CandidatesModel.fromJson(each));
        }
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  Future<void> changeStatus(
      String status, int vacId, String applicantUserName) async {
    loading.value = true;
    final response = await apiHelper.putHTTP(
        "${ApiEndpoints.changeStatus}$vacId/$applicantUserName/",
        {"status": status});
    loading.value = false;
    if (response.hasData) {
      if (response.data!.statusCode == 200 ||
          response.data!.data['mssg'] == "Status updated successfully") {
        getAppliedCandidates(vacId);
        Get.back();
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
}
