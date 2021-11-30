// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerjain/component/button_secondary.dart';
import 'package:kerjain/component/primay_card.dart';
import 'package:kerjain/component/secondary_card.dart';
import 'package:kerjain/controllers/home_controller.dart';
import 'package:kerjain/controllers/task_controller.dart';
import 'package:kerjain/controllers/user_controller.dart';
import 'package:kerjain/models/task_model.dart';
import 'package:kerjain/screens/detail_task.dart';
import 'package:kerjain/utils/colors.dart';
import 'package:kerjain/utils/text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final TaskController taskController = Get.find();
    final UserController userController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => TextCustom.heading1(
                    text: 'Hi ${userController.firstName.value} !',
                    color: ColorsCustom.textPrimary,
                    overflow: TextOverflow.ellipsis)),
                TextCustom.heading3(
                    text: 'Selamat datang di-KERJAIN.',
                    color: ColorsCustom.textDead),
                Obx(() {
                  int allTasksToday = taskController.allTasks
                      .where((e) => (e.startDate!.year == DateTime.now().year &&
                          e.startDate!.month == DateTime.now().month &&
                          e.startDate!.day == DateTime.now().day))
                      .toList()
                      .length;
                  int complatedTaskstoday = taskController.allTasks
                      .where((e) =>
                          (e.status == 'selesai') &&
                          (e.startDate!.year == DateTime.now().year &&
                              e.startDate!.month == DateTime.now().month &&
                              e.startDate!.day == DateTime.now().day))
                      .toList()
                      .length;
                  double persentToday() {
                    if ((complatedTaskstoday / allTasksToday).isNaN ||
                        (complatedTaskstoday / allTasksToday).isInfinite) {
                      return 0;
                    } else {
                      return complatedTaskstoday / allTasksToday;
                    }
                  }

                  return CardPrimary(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom.heading2(
                                text: 'Proses kerjaan hari ini !',
                                color: ColorsCustom.textSecondary,
                                overflow: TextOverflow.clip,
                              ),
                              if (allTasksToday != 0)
                                TextCustom.paragraph2(
                                    text: complatedTaskstoday.toString() +
                                        ' dari ' +
                                        allTasksToday.toString() +
                                        ' sudah selesai.',
                                    color: ColorsCustom.textDead2)
                              else
                                TextCustom.paragraph2(
                                    text: 'Tidak ada kerjaan',
                                    color: ColorsCustom.textDead2)
                            ],
                          ),
                        ),
                        Flexible(
                          child: CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 10.0,
                              percent: persentToday(),
                              backgroundColor:
                                  ColorsCustom.secondary2.withOpacity(0.2),
                              animation: true,
                              circularStrokeCap: CircularStrokeCap.round,
                              linearGradient: LinearGradient(colors: [
                                ColorsCustom.secondary2
                                    .withOpacity(persentToday()),
                                ColorsCustom.secondary1
                              ]),
                              center: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCustom.paragraph1(
                                      text: (persentToday() * 100)
                                          .toInt()
                                          .toString(),
                                      color: ColorsCustom.textSecondary),
                                  TextCustom.paragraph2(
                                      text: '%',
                                      color: ColorsCustom.textSecondary)
                                ],
                              )),
                        )
                      ],
                    ),
                  ));
                }),
                TextCustom.heading2(
                    text: 'Kerjaanku', color: ColorsCustom.textPrimary),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: homeController.kerjaanButton.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return Obx(() => ButtonSecondary(
                            isStylish:
                                homeController.buttonKerjaanku.value == index
                                    ? true
                                    : false,
                            isborder:
                                homeController.buttonKerjaanku.value == index
                                    ? false
                                    : true,
                            child: TextCustom.paragraph2(
                              text: homeController.statusKerjaan[index],
                              color:
                                  homeController.buttonKerjaanku.value == index
                                      ? ColorsCustom.textSecondary
                                      : ColorsCustom.textDead,
                            ),
                            onPressed: () {
                              homeController.onPressButtonKerjaan(index);
                            },
                          ));
                    },
                  ),
                ),
                Expanded(
                    // height: 200,
                    child: Obx(() {
                  List<TaskModel> box = taskController.allTasks
                      .where((e) =>
                          e.status ==
                          homeController.statusKerjaan[
                                  homeController.buttonKerjaanku.value]
                              .toLowerCase())
                      .toList();
                  if (box.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/illustrations/empty_data.svg',
                              width: 120,
                            ),
                            TextCustom.paragraph2(
                                text: 'Waduhh, tidak ada data',
                                color: ColorsCustom.textDead),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: box.length,
                      itemBuilder: (BuildContext context, index) {
                        TaskModel? currentTask = box[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: CardSecondary(
                              color: Color(currentTask.color!).withOpacity(0.2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom.heading3(
                                      text: currentTask.title!,
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorsCustom.textPrimary),
                                  TextCustom.paragraph2(
                                      text: currentTask.description!,
                                      color: ColorsCustom.textDead,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Expanded(child: Container()),
                                  if (currentTask.startDate!.isBefore(DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day)))
                                    TextCustom.paragraph2(
                                      text: 'Mulai: ' +
                                          currentTask.startDate
                                              .toString()
                                              .split(':00.')[0] +
                                          ' (Kadaluarsa)',
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorsCustom.textPrimary,
                                    )
                                  else
                                    TextCustom.paragraph2(
                                      text: 'Mulai: ' +
                                          currentTask.startDate
                                              .toString()
                                              .split(':00.')[0],
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorsCustom.textPrimary,
                                    )
                                ],
                              ),
                              onPressed: () {
                                Get.to(() => DetailTask());
                                taskController.selectedTask(currentTask.uid);
                              }),
                        );
                      });
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
