import 'dart:io';
import 'package:RapidRecruits/components/rounded_button.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../components/rounded_input.dart';
import 'controller/add_details_controller.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final controller = GetIt.I<AddDetailsControllerInstitute>();
  String userName = '';
  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    Box? box = await Hive.openBox('userBox');
    userName = box.get("userName");
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColorInstitute,
        ),
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Add Details',
              style: TextStyle(color: Colors.black, fontSize: 21),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Employee Id Proof:",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          uploadImage();
                        },
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: kPrimaryColorInstitute,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 46,
                              backgroundImage: controller.imageUrl.value == ''
                                  ? null
                                  : NetworkImage(controller.imageUrl.value),
                              child: controller.imageUrl.value == ''
                                  ? const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 35,
                                      color: kPrimaryColorInstitute,
                                    )
                                  : null),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundedInput(
                          color: kPrimaryColorInstitute,
                          icon: Icons.perm_identity,
                          keyboardType: TextInputType.number,
                          controller: controller.empId,
                          hint: 'Employee Id'),
                      RoundedInput(
                          color: kPrimaryColorInstitute,
                          icon: Icons.location_on_outlined,
                          controller: controller.location,
                          hint: 'Location'),
                      RoundedInput(
                          color: kPrimaryColorInstitute,
                          icon: Icons.web_sharp,
                          controller: controller.website,
                          hint: 'Website'),
                      RoundedInput(
                          color: kPrimaryColorInstitute,
                          icon: Icons.email_outlined,
                          controller: controller.dirMail,
                          hint: 'Director mail id'),
                      RoundedInput(
                          color: kPrimaryColorInstitute,
                          icon: Icons.email_outlined,
                          controller: controller.regMail,
                          hint: 'Registrar mail id'),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                          title: 'Submit',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.addDetails();
                            }
                          },
                          color: kPrimaryColorInstitute)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  uploadImage() async {
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
        controller.loading.value = true;
        //Upload to Firebase
        var snapshot = await firebaseStorage
            .ref()
            .child('EmpIdPic/$userName')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          controller.imageUrl.value = downloadUrl;
        });
      }
    } else {}
    controller.loading.value = false;
  }
}
