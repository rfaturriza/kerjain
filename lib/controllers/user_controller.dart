import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kerjain/models/user_model.dart';

class UserController extends GetxController {
  var firstName = 'Username'.obs;
  var lastName = ''.obs;
  var formKeyController = GlobalKey<FormState>().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;

  @override
  void onInit() async {
    Hive.registerAdapter(UserModelAdapter());
    getUser();
    super.onInit();
  }

  @override
  void onClose() {
    resetForm();
    super.onClose();
  }

  Future<Box<UserModel>> checkHiveBox() async {
    Box<UserModel> boxUser;
    try {
      boxUser = Hive.box('user');
      return boxUser;
    } catch (error) {
      boxUser = await Hive.openBox('user');
      return boxUser;
    }
  }

  void getUser() async {
    Box<UserModel> boxUser = await checkHiveBox();
    UserModel? userData = boxUser.get('account');
    if (userData != null) {
      firstName.value = userData.firstName;
      lastName.value = userData.lastName;
    }
  }

  void updateUser() async {
    Box<UserModel> boxUser = await checkHiveBox();
    boxUser
        .put(
            'account',
            UserModel(
                uid: '',
                firstName: firstNameController.value.text,
                lastName: lastNameController.value.text))
        .then((_) {
      Get.back();
      Get.snackbar('Pesan', 'Berhasil merubah akun',
          snackPosition: SnackPosition.BOTTOM);
      getUser();
    }).whenComplete(() => resetForm());
  }

  void setUserEditing() {
    firstNameController.value.text = firstName.value;
    lastNameController.value.text = lastName.value;
  }

  void resetForm() {
    formKeyController.value.currentState!.reset();
    firstNameController.value.text = '';
    lastNameController.value.text = '';
  }
}
