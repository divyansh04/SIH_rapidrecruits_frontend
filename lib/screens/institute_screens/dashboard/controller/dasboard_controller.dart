import 'package:RapidRecruits/screens/institute_screens/add_details/add_details_screen.dart';
import 'package:get/get.dart';
import '../../add_details/controller/add_details_controller.dart';

class DashboardControllerInstitute extends GetxController {
  RxBool loading=false.obs;
  final controller =Get.put(AddDetailsControllerInstitute());
  checkDetails() async {
    loading.value=true;
    bool value = await controller.getDetails();
    if (!value) {
      Get.offAll(const AddDetailsScreen());
    }
    loading.value=false;
  }
}
