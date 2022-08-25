import 'package:RapidRecruits/screens/institute_screens/applicants/models/candidates_model.dart';
import 'package:RapidRecruits/services/rest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../main.dart';

class SuitableCandidatesController extends GetxController {
  RxBool loading = false.obs;
  List<CandidatesModel> data = [];
  final apiHelper = GetIt.I<ApiBaseHelper>();

  getSuitableCandidates(int id) async {
    loading.value = true;
    final response =
        await apiHelper.getHTTP("${ApiEndpoints.matchingApplicants}$id");
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
}
