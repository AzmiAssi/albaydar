// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names, file_names

import 'package:albaydar/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lang/ar.dart';
import 'lang/en.dart';

class LocalizationService extends Translations {
  static Locale? locale = const Locale('en', '');
  static Locale? fallbackLocale = const Locale('en', 'US');
  // static Locale locale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get Keys => {
        'en': en, // lang/en_us.dart
        'ar': ar, // lang/tr_tr.dart
        // lang/ja_jp.dart
      };

  static Future<void> getlocal() async {
    LocalizationService().updateLocale();
  }

  static final langs = ['English', 'Arabic'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', ''),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file

  // Gets locale from language, and updates the locale
  void changeLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (Get.locale!.languageCode == 'en') {
      langController.setLnagCode('ar');
      langController.changeIsArabic(true);
      prefs.setString("LangKey", 'ar');
      Get.updateLocale(const Locale('ar', ''));
    } else {
      langController.setLnagCode('en');
      langController.changeIsArabic(false);
      prefs.setString("LangKey", 'en');
      Get.updateLocale(const Locale('en', 'US'));
    }
    // Get.offNamedUntil(SplashScreen.RoutName, (route) => false);
    // await Get.context!.read<HomeCubit>().getAds();

    // await  Get.context!.read<GeneralCubit>().getSetting();
  }

  static Future<void> englishLocale() async {
    var prefs = await SharedPreferences.getInstance();

    langController.setLnagCode('en');
    langController.changeIsArabic(false);
    prefs.setString("LangKey", 'en');
    Get.updateLocale(const Locale('en', 'US'));
  }

  static Future<void> arabicLocale() async {
    var prefs = await SharedPreferences.getInstance();

    langController.setLnagCode('ar');
    langController.changeIsArabic(true);
    prefs.setString("LangKey", 'ar');
    Get.updateLocale(const Locale('ar', ''));
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  Future<void> updateLocale() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? lang = preferences.getString("LangKey");

    if (lang!.isEmpty) {
      langController.setLnagCode('en');
      langController.changeIsArabic(false);
      preferences.setString("LangKey", 'en');
      Get.updateLocale(const Locale('en', 'US'));
    } else if (lang == 'ar') {
      langController.setLnagCode('ar');
      langController.changeIsArabic(true);
      preferences.setString("LangKey", 'ar');
      Get.updateLocale(const Locale('ar', ''));
    } else {
      langController.setLnagCode('en');
      langController.changeIsArabic(false);
      preferences.setString("LangKey", 'en');
      Get.updateLocale(const Locale('en', 'US'));
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en, // lang/en_us.dart
        'ar': ar, // lang/tr_tr.dart
        // lang/ja_jp.dart
      };

  // @override
  // Map<String, Map<String, String>> get keys => throw UnimplementedError();
}



// LocalizationService().changeLocale();