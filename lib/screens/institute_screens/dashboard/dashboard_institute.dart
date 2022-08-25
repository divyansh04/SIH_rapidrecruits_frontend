import 'package:RapidRecruits/screens/institute_screens/dashboard/controller/dasboard_controller.dart';
import 'package:RapidRecruits/screens/institute_screens/employee/add_employees_screen.dart';
import 'package:RapidRecruits/screens/institute_screens/home_screen/home_screen.dart';
import 'package:RapidRecruits/screens/institute_screens/user_profile/user_profile_screen.dart';
import 'package:RapidRecruits/screens/institute_screens/vacancy/vacancies_screen.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../employee/employees_list_screen.dart';

class DashBoardInstitute extends StatefulWidget {
  const DashBoardInstitute({Key? key}) : super(key: key);

  @override
  State<DashBoardInstitute> createState() => _DashBoardInstituteState();
}

class _DashBoardInstituteState extends State<DashBoardInstitute> {
  final controller = GetIt.I<DashboardControllerInstitute>();
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    controller.checkDetails();
    super.initState();
  }

  List<Widget> screens = [
    const HomeScreen(),
    const EmployeesScreen(),
    const AddEmployeesScreen(),
    const VacanciesScreen(),
    const UserProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: CircularProgressIndicator(
                color: kPrimaryColorInstitute,
              )))
          : Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: CurvedNavigationBar(
                key: bottomNavigationKey,
                index: 0,
                height: 60.0,
                items: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: _page == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.people_outlined,
                        size: 30,
                        color: _page == 1 ? Colors.white : Colors.black,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person_add_alt,
                      size: 30,
                      color: _page == 2 ? Colors.white : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.post_add,
                      size: 30,
                      color: _page == 3 ? Colors.white : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person_outlined,
                      size: 30,
                      color: _page == 4 ? Colors.white : Colors.black,
                    ),
                  ),
                ],
                color: Colors.white,
                buttonBackgroundColor: kPrimaryColorInstitute,
                backgroundColor: Colors.transparent,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 600),
                onTap: (index) {
                  setState(() {
                    _page = index;
                  });
                },
                letIndexChange: (index) => true,
              ),
              body: screens[_page],
            ),
    );
  }
}
