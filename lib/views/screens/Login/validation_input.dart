// ignore_for_file: unused_local_variable, unrelated_type_equality_checks

import 'package:albaydar/main.dart';

class ValidationInput {
  static String? usernameValidator({required dynamic value}) {
    final RegExp nameRegExp = RegExp(r'\d');
    if (value.isEmpty) {
      if (langController.langCode == 'ar') {
        return 'الرجاء ادخال الاسم';
      } else {
        return 'Name Reqiured';
      }
    } else if (nameRegExp.hasMatch(value)) {
      if (langController.langCode == 'ar') {
        return 'الرجاء التاكد من اسمك';
      } else {
        return 'Invalid Name';
      }
    }
    return null;
  }

  static String? emailValidator({required dynamic value}) {
    // Check if this field is empty
    if (value == null || value.isEmpty) {
      if (langController.langCode == 'ar') {
        return 'الرجاء ادخال البريد الالكتروني';
      } else {
        return 'Email Reqiured';
      }
    }
    // using regular expression
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      if (value == null || value.isEmpty) {
        if (langController.langCode == 'ar') {
          return 'الرجاء ادخال البريد الالكتروني بصيغه صحيحة';
        } else {
          return 'Invalid Email';
        }
      }
    }
    // the email is valid
    return null;
  }

  static String? passwordValidator({required dynamic value}) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      if (langController.langCode == 'ar') {
        return 'الرجاء ادخال كلمة المرور';
      } else {
        return 'Pssword Reqiured';
      }
    }
    // else if (!regex.hasMatch(value)) {
    //   return 'يجب ان تحتوي على رموز و ارقام';
    // }
    else {
      return null;
    }
  }

  static String? passwordConfirmationValidator(
      {required dynamic value, required String password}) {
    if (value!.isEmpty) {
      if (langController.langCode == 'ar') {
        return 'الرجاء ادخال تأكيد كلمة المرور';
      } else {
        return 'Confirm Pssword Reqiured';
      }
    } else if (value != password) {
      if (langController.langCode == 'ar') {
        return 'الرجاء التأكد من كلمة المرور';
      } else {
        return 'Please Confirm Pssword';
      }
    } else {
      return null;
    }
  }

  static String? phoneValidator({required dynamic value, required int number}) {
    if (value!.isEmpty) {
      if (langController.langCode == 'ar') {
        return 'الرجاء ادخال رقم الهاتف ';
      } else {
        return 'Phone Reqiured';
      }
    } else if (value.length != number) {
      if (langController.langCode == 'ar') {
        return 'الرجاء التأكد من رقم الهاتف';
      } else {
        return 'Invalid Phone';
      }
    } else {
      return null;
    }
  }

  static String? landLineMobileValidator({required dynamic value}) {
    if (value!.isEmpty) {
      return 'الرجاء ادخال رقم الهاتف ';
    }
    return null;
  }

  static String? countryCodeValidator({required dynamic value}) {
    if (value!.isEmpty) {
      return 'الرجاء ادخال رمز الدولة ';
    }
    return null;
  }

  static String? faxValidator({required dynamic value}) {
    if (value!.isEmpty) {
      return 'الرجاء ادخال رقم الفاكس ';
    }
    return null;
  }
}
