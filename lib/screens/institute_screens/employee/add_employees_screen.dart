// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:RapidRecruits/screens/institute_screens/employee/add_employee.dart';
import 'package:RapidRecruits/screens/institute_screens/employee/controller/add_employees_controller.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AddEmployeesScreen extends StatefulWidget {
  const AddEmployeesScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeesScreen> createState() => _AddEmployeesScreenState();
}

class _AddEmployeesScreenState extends State<AddEmployeesScreen> {
  final controller = GetIt.I<AddEmployeesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(color: kPrimaryColorInstitute,),
        inAsyncCall: controller.loading.value,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text('Add Employees'),
              backgroundColor: kPrimaryColorInstitute,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                      height: 60,
                      onPressed: () {
                        controller.showDetails.value =
                            !controller.showDetails.value;
                      },
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: kPrimaryColorInstitute,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Add Employees using ExcelSheet',
                          style: TextStyle(
                              color: kPrimaryColorInstitute, fontSize: 18)),
                    ),
                    Visibility(
                        visible: controller.showDetails.value,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'To add the employees through the ExcelSheet, Upload an ExcelSheet containing details of all the employees.\n \nNote: Please refer to the ExcelSheet attached.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: MaterialButton(
                                height: 50,
                                onPressed: () async {
                                  downloadFile();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: kPrimaryColorInstitute,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Download Sample ExcelSheet',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Image.asset(
                                          "assets/images/Microsoft_Excel.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: MaterialButton(
                                height: 50,
                                onPressed: () {
                                  getExcelAndUpload();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: kPrimaryColorInstitute,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Upload ExcelSheet',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Image.asset(
                                          "assets/images/Microsoft_Excel.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      height: 60,
                      onPressed: () {
                        Get.to(const AddEmployeeScreen());
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: kPrimaryColorInstitute,
                      child: const Text('Add Employees Manually',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> downloadFile() async {
    final Reference ref = FirebaseStorage.instance.ref('Employee Details.xlsx');
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final File tempFile = File("$appDocPath/Employee Details.xlsx");
    try {
      await ref.writeToFile(tempFile);
      await tempFile.create();
      await OpenFile.open(tempFile.path);
    } on FirebaseException {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error, unable to load file',
          ),
        ),
      );
    }
  }

  Future getExcelAndUpload() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (file != null) {
      controller.uploadExcelSheet(XFile(file.paths[0]!));
    }
  }
}
