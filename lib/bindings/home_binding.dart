import 'package:get/get.dart';
import 'package:kerjain/controllers/home_controller.dart';
import 'package:kerjain/controllers/notification_controller.dart';
import 'package:kerjain/controllers/task_controller.dart';
import 'package:kerjain/controllers/user_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
