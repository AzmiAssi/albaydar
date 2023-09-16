// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:albaydar/AppWords.dart';
import 'package:albaydar/constants/navigation.dart';
import 'package:albaydar/models/Customer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/app_size.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/util.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.customer, required this.pass});
  Customer customer;
  String? pass;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();
  final TextEditingController otp5 = TextEditingController();
  final TextEditingController otp6 = TextEditingController();

  late Timer _timer;
  int _start = 59;
  bool isLoading = false;
  late String OTP = "";
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          isLoading = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    sendOTP();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppWords.AccountConfirmation.tr,
          // style: TextStyle(fontSize:  MediaQuery AppSize(context).mediumText3),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: AppSize(context).appPadding,
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.lock),
                ),
                SizedBox(height: AppSize(context).height * 0.05),
                Text(
                  AppWords.Aconfirmationcodehasbeensenttoyouremail.tr,
                  style: TextStyle(fontSize: AppSize(context).smallText2),
                ),
                SizedBox(height: AppSize(context).height * 0.02),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpInputWidgit(autoFocus: false, controller: otp1),
                        SizedBox(width: AppSize(context).width * 0.04),
                        OtpInputWidgit(autoFocus: false, controller: otp2),
                        SizedBox(width: AppSize(context).width * 0.04),
                        OtpInputWidgit(autoFocus: false, controller: otp3),
                        SizedBox(width: AppSize(context).width * 0.04),
                        OtpInputWidgit(autoFocus: false, controller: otp4),
                        SizedBox(width: AppSize(context).width * 0.04),
                        OtpInputWidgit(autoFocus: false, controller: otp5),
                        SizedBox(width: AppSize(context).width * 0.04),
                        OtpInputWidgit(autoFocus: false, controller: otp6)
                      ]),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSize(context).height * 0.05,
                        horizontal: AppSize(context).width * 0.03),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppWords.Didntoureceivethecodeyet.tr,
                              style: TextStyle(
                                  fontSize: AppSize(context).smallText1)),
                          _start == 0
                              ? InkWell(
                                  onTap: () {
                                    sendOTP();
                                    setState(() {
                                      _start = 59;
                                    });
                                    startTimer();
                                  },
                                  child: Text(
                                    AppWords.resendcode.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              : Text('0 : ${_start.toString()}',
                                  style: TextStyle(
                                      fontSize: AppSize(context).smallText1,
                                      fontWeight: FontWeight.bold))
                        ]))
              ])),
      bottomNavigationBar: isLoading
          ? const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: AppSize(context).appPadding,
                  width: AppSize(context).width,
                  child: CustomButton(
                    text: AppWords.Done.tr,
                    onTap: () {
                      CreateAccount();
                      // if (OTP ==
                      //     (otp1.text.toString().trim() +
                      //         otp2.text.toString().trim() +
                      //         otp3.text.toString().trim() +
                      //         otp4.text.toString().trim() +
                      //         otp5.text.toString().trim() +
                      //         otp6.text.toString().trim())) {
                      //   CreateAccount();
                      // } else {
                      //   AwesomeDialog(
                      //     context: context,
                      //     dialogType: DialogType.ERROR,
                      //     animType: AnimType.SCALE,
                      //     title: 'Not Found',
                      //     desc: 'OTP Number Not Correct',
                      //     btnCancelOnPress: () {
                      //       setState(() {
                      //         isLoading = false;
                      //       });
                      //     },
                      //     btnCancelText: 'cancel',
                      //   ).show();
                      // }
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }

  CreateAccount() async {
    var fullUrl = Uri.parse("${Util.serverBaseUrl}Customer/add-new-customer");
    var body = jsonEncode({
      "FirstName": widget.customer.CustomerFirstName.toString(),
      "MiddleName": widget.customer.CustomerMiddleName.toString(),
      "LastName": widget.customer.CustomerLastName.toString(),
      "Email": widget.customer.CustomerEmail.toString(),
      "Phone": widget.customer.CustomerNumber.toString(),
      "Password": widget.pass.toString(),
      "CityId": 2,
      "IsAgre": 1
    });
    try {
      http.Response response = await http.post(fullUrl,
          headers: {'content-type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            title: 'Done',
            desc: 'Your Account Created Successfully',
            btnOkText: 'ok',
            onDissmissCallback: (type) {
              if (type != DismissType.BTN_OK) {}
            },
            btnOkOnPress: () {
              pop(context);
              pop(context);
            },
          ).show();
        }
      } else if (response.statusCode == 404) {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.SCALE,
            title: 'Worning',
            desc: 'Something Wrong',
            btnCancelText: 'ok',
            onDissmissCallback: (type) {
              if (type != DismissType.BTN_OK) {}
            },
            btnCancelOnPress: () {},
          ).show();
        }
      } else {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'error',
            desc: 'errorappearing',
            btnCancelOnPress: () {},
            btnCancelText: 'cancel',
          ).show();
        }
      }
    } catch (e) {
      if (mounted) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'error',
          desc: e.toString(),
          btnCancelOnPress: () {},
          btnCancelText: 'cancel',
        ).show();
      }
    }
  }

  sendOTP() async {
    var fullUrl = Uri.parse("${Util.serverBaseUrl}SendMail/send");

    try {
      http.Response response = await http
          .post(fullUrl, body: {"Email": widget.customer.CustomerEmail});

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            setState(() {
              OTP = data[""];
            });
          }
        }
      }
    } catch (e) {
      if (mounted) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'error',
          desc: e.toString(),
          btnCancelOnPress: () {},
          btnCancelText: 'cancel',
        ).show();
      }
    }
  }
}

class OtpInputWidgit extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInputWidgit({
    Key? key,
    required this.controller,
    required this.autoFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: AppSize(context).width * 0.2,
          // padding: AppSize(context).appPadding,
          height: AppSize(context).height * 0.07,
          // color: AppColors.,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyColor1.withOpacity(0.5))),
          child: TextField(
              style: TextStyle(
                fontSize: AppSize(context).smallText1,
                color: AppColors.primaryColor,
                // fontWeight: FontWeight.bold,
              ),
              autofocus: autoFocus,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: controller,
              maxLength: 1,
              cursorColor: AppColors.primaryColor,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 17.0),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  counterText: '',
                  hintStyle:
                      TextStyle(color: AppColors.blackColor1, fontSize: 12)),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              })),
    );
  }
}
