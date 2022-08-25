import 'package:RapidRecruits/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../../services/rest.dart';

class ApproachCandidateController extends GetxController {
  RxBool loading = false.obs;
  final apiHelper = GetIt.I<ApiBaseHelper>();
  Future<void> approachCandidate(String userName,int id,String link) async {
    loading.value = true;
    final response = await apiHelper.postHTTP(
        "${ApiEndpoints.approachApplicant}$userName/",
        {"link": link, "id": id});
    loading.value = false;
    if (response.hasData) {
      if (response.data!.statusCode == 200 ||
          response.data!.data['mssg'] == "mail sent successfully") {}
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
}
