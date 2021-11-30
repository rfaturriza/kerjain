import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerjain/component/search_bar.dart';
import 'package:kerjain/component/secondary_card.dart';
import 'package:kerjain/controllers/search_controller.dart';
import 'package:kerjain/controllers/task_controller.dart';
import 'package:kerjain/models/task_model.dart';
import 'package:kerjain/screens/detail_task.dart';
import 'package:kerjain/utils/colors.dart';
import 'package:kerjain/utils/text.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ListTaskScreen extends StatelessWidget {
  const ListTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    final SearchController searchController = Get.put(SearchController());
    return KeyboardDismisser(
      child: Scaffold(
          body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom.heading2(
                    text: 'Semua Kerjaan', color: ColorsCustom.textPrimary),
                SearchBar(
                  initialValue: searchController.query.value,
                  onChanged: searchController.updateQuery,
                ),
                Obx(() {
                  List<TaskModel> allTasks = taskController.allTasks;
                  List<TaskModel> allTasksQuery = searchController.resultQuery;
                  if (searchController.query.value.isEmpty) {
                    if (allTasks.isEmpty) {
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
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: allTasks.length,
                            itemBuilder: (BuildContext context, index) {
                              return CardSecondary(
                                color: Color(allTasks[index].color!)
                                    .withOpacity(0.2),
                                onPressed: () {
                                  Get.to(() => const DetailTask());
                                  taskController
                                      .selectedTask(allTasks[index].uid);
                                },
                                child: ListTile(
                                    trailing:
                                        allTasks[index].status == 'selesai'
                                            ? const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              )
                                            : const SizedBox(),
                                    title: TextCustom.heading3(
                                      text: allTasks[index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorsCustom.textPrimary,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom.paragraph2(
                                            text: allTasks[index].description!,
                                            color: ColorsCustom.textDead,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        if (allTasks[index].startDate!.isBefore(
                                            DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day)))
                                          TextCustom.paragraph2(
                                              text: 'Mulai: ' +
                                                  allTasks[index]
                                                      .startDate
                                                      .toString()
                                                      .split(':00.')[0] +
                                                  ' (Kadaluarsa)',
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorsCustom.textPrimary)
                                        else
                                          TextCustom.paragraph2(
                                            text: 'Mulai: ' +
                                                allTasks[index]
                                                    .startDate
                                                    .toString()
                                                    .split(':00.')[0],
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorsCustom.textPrimary,
                                          )
                                      ],
                                    )),
                              );
                            }),
                      );
                    }
                  } else {
                    if (allTasksQuery.isEmpty) {
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
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: allTasksQuery.length,
                            itemBuilder: (BuildContext context, index) {
                              return CardSecondary(
                                color: Color(allTasksQuery[index].color!)
                                    .withOpacity(0.2),
                                onPressed: () {
                                  Get.to(() => const DetailTask());
                                  taskController
                                      .selectedTask(allTasksQuery[index].uid);
                                },
                                child: ListTile(
                                    trailing:
                                        allTasksQuery[index].status == 'selesai'
                                            ? const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              )
                                            : const SizedBox(),
                                    title: TextCustom.heading3(
                                      text: allTasksQuery[index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorsCustom.textPrimary,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom.paragraph2(
                                            text: allTasksQuery[index]
                                                .description!,
                                            color: ColorsCustom.textDead,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        if (allTasksQuery[index]
                                            .startDate!
                                            .isBefore(DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day)))
                                          TextCustom.paragraph2(
                                            text: 'Mulai: ' +
                                                allTasksQuery[index]
                                                    .startDate
                                                    .toString()
                                                    .split(':00.')[0] +
                                                ' (Kadaluarsa)',
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorsCustom.textDead,
                                          )
                                        else
                                          TextCustom.paragraph2(
                                            text: 'Mulai: ' +
                                                allTasksQuery[index]
                                                    .startDate
                                                    .toString()
                                                    .split(':00.')[0],
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorsCustom.textDead,
                                          )
                                      ],
                                    )),
                              );
                            }),
                      );
                    }
                  }
                })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
