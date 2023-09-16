import 'package:flutter/material.dart';

class RequiredTitle extends StatelessWidget {
  final String title;
  const RequiredTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35.0,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text('*', style: TextStyle(color: Colors.red)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
