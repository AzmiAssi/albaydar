import 'package:albaydar/constants/app_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreensController extends GetxController {
  Widget screen = AppScreens.categoryScreen;
  String screenTitle = 'Home Page';

  void changeScreen(Widget screenChange, String title) {
    screen = screenChange;
    screenTitle = title;
    update();
  }
}
