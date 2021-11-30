import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kerjain/controllers/notification_controller.dart';
import 'package:kerjain/models/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskController extends GetxController {
  final NotificationController nC = Get.find();
  var isProcessing = false.obs;
  var categoryList = ['Rapat', 'Sekolah', 'Tugas', 'Lainnya'].obs;

  var formKeyController = GlobalKey<FormState>().obs;
  var titleController = TextEditingController().obs;
  var descController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;
  var categoryController = TextEditingController().obs;
  var notificationController = true.obs;
  var pickerColorController = const Color(0xff443a49).obs;

  var keyTask = ''.obs;
  var allTasks = <TaskModel>[].obs;
  var task = TaskModel().obs;

  @override
  void onInit() async {
    Hive.registerAdapter(TaskModelAdapter());
    getAllTasks();
    super.onInit();
  }

  void getAllTasks() async {
    allTasks.value = [];
    Box<TaskModel> boxTask;
    try {
      boxTask = Hive.box('task');
    } catch (error) {
      boxTask = await Hive.openBox('task');
    }
    List<TaskModel> listTaskData = boxTask.listenable().value.values.toList();
    listTaskData.sort((a, b) => a.startDate!.compareTo(b.startDate!));
    if (listTaskData.isNotEmpty) allTasks.value = listTaskData;
  }

  void getTask() async {
    task.value = TaskModel();
    Box<TaskModel> boxTask;
    try {
      boxTask = Hive.box('task');
    } catch (error) {
      boxTask = await Hive.openBox('task');
    }
    TaskModel? taskData = boxTask.get(keyTask.value);
    if (taskData != null) task.value = taskData;
  }

  void deleteTask() async {
    Box<TaskModel> boxTask;
    try {
      boxTask = Hive.box('task');
    } catch (error) {
      boxTask = await Hive.openBox('task');
    }
    await boxTask.delete(keyTask.value).then((_) {
      Get.back();
      Get.snackbar(
        'Pesan',
        'Berhasil menghapus',
        snackPosition: SnackPosition.BOTTOM,
      );
    }).whenComplete(() => getAllTasks());
  }

  void setTaskToCompleted() async {
    Box<TaskModel> boxTask;
    try {
      boxTask = Hive.box('task');
    } catch (error) {
      boxTask = await Hive.openBox('task');
    }
    setTaskEditing();
    isProcessing.value = true;
    boxTask
        .put(
            keyTask.value,
            TaskModel(
                uid: keyTask.value,
                startDate: DateTime.parse(startDateController.value.text),
                endDate: DateTime.parse(endDateController.value.text),
                title: titleController.value.text,
                description: descController.value.text,
                category: categoryController.value.text,
                status: 'selesai',
                color: pickerColorController.value.value,
                enableNotification: notificationController.value))
        .then((_) {
      notificationController.value &&
              DateTime.parse(startDateController.value.text)
                  .isAfter(DateTime.now())
          ? nC.sheduledNotification(
              nC.currentIncrement.value,
              titleController.value.text,
              descController.value.text,
              DateTime.parse(startDateController.value.text))
          : nC.cancelNotification(nC.currentIncrement.value);
      Get.back();
      Get.snackbar('Pesan', 'Berhasil merubah kerjaan',
          snackPosition: SnackPosition.BOTTOM);
      getTask();
      getAllTasks();
    }).whenComplete(() {
      isProcessing.value = false;
      resetForm();
    });
  }

  void updateData({String status = 'kerjaan'}) async {
    if (formKeyController.value.currentState!.validate()) {
      Box<TaskModel> boxTask;
      try {
        boxTask = Hive.box('task');
      } catch (error) {
        boxTask = await Hive.openBox('task');
      }
      isProcessing.value = true;
      await boxTask
          .put(
              keyTask.value,
              TaskModel(
                  uid: keyTask.value,
                  startDate: DateTime.parse(startDateController.value.text),
                  endDate: DateTime.parse(endDateController.value.text),
                  title: titleController.value.text,
                  description: descController.value.text,
                  category: categoryController.value.text,
                  status: status,
                  color: pickerColorController.value.value,
                  enableNotification: notificationController.value))
          .then((_) {
        notificationController.value &&
                DateTime.parse(startDateController.value.text)
                    .isAfter(DateTime.now())
            ? nC.sheduledNotification(
                nC.currentIncrement.value,
                titleController.value.text,
                descController.value.text,
                DateTime.parse(startDateController.value.text))
            : nC.cancelNotification(nC.currentIncrement.value);
        Get.back();
        Get.snackbar('Pesan', 'Berhasil merubah kerjaan',
            snackPosition: SnackPosition.BOTTOM);
        getTask();
        getAllTasks();
      }).catchError((onError) {
        Get.snackbar('Pesan (Error)', onError.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }).whenComplete(() {
        isProcessing.value = false;
        resetForm();
      });
    }
  }

  void setTaskEditing() async {
    Box<TaskModel> boxTask;
    try {
      boxTask = Hive.box('task');
    } catch (error) {
      boxTask = await Hive.openBox('task');
    }
    var data = boxTask.get(keyTask.value);
    startDateController.value.text = data!.startDate.toString();
    endDateController.value.text = data.endDate.toString();
    titleController.value.text = data.title.toString();
    descController.value.text = data.description.toString();
    categoryController.value.text = data.category.toString();
    DateTime.parse(startDateController.value.text).isAfter(DateTime.now())
        ? notificationController.value = data.enableNotification!
        : notificationController.value = false;
    pickerColorController.value = Color(data.color!);
  }

  void save() async {
    if (formKeyController.value.currentState!.validate()) {
      Box<TaskModel> boxTask;
      try {
        boxTask = Hive.box('task');
      } catch (error) {
        boxTask = await Hive.openBox('task');
      }
      isProcessing.value = true;
      var uuid = const Uuid().v1();
      boxTask
          .put(
              uuid,
              TaskModel(
                  uid: uuid,
                  startDate: DateTime.parse(startDateController.value.text),
                  endDate: DateTime.parse(endDateController.value.text),
                  title: titleController.value.text,
                  description: descController.value.text,
                  category: categoryController.value.text,
                  status: 'kerjaan',
                  color: pickerColorController.value.value,
                  enableNotification: notificationController.value))
          .then((value) {
        notificationController.value &&
                DateTime.parse(startDateController.value.text)
                    .isAfter(DateTime.now())
            ? nC.sheduledNotification(
                nC.currentIncrement.value,
                titleController.value.text,
                descController.value.text,
                DateTime.parse(startDateController.value.text))
            : null;
        Get.back();
        Get.snackbar('Pesan', 'Berhasil menambahkan kerjaan',
            snackPosition: SnackPosition.BOTTOM);
      }).catchError((onError) {
        Get.snackbar('Pesan', onError.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }).whenComplete(() {
        isProcessing.value = false;
        resetForm();
        getAllTasks();
      });
    }
  }

  void changeColor(Color color) {
    pickerColorController.value = color;
  }

  void setCategory(val) => categoryController.value.text = val;
  void setNotification(val) => notificationController.value = val;

  void resetForm() {
    formKeyController.value.currentState!.reset();
    titleController.value.text = '';
    descController.value.text = '';
    startDateController.value.text = '';
    endDateController.value.text = '';
    categoryController.value.text = '';
    notificationController.value = true;
    pickerColorController.value = const Color(0xff443a49);
  }

  void selectedTask(i) {
    keyTask.value = i;
    getTask();
  }
}
