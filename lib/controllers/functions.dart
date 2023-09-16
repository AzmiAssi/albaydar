// ignore_for_file: non_constant_identifier_names
import 'package:albaydar/main.dart';
import 'package:albaydar/models/Customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void getUSerPrefsData() async {
  customerController.customerInfo = Customer();
  //Setting.userInfo = null;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var CustomerId = preferences.getInt('CustomerId');

  if (CustomerId != null) {
    customerController.customerInfo.CustomerId = CustomerId;
    customerController.customerInfo.CustomerFirstName =
        preferences.getString('CustomerFirstName');
    customerController.customerInfo.CustomerMiddleName =
        preferences.getString('CustomerMiddleName');
    customerController.customerInfo.CustomerLastName =
        preferences.getString('CustomerLastName');
    customerController.customerInfo.CustomerNumber =
        preferences.getString('CustomerNumber');
    customerController.customerInfo.CustomerEmail =
        preferences.getString('CustomerEmail');
    langController.setLnagCode(preferences.getString('langCode').toString());
  }
}

void setUSerPrefsData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setInt(
      'CustomerId', customerController.customerInfo.CustomerId as int);
  preferences.setString('CustomerFirstName',
      customerController.customerInfo.CustomerFirstName.toString());
  preferences.setString('CustomerMiddleName',
      customerController.customerInfo.CustomerMiddleName.toString());
  preferences.setString('CustomerLastName',
      customerController.customerInfo.CustomerLastName.toString());
  preferences.setString('CustomerNumber',
      customerController.customerInfo.CustomerNumber.toString());
  preferences.setString('CustomerEmail',
      customerController.customerInfo.CustomerEmail.toString());
  preferences.setString('langCode', langController.langCode.toString());

  langController.setLnagCode(langController.langCode.toString());
}
