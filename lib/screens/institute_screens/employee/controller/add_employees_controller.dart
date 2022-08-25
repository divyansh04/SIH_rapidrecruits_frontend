import 'package:RapidRecruits/screens/institute_screens/employee/apis/upload_excel_sheet_api.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeesController extends GetxController{
  RxBool showDetails=false.obs;
  RxBool loading = false.obs;
  // Rx<XFile> excel=XFile('').obs;
  uploadExcelSheet(XFile excel) async {
    loading.value = true;
    await uploadExcelSheetApi(excelSheet: excel);
    loading.value = false;
  }
}