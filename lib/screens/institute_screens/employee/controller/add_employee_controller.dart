import 'package:RapidRecruits/models/state_model.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../../../main.dart';
import '../../../../services/rest.dart';
import '../models/EmployeeModel.dart';

class AddEmployeeController extends GetxController {
  RxBool searchBar = false.obs;
  RxInt selectedGenderRadio = 0.obs;
  RxInt selectedStatusRadio = 0.obs;
  RxBool loading = false.obs;
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController empId = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController designation = TextEditingController();
  List<EmployeeModel> data = <EmployeeModel>[];
  final apiHelper = GetIt.I<ApiBaseHelper>();

  List<India> tempStates = <India>[];
  List<String> allStates = <String>[];
  String newState = '';
  List<String> keySkills = [];

  TextEditingController skillsController = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  loadStates() async {
    String data = await rootBundle.loadString('assets/location/states.json');
    final jsonResult = stateModelFromJson(data);
    tempStates = jsonResult.india;
    for (var element in jsonResult.india) {
      allStates.add(element.state);
    }
  }

  Future<void> addEmployeeDetails(bool addAnother) async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.postHTTP("${ApiEndpoints.employee}$userName/", {
      "method": "manual",
      "details": {
        "empid": empId.text,
        "name": name.text,
        "DOB": dob.text,
        "gender": selectedGenderRadio.value == 0
            ? "Male"
            : selectedGenderRadio.value == 1
                ? "Female"
                : 'Other',
        "category": category.text,
        "status": selectedGenderRadio.value == 0 ? "Active" : 'Non Active',
        "email": email.text,
        "phone_number": phoneNumber.text,
        "department": department.text,
        "designation": designation.text,
        "state": newState,
        "skills": keySkills
      }
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data!.data['mssg'] == "employee added successfully!") {
        clear();
        if (!addAnother) {
          Get.back();
        }
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  getEmployeeDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response =
        await apiHelper.getHTTP("${ApiEndpoints.employee}$userName/");
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

  getSearchedEmployeeDetails(String empId) async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");

    final response = await apiHelper
        .getHTTP("${ApiEndpoints.searchEmployee}$userName/$empId/");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      if (response.data?.statusCode == 200) {
        data.clear();
        data.add(EmployeeModel.fromJson(response.data!.data['employee']));
      } else if (response.data?.statusCode == 404) {
        Fluttertoast.showToast(msg: response.data?.data['mssg']);
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  clear() {
    name.clear();
    empId.clear();
    dob.clear();
    designation.clear();
    phoneNumber.clear();
    email.clear();
    selectedGenderRadio.value = 0;
    selectedStatusRadio.value = 0;
    category.clear();
    department.clear();
  }
}
