import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kerjain/bindings/home_binding.dart';
import 'package:kerjain/screens/bottom_nav.dart';
import 'package:hive/hive.dart';
import 'package:kerjain/utils/theme.dart';

void main() async {
  await Hive.initFlutter();
  HomeBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const BottomNavBar(),
      theme: CustomTheme.lightTheme,
    );
  }
}
