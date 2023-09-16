// ignore_for_file: file_names, unused_field

import 'dart:convert';
import 'package:albaydar/AppWords.dart';
import 'package:albaydar/models/Customer.dart';
import 'package:albaydar/views/screens/Login/signup_screen.dart';
import 'package:albaydar/views/screens/Login/validation_input.dart';
import 'package:albaydar/views/screens/home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/app_size.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/navigation.dart';
import '../../../constants/util.dart';
import '../../../controllers/functions.dart';
import '../../../main.dart';
import '../../widgets/clipPath.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_from_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  bool showPassword = true;
  bool isNormalUser = true;

  Color notNormalUserButtonColor = AppColors.whiteColor1;
  Color normalUserButtonColor = AppColors.backgroundColor;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      // const Card(
                      //   child: Icon(Icons.arrow_back),
                      // ),
                      Container(
                        height: AppSize(context).height * 0.3,
                        color: AppColors.primaryColor.withOpacity(0.2),
                      ),
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 450),
                          color: AppColors.primaryColor.withOpacity(0.5),
                          height: AppSize(context).height * 0.25,
                          alignment: Alignment.center,
                        ),
                      ),
                      ClipPath(
                        clipper: WaveClipper(waveDeep: 0, waveDeep2: 100),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 50),
                          color: AppColors.primaryColor.withOpacity(0.3),
                          height: AppSize(context).height * 0.287,
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: AppSize(context).height * 0.2,
                  ),
                  SizedBox(
                    height: AppSize(context).height * 0.68,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: AppSize(context).appPadding,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppWords.WelcomToAlbaydrApp.tr,
                                      style: TextStyle(
                                          height: 1.5,
                                          fontSize: AppSize(context).largText2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      AppWords.HellowthereLogintoyouraccount.tr,
                                      style: TextStyle(
                                          height: 1,
                                          fontSize: AppSize(context).smallText3,
                                          color: AppColors.greyColor3),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  // height: AppSize(context).height * 0.35,
                                  width: AppSize(context).width,
                                  // color: AppColors.backgroundColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height:
                                              AppSize(context).height * 0.03),
                                      // Todo : Email Text From Field
                                      Text(
                                        AppWords.phone.tr,
                                        style: TextStyle(
                                          fontSize: AppSize(context).smallText3,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              AppSize(context).height * 0.007),
                                      CustomTextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: mobileController1,
                                        icon: const Icon(
                                          Icons.phone,
                                          color: AppColors.primaryColor,
                                        ),
                                        validator: (value) =>
                                            ValidationInput.phoneValidator(
                                                value: mobileController1.text
                                                    .trim(),
                                                number: 10),
                                      ),
                                      SizedBox(
                                        height: AppSize(context).height * 0.02,
                                      ),
                                      // Todo : Password Text From Field
                                      Text(
                                        AppWords.Password.tr,
                                        style: TextStyle(
                                          fontSize: AppSize(context).smallText3,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              AppSize(context).height * 0.007),
                                      CustomTextFormField(
                                        controller: passwordController2,
                                        hidePassword: showPassword,
                                        icon: const Icon(
                                          Icons.lock,
                                          color: AppColors.primaryColor,
                                        ),
                                        iconButton: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showPassword = !showPassword;
                                              });
                                            },
                                            icon: showPassword
                                                ? const Icon(
                                                    Icons.visibility_off,
                                                    color: AppColors.greyColor1,
                                                  )
                                                : const Icon(
                                                    Icons.remove_red_eye,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )),
                                        keyboardType: TextInputType.text,
                                        validator: (value) =>
                                            ValidationInput.passwordValidator(
                                          value: mobileController1.text.trim(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: InkWell(
                                                  onTap: () {
                                                    // Navigator.of(context).push(
                                                    //     downToTop(
                                                    //         const SignUpScreen()));
                                                  },
                                                  child: Text(
                                                      AppWords
                                                          .Forgotpassword.tr,
                                                      style: TextStyle(
                                                          fontSize:
                                                              AppSize(context)
                                                                  .smallText3,
                                                          color: AppColors
                                                              .primaryColor)))),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              AppSize(context).height * 0.025),
                                      // Todo : Sign In Button
                                      Center(
                                        child: _isLoading
                                            ? const CircularProgressIndicator()
                                            : SizedBox(
                                                width: AppSize(context).width,
                                                child: CustomButton(
                                                  text: AppWords.Login.tr,
                                                  onTap: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      checkLogin();
                                                      // await loginFunction();
                                                    }
                                                  },
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                          height:
                                              AppSize(context).height * 0.015),

                                      // Todo : SignUp Button
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3.0, bottom: 14.0),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppWords.DontHaveAnAccount.tr,
                                                  style: TextStyle(
                                                      fontSize: AppSize(context)
                                                          .smallText3),
                                                ),
                                                SizedBox(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(downToTop(
                                                                  const SignUpScreen()));
                                                        },
                                                        child: Text(
                                                            AppWords
                                                                .CreateAccount
                                                                .tr,
                                                            style: TextStyle(
                                                                fontSize: AppSize(
                                                                        context)
                                                                    .smallText3,
                                                                color: AppColors
                                                                    .primaryColor))))
                                              ])),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Todo : As Guist Button
                  Center(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(AppWords.ContinueAsGuest.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .merge(TextStyle(
                                            color: AppColors.whiteColor1,
                                            fontSize:
                                                AppSize(context).smallText1))),
                              ))))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  checkLogin() async {
    var fullUrl = Uri.parse(
        "${Util.serverBaseUrl}Login/login?Phone=${mobileController1.text.trim()}&Password=${passwordController2.text.trim()}");

    try {
      http.Response response = await http.post(fullUrl);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            customerController.customerInfo = Customer(
                CustomerFirstName: data["customerName"],
                CityArabicName: data["cityArabicName"],
                CityName: data["cityName"],
                CustomerEmail: data["customerEmail"],
                CustomerId: data["customerId"],
                CustomerNumber: data["customerNumber"],
                CustomerStatus: data["customerStatus"],
                Token: data["token"]);
            setUSerPrefsData();
            mobileController1.clear();
            passwordController2.clear();
            navigateToAndRemoveUntil(context, const HomeScreen());
            setState(() {});
          }
        }
      } else if (response.statusCode == 404) {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.SCALE,
            title: 'Worning',
            desc: 'Encorrect Email Or Password',
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
}
