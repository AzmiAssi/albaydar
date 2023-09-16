// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'dart:convert';

import 'package:albaydar/models/Contact.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../constants/urlLuncher.dart';
import '../../constants/util.dart';
import '../widgets/AutoSize_TextCustom.dart';
import '../widgets/Space.dart';
import 'package:http/http.dart' as http;

class ContactUsSCreen extends StatefulWidget {
  static String routName = '/ContactUsSCreen';

  @override
  _ContactUsSCreenState createState() => _ContactUsSCreenState();
}

class _ContactUsSCreenState extends State<ContactUsSCreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Contact contact = Contact();
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    getContacts();
    super.initState();
  }

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
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/logo.png",
                    )),
                phoneItem(
                    iconData: FontAwesomeIcons.whatsapp,
                    title1: contact.phoneNumber.toString(),
                    onTap1: () async {
                      await whatsapp(
                          phone: contact.phoneNumber.toString(), text: '');
                    },
                    title2: "Albaydar whatsapp",
                    onTap2: () async {
                      await whatsapp(
                          phone: contact.phoneNumber.toString(), text: '');
                    },
                    iconsColor: Colors.black),
                phoneItem(
                    iconData: Icons.phone,
                    title1: contact.phoneNumber.toString(),
                    onTap1: () async {
                      await make_PhoneCall(
                          phone: contact.phoneNumber.toString());
                    },
                    title2: 'Albaydar Phone Number',
                    onTap2: () async {
                      await make_PhoneCall(
                          phone: contact.phoneNumber.toString());
                    },
                    iconsColor: Colors.black),
                iconItem(
                    title: 'Azmiassi4@gmail.com',
                    iconData: Icons.email,
                    onTap: () {
                      SendEmail(email: 'Azmiassi4@gmail.com');
                    },
                    iconsColor: Colors.black,
                    underline: true),
                iconItem(
                    title: 'Albaydar',
                    iconData: Icons.add_location,
                    onTap: () async {
                      launchMapMap(
                          address: contact.aboutLink.toString(),
                          isQueryText: false);
                    },
                    iconsColor: Colors.black),
                // iconItem(
                //     title: 'Address',
                //     iconData: Icons.home,
                //     onTap: () {
                //       launchMapMap(
                //           address: contact.aboutLink.toString(), isQueryText: true);
                //     },
                //     iconsColor: Colors.black),
                socialMedia(),
              ],
            ),
    );
  }

  Widget iconItem(
      {required IconData iconData,
      required String title,
      required Function onTap,
      required Color iconsColor,
      bool underline = false}) {
    return title.isEmpty
        ? const Space(digit: 0)
        : InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: CustomAutoText(
                        title: title,
                        titleSize: 12,
                        titlemaxLines: 2,
                        titleColor: Colors.black,
                        titlefontWeight: FontWeight.bold,
                        titlelign: TextAlign.center,
                        underline: underline),
                  ),
                  const Space(digit: 10),
                  Icon(
                    iconData,
                    color: iconsColor,
                    size: 30,
                  ),
                ],
              ),
            ),
          );
  }

  Widget phoneItem(
      {required IconData iconData,
      required String title1,
      required Function onTap1,
      required String title2,
      required Function onTap2,
      required Color iconsColor,
      bool underline = false}) {
    return title1.toString().isEmpty && title2.toString().isEmpty
        ? const Space(digit: 0)
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title1.toString().isNotEmpty)
                  InkWell(
                    onTap: () => onTap1(),
                    child: CustomAutoText(
                        title: title1.replaceAll('+', '00'),
                        titleSize: 12,
                        titlemaxLines: 2,
                        titleColor: Colors.black,
                        titlefontWeight: FontWeight.bold,
                        titlelign: TextAlign.center,
                        underline: underline),
                  ),
                if (title2.toString().isNotEmpty)
                  InkWell(
                    onTap: () => onTap2(),
                    child: CustomAutoText(
                        title: ' / $title2'.replaceAll('+', '00'),
                        titleSize: 12,
                        titlemaxLines: 2,
                        titleColor: Colors.black,
                        titlefontWeight: FontWeight.bold,
                        titlelign: TextAlign.center,
                        underline: underline),
                  ),
                const Space(digit: 10),
                Icon(
                  iconData,
                  color: iconsColor,
                  size: 30,
                ),
              ],
            ),
          );
  }

  Widget socialMedia() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // InkWell(
          //     onTap: () async {
          //       gotoUrl(url: '${Setting.appSetting.snapchat}');
          //     },
          //     child: Icon(
          //       FontAwesomeIcons.snapchat,
          //       color: Colors.yellow,
          //       size: 30,
          //     )),
          // Space(digit: 14),
          // InkWell(
          //     onTap: () async {
          //       gotoUrl(url: '${Setting.appSetting.twitter}');
          //     },
          //     child: Icon(
          //       FontAwesomeIcons.twitter,
          //       color: Colors.blue,
          //       size: 30,
          //     )),
          // Space(digit: 14),
          InkWell(
              onTap: () async {
                gotoUrl(url: contact.instagramLink.toString());
              },
              child: const Icon(
                FontAwesomeIcons.instagram,
                color: Colors.red,
                size: 30,
              )),
          const Space(digit: 14),
          InkWell(
              onTap: () async {
                gotoUrl(url: contact.facebookLink.toString());
              },
              child: const Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
                size: 30,
              )),
        ],
      ),
    );
  }

  getContacts() async {
    var fullUrl = Uri.parse("${Util.serverBaseUrl}AboutUs/get-about-us");
    try {
      http.Response response = await http.get(fullUrl);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            contact = Contact(
                aboutId: int.parse(data["aboutId"].toString()),
                aboutLink: data["aboutLink"],
                aboutTitle: data["aboutTitle"],
                description: data["description"],
                descriptionArabic: data["descriptionArabic"],
                facebookLink: data["facebookLink"],
                instagramLink: data["instagramLink"],
                phoneNumber: data["phoneNumber"],
                titleArabic: data["titleArabic"]);
          }
        }
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
