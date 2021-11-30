import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

enum SelectedKerjaanButton { kerjaan, selesai }

class HomeController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  List<String> listStatusKerjaan = [];
  List listTask = [].obs;
  var buttonKerjaanku = SelectedKerjaanButton.kerjaan.index.obs;

  void onPressButtonKerjaan(int index) =>
      buttonKerjaanku.value = SelectedKerjaanButton.values[index].index;

  get kerjaanButton => SelectedKerjaanButton.values;

  List<String> get statusKerjaan {
    listStatusKerjaan.add('Kerjaan');
    listStatusKerjaan.add('Selesai');
    return listStatusKerjaan;
  }
}
