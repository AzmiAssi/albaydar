// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double digit;
  const Space({required this.digit});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: digit,
      width: digit,
    );
  }
}
