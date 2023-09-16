import 'package:albaydar/AppWords.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyFavorit extends StatelessWidget {
  const EmptyFavorit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(child: Image.asset('assets/images/favorit_empty.jpg')),
        ),
        Text(
          AppWords.EmptyFavorite.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
    );
  }
}
