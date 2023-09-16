import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LangController extends GetxController {
  RxString langCode = RxString("en");
  RxBool isArabic = RxBool(false);

  void setLnagCode(String code) {
    langCode.value = code;
    update();
  }

  void changeIsArabic(bool arabic) {
    isArabic.value = arabic;
    update();
  }
}
