import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kerjain/component/button_primary.dart';
import 'package:kerjain/component/text_form_field.dart';
import 'package:kerjain/controllers/task_controller.dart';
import 'package:kerjain/utils/colors.dart';
import 'package:kerjain/utils/text.dart';
import 'package:kerjain/utils/theme.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return KeyboardDismisser(
      child: Scaffold(
          appBar: CustomTheme.appBar(
            title: TextCustom.heading2(
                text: 'Tambah Kerjaan', color: ColorsCustom.textPrimary),
          ),
          body: SafeArea(
              child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Form(
                  key: taskController.formKeyController.value,
                  child: ListView(
                    children: [
                      TextFormCustom(
                          label: 'Judul',
                          controller: taskController.titleController.value,
                          validator: FormBuilderValidators.required(context)),
                      TextFormCustom(
                          label: 'Deskripsi',
                          controller: taskController.descController.value,
                          maxLines: 4,
                          validator: FormBuilderValidators.required(context)),
                      Row(
                        children: [
                          Expanded(
                              child: DateTimePicker(
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required(context)]),
                            type: DateTimePickerType.dateTime,
                            initialDate: DateTime.now(),
                            controller:
                                taskController.startDateController.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Mulai',
                          )),
                          const Divider(
                            indent: 5,
                          ),
                          Expanded(
                              child: DateTimePicker(
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              (val) {
                                if (DateTime.parse(val!).isBefore(
                                    DateTime.parse(taskController
                                        .startDateController.value.text))) {
                                  return 'Waktu selesai harus diatas waktu mulai';
                                }
                              }
                            ]),
                            type: DateTimePickerType.dateTime,
                            controller: taskController.endDateController.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Selesai',
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Kategori',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FormBuilderDropdown(
                        onChanged: taskController.setCategory,
                        name: 'category',
                        decoration: const InputDecoration(
                          fillColor: Color(0xfff3f3f4),
                          border: InputBorder.none,
                          filled: true,
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        items: taskController.categoryList
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text(val),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(() => FormBuilderSwitch(
                          initialValue:
                              taskController.notificationController.value,
                          name: 'Notifikasi',
                          title: const Text('Aktifkan notifikasi?'),
                          onChanged: taskController.setNotification)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Warna kartu',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlockPicker(
                        layoutBuilder: (BuildContext context,
                            List<Color> colors, PickerItem child) {
                          Orientation orientation =
                              MediaQuery.of(context).orientation;

                          return SizedBox(
                            width: orientation == Orientation.portrait
                                ? 100.0
                                : 300.0,
                            height: orientation == Orientation.portrait
                                ? 100.0
                                : 200.0,
                            child: GridView.count(
                              scrollDirection: Axis.horizontal,
                              crossAxisCount:
                                  orientation == Orientation.portrait ? 2 : 6,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              children: colors
                                  .map((Color color) => child(color))
                                  .toList(),
                            ),
                          );
                        },
                        pickerColor: taskController.pickerColorController.value,
                        onColorChanged: taskController.changeColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ButtonPrimary(
                            child: taskController.isProcessing.value
                                ? const CircularProgressIndicator()
                                : TextCustom.heading3(
                                    text: 'Simpan',
                                    color: ColorsCustom.textPrimary,
                                  ),
                            onPressed: taskController.save,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ))),
    );
  }
}
