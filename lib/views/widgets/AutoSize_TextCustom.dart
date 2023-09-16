// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, file_names, camel_case_types

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';

class CustomAutoText extends StatelessWidget {
  final String title;
  final Color titleColor;
  final TextAlign? titlelign;
  bool underline;
// final  String titlefontFamily;
  final double titleSize;
  final int? titlemaxLines;
  final FontWeight titlefontWeight;
  String? fontFamily;
  CustomAutoText(
      {required this.title,
      required this.titleColor,
      this.titlelign,
      this.underline = false,
      this.fontFamily,
      required this.titleSize,
      this.titlemaxLines,
      required this.titlefontWeight});
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      minFontSize: 6,
      // maxFontSize: titleSize+2.sp??16 ,
      style: TextStyle(
        color: titleColor,
        // fontFamily:fontFamily??AppFonts.ahmanalblack,
        fontWeight: titlefontWeight,
        fontSize: titleSize + 2,
        // decorationStyle: TextDecorationStyle.dashed,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        // overflow: TextOverflow.ellipsis,
      ),
      maxLines: titlemaxLines ?? 1,

      textAlign: titlelign ?? TextAlign.start,
    );
  }
}

class titleCustomAutoText extends StatelessWidget {
  final String title;
  final Color titleColor;
  final TextAlign? titlelign;
  bool underline;
// final  String titlefontFamily;
  final double titleSize;
  final int? titlemaxLines;
  final FontWeight titlefontWeight;
  String? fontFamily;
  titleCustomAutoText(
      {required this.title,
      required this.titleColor,
      this.titlelign,
      this.underline = false,
      this.fontFamily,
      required this.titleSize,
      this.titlemaxLines,
      required this.titlefontWeight});
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      style: TextStyle(
        color: titleColor,
        // fontFamily:fontFamily??AppFonts.ahmanalblack,
        fontWeight: titlefontWeight,
        fontSize: titleSize + 2.sp,
        // decorationStyle: TextDecorationStyle.dashed,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      maxLines: titlemaxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: titlelign ?? TextAlign.start,
    );
  }
}

class CatText extends StatelessWidget {
  final String title;
  final Color titleColor;
  final TextAlign? titlelign;
  bool underline;
// final  String titlefontFamily;
  final double titleSize;
  final int? titlemaxLines;
  final FontWeight titlefontWeight;
  String? fontFamily;
  CatText(
      {required this.title,
      required this.titleColor,
      this.titlelign,
      this.underline = false,
      this.fontFamily,
      required this.titleSize,
      this.titlemaxLines,
      required this.titlefontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: titleColor,
          // fontFamily:fontFamily??AppFonts.ahmanalblack,
          fontWeight: titlefontWeight,
          fontSize: titleSize,
          // decorationStyle: TextDecorationStyle.dashed,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
          overflow: TextOverflow.ellipsis),
      maxLines: titlemaxLines ?? 1,
      textAlign: titlelign ?? TextAlign.start,
    );
  }
}
