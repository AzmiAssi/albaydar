// ignore_for_file: non_constant_identifier_names, prefer_final_fields
import 'package:albaydar/AppWords.dart';
import 'package:albaydar/models/Customer.dart';
import 'package:albaydar/views/screens/Login/otp_screen.dart';
import 'package:albaydar/views/screens/Login/validation_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_size.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/navigation.dart';
import '../../widgets/clipPath.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_from_field.dart';
import 'Components/required_title.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  int? maxLengthPhone;
  bool termsChecked = false;
  bool _isLoading = false;

  @override
  void initState() {
    // getCitiesByCountryId();
    // handelCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                Stack(
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 50),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Card(
                          color: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        ),
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
                    height: AppSize(context).height * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
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
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppWords.CreateAccount.tr,
                                        style: TextStyle(
                                            height: 1,
                                            fontSize:
                                                AppSize(context).largText1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        AppWords
                                            .Enterinformationbelowtogetstarted
                                            .tr,
                                        style: TextStyle(
                                            height: 1.5,
                                            fontSize:
                                                AppSize(context).smallText3,
                                            color: AppColors.greyColor3),
                                      ),
                                    ],
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RequiredTitle(
                                            title: AppWords.UserName.tr),
                                        CustomTextField(
                                          prefixIcon: const Icon(Icons.person),
                                          keyboardType: TextInputType.name,
                                          controller: firstName,
                                          validator: (value) =>
                                              ValidationInput.usernameValidator(
                                            value: value,
                                          ),
                                        ),

                                        RequiredTitle(
                                            title: AppWords.MiddleName.tr),
                                        CustomTextField(
                                          prefixIcon: const Icon(Icons.person),
                                          keyboardType: TextInputType.name,
                                          controller: middleName,
                                          validator: (value) =>
                                              ValidationInput.usernameValidator(
                                            value: value,
                                          ),
                                        ),

                                        RequiredTitle(
                                            title: AppWords.LastName.tr),
                                        CustomTextField(
                                          prefixIcon: const Icon(Icons.person),
                                          keyboardType: TextInputType.name,
                                          controller: lastName,
                                          validator: (value) =>
                                              ValidationInput.usernameValidator(
                                            value: value,
                                          ),
                                        ),

                                        RequiredTitle(title: AppWords.Email.tr),
                                        CustomTextField(
                                          prefixIcon: const Icon(Icons.email),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: email,
                                          validator: (value) =>
                                              ValidationInput.emailValidator(
                                                  value: value),
                                        ),

                                        RequiredTitle(title: AppWords.phone.tr),

                                        CustomTextField(
                                          prefixIcon:
                                              const Icon(Icons.phone_android),
                                          keyboardType: TextInputType.phone,
                                          maxLength: maxLengthPhone,
                                          controller: phone,
                                          validator: (value) =>
                                              ValidationInput.phoneValidator(
                                                  value: value, number: 10),
                                        ),

                                        RequiredTitle(
                                            title: AppWords.Password.tr),
                                        CustomTextField(
                                            prefixIcon: const Icon(Icons.lock),
                                            keyboardType: TextInputType.text,
                                            controller: password,
                                            validator: (value) =>
                                                ValidationInput
                                                    .passwordValidator(
                                                        value: value)),

                                        RequiredTitle(
                                            title: AppWords.ConfirmPassword.tr),
                                        CustomTextField(
                                            prefixIcon: const Icon(Icons.lock),
                                            keyboardType: TextInputType.text,
                                            controller: passwordConfirm,
                                            validator: (value) => ValidationInput
                                                .passwordConfirmationValidator(
                                                    value: value,
                                                    password:
                                                        password.text.trim())),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              side: MaterialStateBorderSide
                                                  .resolveWith((states) {
                                                return const BorderSide(
                                                    width: 2.0,
                                                    color:
                                                        AppColors.greyColor1);
                                              }),
                                              value: termsChecked,
                                              activeColor:
                                                  AppColors.primaryColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  termsChecked = !termsChecked;
                                                });
                                              },
                                            ),
                                            Text(AppWords
                                                .IAgreeToTheTermsOfUse.tr),
                                          ],
                                        ),
                                        // SizedBox(
                                        //     height:
                                        //         AppSize(context).height * 0.02),
                                        // Todo : Next Button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _isLoading
                                                ? const SizedBox(
                                                    width: 100.0,
                                                    height: 60.0,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  )
                                                : Expanded(
                                                    child: CustomButton(
                                                      text:
                                                          AppWords.Continue.tr,
                                                      onTap: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          navigateTo(
                                                              context,
                                                              OtpScreen(
                                                                customer:
                                                                    Customer(
                                                                  CustomerEmail:
                                                                      email.text
                                                                          .trim(),
                                                                  CustomerFirstName:
                                                                      firstName
                                                                          .text
                                                                          .trim(),
                                                                  CustomerMiddleName:
                                                                      middleName
                                                                          .text
                                                                          .trim(),
                                                                  CustomerLastName:
                                                                      lastName
                                                                          .text
                                                                          .trim(),
                                                                  CustomerNumber:
                                                                      phone.text
                                                                          .trim(),
                                                                ),
                                                                pass: password
                                                                    .text
                                                                    .trim()
                                                                    .toString(),
                                                              ));
                                                          //CreateAccount();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
