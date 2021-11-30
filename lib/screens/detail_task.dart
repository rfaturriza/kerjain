import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerjain/component/button_primary.dart';
import 'package:kerjain/controllers/task_controller.dart';
import 'package:kerjain/screens/edit_task.dart';
import 'package:kerjain/utils/colors.dart';
import 'package:kerjain/utils/text.dart';
import 'package:kerjain/utils/theme.dart';

class DetailTask extends StatelessWidget {
  // final int index;
  const DetailTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    void selectedItem(BuildContext context, item) {
      switch (item) {
        case 0:
          taskController.setTaskEditing();
          Get.to(() => const EditaskScreen());
          break;
        case 1:
          taskController.deleteTask();
          break;
      }
    }

    return Scaffold(
        appBar: CustomTheme.appBar(actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onSelected: (item) => selectedItem(context, item),
            initialValue: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorsCustom.textDead, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.more_vert,
                    color: ColorsCustom.textPrimary,
                  ),
                ),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: TextCustom.paragraph2(
                  text: 'Ubah',
                  color: ColorsCustom.textPrimary,
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: TextCustom.paragraph2(
                  text: 'Hapus',
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ]),
        body: SafeArea(
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom.heading1(
                          text: taskController.task.value.title!,
                          color: ColorsCustom.textPrimary),
                      TextCustom.paragraph2(
                        text: taskController.task.value.description!,
                        color: ColorsCustom.textDead,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom.paragraph2(
                                text: 'Mulai     : ' +
                                    taskController.task.value.startDate!
                                        .toString()
                                        .split(':00.')[0],
                                color: ColorsCustom.textDead,
                              ),
                              TextCustom.paragraph2(
                                text: 'Selesai  : ' +
                                    taskController.task.value.endDate!
                                        .toString()
                                        .split(':00.')[0],
                                color: ColorsCustom.textDead,
                              ),
                            ],
                          )),
                      Expanded(child: Container()),
                      if (taskController.task.value.status! == 'kerjaan')
                        SizedBox(
                            width: double.infinity,
                            child: ButtonPrimary(
                                child: TextCustom.heading3(
                                  text: 'Tandai Selesai',
                                  color: ColorsCustom.textPrimary,
                                ),
                                onPressed: () {
                                  taskController.setTaskEditing();
                                  taskController.setTaskToCompleted();
                                }))
                      else
                        SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                                TextCustom.heading3(
                                  text: 'Selesai',
                                  color: ColorsCustom.textPrimary,
                                ),
                              ],
                            )),
                    ],
                  )),
            ),
          ),
        ));
  }
}
