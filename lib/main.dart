import 'package:RapidRecruits/screens/institute_screens/add_details/controller/add_details_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/applicants/controller/approach_candidate_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/dashboard/controller/dasboard_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/employee/controller/add_employee_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/employee/controller/add_employees_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/home_screen/controller/home_screen_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/recruitment_committee/controller/add_recruitment_comittee_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/user_profile/controller/user_profile_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/controllers/vacancy_details_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:RapidRecruits/screens/applicant_screens/dashboard/dashboard_applicant.dart';
import 'package:RapidRecruits/screens/auth_module/controller/auth_controller_institute.dart';
import 'package:RapidRecruits/screens/institute_screens/dashboard/dashboard_institute.dart';
import 'screens/applicant_screens/add_personal_data/controller/personal_data_controller.dart';
import 'screens/applicant_screens/applicant_vacancy_history/controller/applicant_history_controller.dart';
import 'screens/applicant_screens/dashboard/controller/dashboard_controller.dart';
import 'screens/applicant_screens/vacancies_module/controller/vacancies_controller.dart';
import 'screens/applicant_screens/view_Applicant_profile/controller/applicant_profile_controller.dart';
import 'screens/auth_module/controller/auth_controller_applicant.dart';
import 'screens/auth_module/auth_screen_applicant.dart';
import 'screens/institute_screens/applicants/controller/applied_applicants_controller.dart';
import 'screens/institute_screens/applicants/controller/suitable_candidates_controller.dart';
import 'screens/institute_screens/employee/controller/employee_details_controller.dart';
import 'screens/institute_screens/vacancy/controllers/vacancy_controller.dart';
import 'services/rest.dart';
import 'utilities/constants.dart';

final logger = Logger(
    printer: PrettyPrinter(
  methodCount: 2,
  errorMethodCount: 5,
  printTime: true,
  printEmojis: true,
));
bool token = false;
String userType = 'applicant';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Box? box = await Hive.openBox('userBox');
  if (box.isNotEmpty) {
    token = box.get('token');
    userType = box.get('userType');
  }

  GetIt.I.registerSingleton<ApiBaseHelper>(ApiBaseHelper());

  GetIt.I.registerSingleton<AuthControllerApplicant>(AuthControllerApplicant());

  GetIt.I.registerSingleton<ApplicantPersonalDataController>(
      ApplicantPersonalDataController());

  GetIt.I.registerSingleton<AuthControllerInstitute>(AuthControllerInstitute());

  GetIt.I.registerSingleton<DashboardControllerInstitute>(
      DashboardControllerInstitute());

  GetIt.I.registerSingleton<DashboardControllerApplicant>(
      DashboardControllerApplicant());

  GetIt.I.registerSingleton<ApplicantProfileController>(
      ApplicantProfileController());

  GetIt.I.registerSingleton<VacanciesController>(VacanciesController());

  GetIt.I.registerSingleton<ApplicantHistoryController>(
      ApplicantHistoryController());

  GetIt.I.registerSingleton<AddDetailsControllerInstitute>(
      AddDetailsControllerInstitute());

  GetIt.I.registerSingleton<AddEmployeesController>(AddEmployeesController());

  GetIt.I.registerSingleton<AddEmployeeController>(AddEmployeeController());

  GetIt.I.registerSingleton<UserProfileController>(UserProfileController());

  GetIt.I.registerSingleton<EmployeeDetailsController>(
      EmployeeDetailsController());

  GetIt.I.registerSingleton<AddVacancyController>(AddVacancyController());

  GetIt.I.registerSingleton<SuitableCandidatesController>(
      SuitableCandidatesController());

  GetIt.I.registerSingleton<AppliedApplicantsController>(
      AppliedApplicantsController());
  GetIt.I
      .registerSingleton<VacancyDetailsController>(VacancyDetailsController());
  GetIt.I.registerSingleton<AddRecruitmentCommitteeController>(
      AddRecruitmentCommitteeController());
  GetIt.I.registerSingleton<ApproachCandidateController>(
      ApproachCandidateController());
  GetIt.I.registerSingleton<DashboardController>(DashboardController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: kPrimaryColorApplicant),
      debugShowCheckedModeBanner: false,
      title: 'Rapid Recruits',
      home: const SplashManager(),
    );
  }
}

class SplashManager extends StatelessWidget {
  const SplashManager({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
          [Future.delayed(const Duration(seconds: 1, milliseconds: 50))]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return (!snapshot.hasData)
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png',
                          width: 300, height: 300),
                    ],
                  ),
                ),
              )
            : token == false
                ? const AuthScreenApplicant()
                : userType == "applicant"
                    ? const DashBoardApplicant()
                    : const DashBoardInstitute();
      },
    );
  }
}
