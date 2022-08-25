import 'package:RapidRecruits/main.dart';
import 'package:RapidRecruits/screens/institute_screens/employee/models/EmployeeModel.dart';
import 'package:RapidRecruits/services/rest.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'add_employee_controller.dart';

class EmployeeDetailsController extends GetxController {
  RxBool loading = false.obs;
  RxInt selectedGenderRadio = 0.obs;
  RxInt selectedStatusRadio = 0.obs;
  int? id;
  TextEditingController name = TextEditingController();
  TextEditingController empId = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController designation = TextEditingController();
  setInitials(EmployeeModel details) async {
    loading.value = true;
    id = details.id;
    name = TextEditingController(text: details.name.toString());
    empId = TextEditingController(text: details.empId.toString());
    department= TextEditingController(text: details.department.toString());
    email = TextEditingController(text: details.email.toString());
    dob = TextEditingController(text: details.dob.toString());
    phoneNumber = TextEditingController(text: details.phoneNumber.toString());
    category = TextEditingController(text: details.category.toString());
    designation = TextEditingController(text: details.designation.toString());
    selectedStatusRadio.value = details.status == "Active" ? 0 : 1;
    selectedGenderRadio.value = details.gender == "Male"
        ? 0
        : details.gender == "Female"
            ? 1
            : 2;
    loading.value = false;
  }

  final apiHelper = GetIt.I<ApiBaseHelper>();
  Future<void> updateEmployeeDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.putHTTP("${ApiEndpoints.employee}$userName/", {
      "id": id,
      "name": name.text,
      "DOB": dob.text,
      "gender": selectedGenderRadio.value == 0
          ? "Male"
          : selectedGenderRadio.value == 1
              ? "Female"
              : 'Other',
      "category": category.text,
      "status": selectedStatusRadio.value == 0 ? "Active" : 'Non Active',
      "email": email.text,
      "phone_number": phoneNumber.text,
      "designation": designation.text,
      "empid": empId.text,
      "department": department.text
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data?.statusCode == 204) {
        final controller = GetIt.I<AddEmployeeController>();
        await controller.getEmployeeDetails();
        Get.back();
      }
      Fluttertoast.showToast(msg: "employee details updated successfully");
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }
}
