// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../constants/app_size.dart';

class ToggleTap extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Color titleColor;
  final Color buttonColor;
  const ToggleTap({
    Key? key,
    required this.title,
    required this.titleColor,
    required this.onTap,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: buttonColor,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSize(context).smallText3,
                color: titleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
