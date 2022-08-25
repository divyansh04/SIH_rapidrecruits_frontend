import 'package:RapidRecruits/services/rest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../../main.dart';

class DashboardController extends GetxController {
  RxBool loading = false.obs;
  final apiHelper = GetIt.I<ApiBaseHelper>();
  RxInt employeeCount=0.obs;
  RxInt vacanciesCount=0.obs;
  RxInt activeCount=0.obs;
  RxInt nonActiveCount=0.obs;

  getDashboardDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response =
    await apiHelper.getHTTP("${ApiEndpoints.dashboard}$userName");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      if(response.data?.statusCode==200){
        employeeCount.value=response.data?.data['employee_count'];
        vacanciesCount.value=response.data?.data['vacancies_count'];
        activeCount.value=response.data?.data['active_employee_count'];
        nonActiveCount.value=response.data?.data['non_active_employee_count'];
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
}
