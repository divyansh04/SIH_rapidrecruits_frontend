import 'dart:io';
import 'package:RapidRecruits/main.dart';
import 'package:RapidRecruits/models/applicant_details.dart';
import 'package:RapidRecruits/models/state_model.dart';
import 'package:RapidRecruits/screens/applicant_screens/dashboard/dashboard_applicant.dart';
import 'package:RapidRecruits/services/rest.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ApplicantPersonalDataController extends GetxController {
  final apiHelper = GetIt.I<ApiBaseHelper>();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController skillsController = TextEditingController();

  List<String> keySkills = [];
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  RxBool loading = false.obs;
  RxString profileImageUrl = ''.obs;
  RxString resumeImageUrl = ''.obs;

  List<India> tempStates = <India>[];
  List<String> allStates = <String>[];
  List<String> cities = [];

  String newState = '';
  String city = '';
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  RxString dob = ''.obs;

  String gender = '';
  String category = '';

  String maritalStatus = '';

  loadStates() async {
    String data = await rootBundle.loadString('assets/location/states.json');
    final jsonResult = stateModelFromJson(data);
    tempStates = jsonResult.india;
    for (var element in jsonResult.india) {
      allStates.add(element.state);
    }
  }

  loadCities(String state) {
    // city = null;
    for (India item in tempStates) {
      // ignore: unrelated_type_equality_checks
      if (item.state == state) {
        cities = item.cities;
      }
    }
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String userName = '';

  getUserName() async {
    Box? box = await Hive.openBox('userBox');
    userName = box.get("userName");
  }

  uploadProfileImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    XFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await imagePicker.pickImage(source: ImageSource.gallery);
      var file = File(image?.path ?? "");

      if (image != null) {
        loading.value = true;
        //Upload to Firebase
        var snapshot = await firebaseStorage
            .ref()
            .child('$userName/ApplicantProfileic')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        profileImageUrl.value = downloadUrl;
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
    loading.value = false;
  }

  uploadResumeImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    XFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await imagePicker.pickImage(source: ImageSource.gallery);
      var file = File(image?.path ?? "");

      if (image != null) {
        loading.value = true;
        //Upload to Firebase
        var snapshot =
            await firebaseStorage.ref().child('$userName/Resume').putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        resumeImageUrl.value = downloadUrl;
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
    loading.value = false;
  }

  submit() async {
    loading.value = true;
    final response = await apiHelper.postHTTP(ApiEndpoints.applicantAuth, {
      "purpose": "fill details",
      "username": userName,
      "details": {
        "profile_pic": profileImageUrl.value,
        "description": description.text,
        "full_name": fullName.text,
        "DOB": dob.value,
        "gender": gender,
        "address": address.text,
        "state": newState,
        "pincode": pinCode.text,
        "category": category,
        "marital_status": maritalStatus == 'Married' ? true : false,
        "phone_number": int.parse(phone.text),
        "total_experience": double.parse(experience.text),
        "skillset": keySkills,
        "resume": resumeImageUrl.value
      }
    });
    loading.value = false;
    if (response.hasData) {
      if (response.data!.data['mssg'] == "data updated successfully!") {
        Get.offAll(() => const DashBoardApplicant());
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
      logger.d(response.data!.data);
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
  }

  editProfile() async {
    loading.value = true;
    final response =
        await apiHelper.putHTTP('${ApiEndpoints.applicantAuth}$userName/', {
      "profile_pic": profileImageUrl.value,
      "email": email.text,
      "description": description.text,
      "full_name": fullName.text,
      "DOB": dob.value,
      "gender": gender,
      "address": address.text,
      "state": newState,
      "pincode": pinCode.text,
      "category": category,
      "marital_status": maritalStatus == 'Married' ? true : false,
      "phone_number": int.parse(phone.text),
      "total_experience": double.parse(experience.text),
      "skillset": keySkills,
      "resume": resumeImageUrl.value
    });
    if (response.hasData) {
      if (response.data!.statusCode == 204) {
        await getDetails();
        Fluttertoast.showToast(msg: "Profile Updated!");
        loading.value = false;
        Get.back();
        // Get.offAll(() => const DashBoardApplicant(page: 2));
      }
      Fluttertoast.showToast(msg: response.data!.data['mssg']);
    } else if (response.hasDioError) {
      loading.value = false;
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
    }
    loading.value = false;
  }

  ApplicantDetails? details;
  Future<bool> getDetails() async {
    loading.value = true;
    Box? box = await Hive.openBox('userBox');
    String userName = box.get("userName");
    final response =
        await apiHelper.getHTTP("${ApiEndpoints.applicantAuth}$userName/");
    loading.value = false;
    if (response.hasData) {
      logger.d(response.data!.data);
      if (response.data!.data['mssg'] == "profile not updated!") {
        return false;
      } else {
        details = ApplicantDetails.fromJson(response.data!.data);

        profileImageUrl.value = details!.profilePic!;
        description.text = details!.description!;
        fullName.text = details!.fullName!;
        email.text = details!.email!;
        dob.value = details!.dOB!;
        gender = details!.gender!;
        address.text = details!.address!;
        newState = details!.state!;
        // city=details!. !;
        pinCode.text = details!.pincode.toString();
        category = details!.category!;
        maritalStatus =
            details!.maritalStatus == true ? "Married" : "Unmarried";
        phone.text = details!.phoneNumber.toString();
        experience.text = details!.totalExperience.toString();
        keySkills = details!.skillset!;
        resumeImageUrl.value = details!.resume!;
        return true;
      }
    } else if (response.hasDioError) {
      Fluttertoast.showToast(msg: response.dioError!.response!.data['mssg']);
      logger.d(response.dioError!.response!.data);
    }
    return false;
  }
}
