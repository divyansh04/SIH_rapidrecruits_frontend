import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/rest.dart';

Future uploadExcelSheetApi({required XFile excelSheet}) async {
  final apiHelper = GetIt.I<ApiBaseHelper>();
  var dio = Dio();
  try {
    var box = await Hive.openBox('userBox');
    var username = await box.get('userName');
    var api = "${apiHelper.baseURL}employee/$username/";
    FormData formData = FormData.fromMap({});

    String sheet = excelSheet.path.split('/').last;
    {
      formData = FormData.fromMap({
        "details":
            await MultipartFile.fromFile(excelSheet.path, filename: sheet),
        "method": "excel file"
      });
    }
    var response = await dio.post(api, data: formData);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.data['mssg']);
    } else {
      Fluttertoast.showToast(msg: "Failed to upload");
    }
  } on DioError catch (e) {
    if (kDebugMode) {
      print(e);
    }
    Fluttertoast.showToast(msg: "Something went wrong");
  } on SocketException {
    Fluttertoast.showToast(msg: "Please check your internet connection");
  }
}
