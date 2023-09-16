// ignore_for_file: non_constant_identifier_names, deprecated_member_use, file_names

import 'dart:core';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

String parseHtmlString(String htmlString) {
  var x = htmlString
      .replaceAll("\n\n", "") // Paragraphs
      .replaceAll("\n", "") // Line Breaks
      .replaceAll("\"", "") // Quote Marks
      .replaceAll("'", ";") // Apostrophe
      .replaceAll(">", "") // Less-than Comparator (Strip Tags)
      .replaceAll("<", "") // Greater-than Comparator (Strip Tags)
      .trim();

  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return x.replaceAll(exp, '');
}

void launchMapMap({
  required String address,
  bool isQueryText = false,
}) async {
  String googleUrl;
  if (!isQueryText) {
    googleUrl = address;
  } else {
    String query = Uri.encodeComponent(address);
    googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
  }

  if (!await launch(googleUrl)) throw 'Could not launch $googleUrl';
}

SendEmail({required String email}) async {
  // UrlLauncher.launch('mailto:elsayed.fahmy.ali@gmail.com');

  await launch(
    'mailto:$email',
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_Key': 'my_header_value'},
  );
  // final Uri _emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'elsayed.fahmy.ali@gmail.com',
  //     queryParameters: {
  //       'subject': 'Example Subject & Symbols are allowed!'
  //     }
  // );

// ...

// mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
//   launch(_emailLaunchUri.toString());
}

share({required String linkuri}) {
  Share.share(linkuri, subject: 'Look what I made!');
}

Future<void> make_PhoneCall({required String phone}) async {
  // if (await UrlLauncher.canLaunch('tel:$phone')) {
  await launch('tel:$phone');
  // } else {
  //   throw 'Could not launch ${'tel:$phone'}';
  // }
}

Future<void> whatsapp({required String phone, String? text}) async {
  final link = WhatsAppUnilink(
    phoneNumber: phone,
    text: text ?? "",
  );
  // Convert the WhatsAppUnilink instance to a string.
  // Use either Dart's string interpolation or the toString() method.
  // The "launch" method is part of "url_launcher".
  await launch('$link');
}

Future<void> downloadPdf({required String url}) async {
  // Convert the WhatsAppUnilink instance to a string.
  // Use either Dart's string interpolation or the toString() method.
  // The "launch" method is part of "url_launcher".
  await launch(url);
}

Future<void> gotoUrl({required String url}) async {
  await launch(url);
}
