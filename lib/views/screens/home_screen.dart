// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:albaydar/controllers/functions.dart';
import 'package:albaydar/models/Customer.dart';
import 'package:albaydar/views/screens/Login/signIn_screen.dart';
import 'package:albaydar/views/screens/favorits.dart';
import 'package:albaydar/views/screens/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../AppWords.dart';
import '../../LocalizationService.dart';
import '../../constants/app_screens.dart';
import '../../constants/navigation.dart';
import '../../main.dart';
import 'feddback_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int navIndex = 1;
  AppScreens app = AppScreens();

  @override
  void initState() {
    getUSerPrefsData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: langController.langCode.toString() == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: AdvancedDrawer(
        backdrop: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            alignment: Alignment.centerLeft,
            width: langController.langCode.toString() == 'ar'
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * 0.7,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal,
              gradient: LinearGradient(
                begin: langController.langCode.toString() == 'ar'
                    ? Alignment.topRight
                    : Alignment.topLeft,
                end: langController.langCode.toString() == 'ar'
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                colors: [Colors.teal, Colors.teal.withOpacity(0.2)],
              ),
            ),
          ),
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 34.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    color: Colors.white,
                  ),
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                customerController.customerInfo.CustomerId == null
                    ? Container()
                    : Text(
                        '${customerController.customerInfo.CustomerFirstName}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  onTap: () {
                    controller.changeScreen(
                        AppScreens.categoryScreen, AppWords.Categories.tr);
                    _advancedDrawerController.hideDrawer();
                    setState(() {});
                  },
                  leading: const Icon(Icons.home),
                  title: Text(AppWords.home.tr),
                ),
                customerController.customerInfo.CustomerId == null
                    ? Container()
                    : ListTile(
                        onTap: () {
                          controller.changeScreen(
                              const Orders(), AppWords.myOrders.tr);
                          _advancedDrawerController.hideDrawer();
                          setState(() {});
                        },
                        leading: const Icon(Icons.category_sharp),
                        title: Text(AppWords.myOrders.tr),
                      ),
                ListTile(
                  onTap: () {
                    controller.changeScreen(
                        const FavoritsScreen(), AppWords.Favourites.tr);
                    _advancedDrawerController.hideDrawer();
                    setState(() {});
                  },
                  leading: const Icon(Icons.favorite),
                  title: Text(AppWords.Favourites.tr),
                ),
                ListTile(
                  onTap: () {
                    controller.changeScreen(
                        AppScreens.cartScreen, AppWords.Cart.tr);
                    _advancedDrawerController.hideDrawer();
                    setState(() {});
                  },
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(AppWords.Cart.tr),
                ),
                ListTile(
                  onTap: () {
                    controller.changeScreen(
                        AppScreens.contactUsScreen, AppWords.ContactUs);
                    _advancedDrawerController.hideDrawer();
                    setState(() {});
                  },
                  leading: const Icon(Icons.contact_emergency),
                  title: Text(AppWords.ContactUs.tr),
                ),
                ListTile(
                  onTap: () {
                    controller.changeScreen(
                        const FeedBack(), AppWords.FeedBack.tr);
                    _advancedDrawerController.hideDrawer();
                    setState(() {});
                  },
                  leading: const Icon(Icons.question_mark_sharp),
                  title: Text(AppWords.FeedBack.tr),
                ),
                ListTile(
                  onTap: () {
                    LocalizationService().changeLocale();
                    setState(() {});
                  },
                  leading: const Icon(Icons.language),
                  title: Text(AppWords.ChangeLanguage.tr),
                ),
                customerController.customerInfo.CustomerId == null
                    ? ListTile(
                        onTap: () {
                          navigateTo(context, const SignInScreen());
                        },
                        leading: const Icon(Icons.login),
                        title: Text(AppWords.Login.tr),
                      )
                    : ListTile(
                        onTap: () async {
                          customerController.customerInfo = Customer();
                          // customerController.customerInfo.CustomerId = 0;
                          // customerController.customerInfo.CustomerFirstName =
                          //     '';
                          // customerController.customerInfo.CustomerMiddleName =
                          //     '';
                          // customerController.customerInfo.CustomerLastName = '';
                          // customerController.customerInfo.CustomerNumber = '';
                          // customerController.customerInfo.CustomerEmail = '';
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.clear();
                          setState(() {});
                          Get.reloadAll();
                          navigateToAndRemoveUntil(context, const HomeScreen());

                          //setUSerPrefsData();
                        },
                        leading: const Icon(Icons.logout),
                        title: Text(AppWords.Loguot.tr),
                      ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text(
                      'Copyright © 2023. All rights reserved. Designed by Azmi Assi Team',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              centerTitle: true,
              title: Text(controller.screenTitle),
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ),
            body: controller.screen),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
