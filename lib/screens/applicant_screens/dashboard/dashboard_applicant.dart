import 'package:RapidRecruits/screens/applicant_screens/applicant_vacancy_history/applicant_history.dart';
import 'package:RapidRecruits/screens/applicant_screens/vacancies_module/applicant_vacancies_view.dart';
import 'package:RapidRecruits/screens/applicant_screens/view_Applicant_profile/view_applicant_profile.dart';
import 'package:RapidRecruits/utilities/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../vacancies_module/controller/vacancies_controller.dart';
import 'controller/dashboard_controller.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

class DashBoardApplicant extends StatefulWidget {
  const DashBoardApplicant({Key? key, this.page = 0}) : super(key: key);
  final int page;

  @override
  State<DashBoardApplicant> createState() => _DashBoardApplicantState();
}

class _DashBoardApplicantState extends State<DashBoardApplicant> {
  final controller = GetIt.I<DashboardControllerApplicant>();
  int _page = 0;
  final vacancyController = GetIt.I<VacanciesController>();
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  void initDynamicLinks() async {
    // this is called when app comes from background
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        vacancyController
            .getVacancyById(int.parse(deepLink.queryParameters['vacId']!));
      }
    }, onError: (OnLinkErrorException e) async {
      if (kDebugMode) {
        print('onLinkError');
        print(e.message);
      }
    });

    // this is called when app is not open in the background
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      vacancyController
          .getVacancyById(int.parse(deepLink.queryParameters['vacId']!));
    }
  }

  @override
  void initState() {
    initDynamicLinks();
    controller.checkDetails();
    _page = widget.page;
    super.initState();
  }

  List<Widget> screens = [
    const VacanciesView(),
    const ApplicationsHistoryScreen(),
    const ViewApplicantProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()))
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Icon(
                  //     Icons.person_add_alt,
                  //     size: 30,
                  //     color: _page == 2 ? Colors.white : Colors.black,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Icon(
                  //     Icons.post_add,
                  //     size: 30,
                  //     color: _page == 1 ? Colors.white : Colors.black,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person_outlined,
                      size: 30,
                      color: _page == 2 ? Colors.white : Colors.black,
                    ),
                  ),
                ],
                color: Colors.white,
                buttonBackgroundColor: kPrimaryColorApplicant,
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
