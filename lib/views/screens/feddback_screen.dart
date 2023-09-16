// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:albaydar/AppWords.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../constants/util.dart';
import '../widgets/custom_text_from_field.dart';
import 'package:http/http.dart' as http;

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool _isLoading = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _isLoading
          ? SpinKitPulsingGrid(
              itemBuilder: (BuildContext context, int index) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                );
              },
            )
          : ListView(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/logo.png",
                    )),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  prefixIcon: const Icon(Icons.subject),
                  keyboardType: TextInputType.name,
                  controller: titleController,
                  hintText: AppWords.Subject.tr,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  prefixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.name,
                  controller: messageController,
                  maxLines: 8,
                  hintText: AppWords.Message.tr,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20)),
                      onPressed: () {
                        sendFeedback();
                      },
                      child: Text(AppWords.SendMessage.tr),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  sendFeedback() async {
    var fullUrl = Uri.parse("${Util.serverBaseUrl}ContactUs/add-contact");
    try {
      var body = jsonEncode({
        "CustomerId": 3, //customerController.customerInfo.CustomerId,
        "Subject": titleController.text.toString(),
        "Description": messageController.text.toString()
      });
      http.Response response = await http.post(
        fullUrl,
        headers: {'content-type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Done',
          desc: 'Your Message Sended',
          btnOkText: 'ok',
          onDissmissCallback: (type) {
            if (type != DismissType.BTN_OK) {
              // Navigator.pop(context);
            }
          },
          btnOkOnPress: () {
            // Navigator.pop(context);
          },
        ).show();
      } else if (response.statusCode == 401) {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.SCALE,
            title: 'Unauthorized',
            desc: 'Your session has been expired....',
            btnCancelText: 'ok',
            onDissmissCallback: (type) {
              if (type != DismissType.BTN_OK) {
                Navigator.pop(context);
              }
            },
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
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
