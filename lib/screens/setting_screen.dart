import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:kerjain/bindings/user_binding.dart';
import 'package:kerjain/component/button_secondary.dart';
import 'package:kerjain/controllers/user_controller.dart';
import 'package:kerjain/screens/setting_account_screen.dart';
import 'package:kerjain/utils/colors.dart';
import 'package:kerjain/utils/text.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController uc = Get.find();

    return Scaffold(
        body: SafeArea(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom.heading2(
                  text: 'Pengaturan', color: ColorsCustom.textPrimary),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ButtonSecondary(
                      isStylish: true,
                      isborder: false,
                      child: TextCustom.paragraph2(
                        text: 'Pengaturan pengguna',
                        color: ColorsCustom.textSecondary,
                      ),
                      onPressed: () {
                        uc.setUserEditing();
                        Get.to(() => const SettingAccountScreen(),
                            binding: UserBinding());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
