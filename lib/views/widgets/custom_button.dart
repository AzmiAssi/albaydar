import 'package:flutter/material.dart';
import '../../constants/app_size.dart';
import '../../constants/color_constant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? buttonColor;
  final double? radius;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.buttonColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: buttonColor ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          radius ?? 10.0,
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.merge(
              TextStyle(
                color: AppColors.whiteColor1,
                fontSize: AppSize(context).buttonText1,
              ),
            ),
      ),
    );
  }
}
