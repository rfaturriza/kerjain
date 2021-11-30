// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tzi;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  var currentIncrement = 0.obs;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() async {
    getAutoIncrement();
    initialize();
    tzi.initializeTimeZones();
    super.onInit();
  }

  void getAutoIncrement() async {
    Box boxAutoIncrement;
    try {
      boxAutoIncrement = Hive.box('autoIncrement');
    } catch (error) {
      boxAutoIncrement = await Hive.openBox('autoIncrement');
    }

    if (boxAutoIncrement.isEmpty) {
      boxAutoIncrement.put('ai', currentIncrement.value);
    } else {
      currentIncrement.value = boxAutoIncrement.get('ai');
    }
  }

  //initilize
  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Instant Notifications
  Future instantNofitication() async {
    var android = AndroidNotificationDetails("id", "channel", "description");

    var ios = IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
        0, "Tes flutter local notification instant", "Hello everyone", platform,
        payload: "Welcome to demo app");
  }

  //Sheduled Notification
  Future sheduledNotification(
      int id, String title, String body, DateTime date) async {
    var android = AndroidNotificationDetails(
      "id",
      "channel",
      "description",
      enableLights: true,
      enableVibration: true,
    );

    var ios = IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: ios);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, tz.TZDateTime.from(date, tz.local), platform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  //Cancel notification

  Future cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future cancelNotificationAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
