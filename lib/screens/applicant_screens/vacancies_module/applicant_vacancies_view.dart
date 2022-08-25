import 'package:RapidRecruits/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'controller/vacancies_controller.dart';
import 'widgets/vacancies_view_widget.dart';

class VacanciesView extends StatefulWidget {
  const VacanciesView({Key? key}) : super(key: key);

  @override
  State<VacanciesView> createState() => _VacanciesViewState();
}

class _VacanciesViewState extends State<VacanciesView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(text: 'All Vacancies'),
    Tab(text: 'Suitable for me'),
  ];

  static const List<Widget> _views = [
    AllVacancies(showCustomizedVacancies: false),
    AllVacancies(showCustomizedVacancies: true),
  ];

  @override
  void initState() {
    controller.getVacancies();
    controller.getCustomizedVacancies();

    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(2);
    super.initState();
  }

  final controller = GetIt.I<VacanciesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Vacancies View'),
        backgroundColor: kPrimaryColorApplicant,
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
          overlayColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue;
            }
            if (states.contains(MaterialState.focused)) {
              return Colors.orange;
            } else if (states.contains(MaterialState.hovered)) {
              return Colors.pinkAccent;
            }

            return Colors.transparent;
          }),
          indicatorWeight: 10,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.all(5),
          indicator: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
            color: Colors.pinkAccent,
          ),
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
          onTap: (int index) {},
          enableFeedback: true,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        children: _views,
      ),
    );
  }
}
