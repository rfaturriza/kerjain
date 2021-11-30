import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:kerjain/component/button_primary.dart';
import 'package:kerjain/component/text_form_field.dart';
import 'package:kerjain/controllers/user_controller.dart';
import 'package:kerjain/utils/colors.dart';
import 'package:kerjain/utils/text.dart';
import 'package:kerjain/utils/theme.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SettingAccountScreen extends StatelessWidget {
  const SettingAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController uc = Get.find();
    return KeyboardDismisser(
      child: Scaffold(
          appBar: CustomTheme.appBar(
            title: TextCustom.heading2(
                text: 'Pengaturan akun', color: ColorsCustom.textPrimary),
          ),
          body: SafeArea(
              child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Form(
                  key: uc.formKeyController.value,
                  child: ListView(
                    children: [
                      TextFormCustom(
                          label: 'Nama depan',
                          controller: uc.firstNameController.value,
                          validator: FormBuilderValidators.required(context)),
                      TextFormCustom(
                          label: 'Nama belakang',
                          controller: uc.lastNameController.value,
                          validator: FormBuilderValidators.required(context)),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ButtonPrimary(
                            child: TextCustom.heading3(
                              text: 'Simpan',
                              color: ColorsCustom.textPrimary,
                            ),
                            onPressed: () => uc.updateUser(),
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
