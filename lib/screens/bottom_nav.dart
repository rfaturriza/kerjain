import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerjain/controllers/buttom_nav_controller.dart';
import 'package:kerjain/screens/add_task.dart';
import 'package:kerjain/screens/calendar_screen.dart';
import 'package:kerjain/screens/home_screen.dart';
import 'package:kerjain/screens/tasks_screen.dart';
import 'package:kerjain/screens/setting_screen.dart';
import 'package:kerjain/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const CalendarScreen(),
    const AddTaskScreen(),
    const ListTaskScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    final BottomNavController bNController = Get.put(BottomNavController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      body: Obx(() => _widgetOptions[bNController.selectedIndex.value]),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Visibility(
            visible: !keyboardIsOpen,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {
                Get.to(() => const AddTaskScreen());
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [ColorsCustom.primary2, ColorsCustom.primary1]),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsCustom.primary2.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.add),
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                // ignore: deprecated_member_use
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                // ignore: deprecated_member_use
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.amber,
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.transparent,
                ),
                // ignore: deprecated_member_use
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.line_weight_sharp),
                // ignore: deprecated_member_use
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                // ignore: deprecated_member_use
                label: 'Setting',
              ),
            ],
            enableFeedback: false,
            currentIndex: bNController.selectedIndex.value,
            backgroundColor: ColorsCustom.textSecondary,
            selectedItemColor: ColorsCustom.textPrimary,
            unselectedItemColor: ColorsCustom.textDead,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: bNController.onItemTapped,
          )),
    );
  }
}
