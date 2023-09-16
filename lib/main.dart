// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:albaydar/constants/app_screens.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'LocalizationService.dart';
import 'controllers/category_controller.dart';
import 'controllers/customer_controller.dart';
import 'controllers/lang_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/screens_controller.dart';

void main() async {
  runApp(const MyApp());
}

CustomerController customerController = Get.put(CustomerController());
ScreensController controller = Get.put(ScreensController());
ProductController productController = Get.put(ProductController());
CategoryController categoryController = Get.put(CategoryController());
LangController langController = Get.put(LangController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Exo'),
      home: SafeArea(
          child: AnimatedSplashScreen(
              duration: 3000,
              splash: Image(
                image: const AssetImage("assets/images/logo.png"),
                height: MediaQuery.of(context).size.width * 0.8,
              ),
              splashIconSize: MediaQuery.of(context).size.width * 0.8,
              nextScreen: AppScreens.homeScreen,
              splashTransition: SplashTransition.fadeTransition,
              //pageTransitionType: PageTransitionType.scale,
              backgroundColor: Colors.white)),
    );
  }
}
