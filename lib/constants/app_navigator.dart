import 'package:flutter/material.dart';
import 'package:get/get.dart';

gotoScreen({required String screenName, required Object arguments}) {
  // FocusScope.of(Get.context!).requestFocus(new FocusNode());
  FocusScope.of(Get.context!).unfocus();
  // Get.toNamed(screenName,arguments: arguments);
  //   Navigator.pushNamed(context, screenName, arguments: arguments);
  Get.toNamed(screenName, arguments: arguments);
}

gotoScreenpopAndPushNamed(
    {required String screenName, required Object arguments}) {
  // FocusScope.of(Get.context!).requestFocus(new FocusNode());
  FocusScope.of(Get.context!).unfocus();
  Get.offAndToNamed(screenName, arguments: arguments);
}

goBack() {
  FocusScope.of(Get.context!).requestFocus(FocusNode());
  FocusScope.of(Get.context!).unfocus();
  Get.back();
}

gotoWithRemoveRoute({required String screenName, required Object arguments}) {
  // FocusScope.of(context).requestFocus(new FocusNode());
  FocusScope.of(Get.context!).unfocus();
  Navigator.of(Get.context!)
      .pushNamedAndRemoveUntil(screenName, (Route<dynamic> route) => false);
  Navigator.pushNamed(Get.context!, screenName);
  // Get.ofa(screenName,arguments: arguments);
}

gotoIntro({required String screenName, required Object arguments}) {
  // FocusScope.of(context).requestFocus(new FocusNode());
  FocusScope.of(Get.context!).unfocus();
  // Navigator.of(Get.context!).pushNamedAndRemoveUntil(screenName, (Route<dynamic> route) => false);
  Get.offNamedUntil(screenName, (route) => false);
  // Navigator.pushNamed(Get.context!, screenName);
}
// temp(context, String screenName) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => LoginScreen(),
//     ),
//   );
//   Navigator.of(context).popUntil(ModalRoute.withName(screenName));
// }
