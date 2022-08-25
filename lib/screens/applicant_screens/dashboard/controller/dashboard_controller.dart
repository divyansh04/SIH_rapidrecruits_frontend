import 'package:RapidRecruits/screens/applicant_screens/add_personal_data/add_personal_data.dart';
import 'package:RapidRecruits/screens/applicant_screens/add_personal_data/controller/personal_data_controller.dart';
import 'package:get/get.dart';

class DashboardControllerApplicant extends GetxController {
  RxBool loading = false.obs;
  final personalDataController = Get.put(ApplicantPersonalDataController());
  checkDetails() async {
    loading.value = true;
    bool value = await personalDataController.getDetails();
    if (!value) {
      Get.offAll(() => const AddApplicantPersonalData());
    }
    loading.value = false;
  }
}
