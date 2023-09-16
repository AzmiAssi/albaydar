import 'package:flutter/material.dart';
import '../../constants/app_size.dart';
import '../../constants/color_constant.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? Function(dynamic)? validator;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final Color? fillColor;
  final int maxLines;
  final int? maxLength;
  final bool? readOnly;
  final bool? haveBorder;

  const CustomTextField({
    this.hintText,
    this.onChanged,
    this.readOnly,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode,
    this.maxLines = 1,
    Key? key,
    this.fillColor,
    this.haveBorder,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly ?? false,
      validator: validator,
      focusNode: focusNode,
      maxLength: maxLength,
      style: TextStyle(
        fontSize: AppSize(context).smallText1,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintStyle: TextStyle(
            color: AppColors.greyColor2, fontSize: AppSize(context).smallText4),
        contentPadding: const EdgeInsets.all(10.0),
        fillColor: fillColor ?? AppColors.whiteColor1,
        filled: true,
        prefixIcon: prefixIcon,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            gapPadding: 0,
            borderSide: const BorderSide(color: AppColors.greyColor1),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
                color: haveBorder == null
                    ? AppColors.greyColor1
                    : AppColors.whiteColor1),
            borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
                color: haveBorder == null
                    ? AppColors.greyColor1
                    : AppColors.whiteColor1),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
                color: haveBorder == null
                    ? AppColors.greyColor1
                    : AppColors.whiteColor1),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderSide: const BorderSide(color: AppColors.redColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.validator,
    this.hintValue,
    this.validation,
    required this.controller,
    this.validationErrorMsg,
    this.hidePassword,
    this.iconButton,
    this.keyboardType,
    this.isCenterText,
    this.isCircularBorder,
    this.icon,
    this.readOnly,
    this.maxLength,
    this.onFieldSubmitted,
    this.onChanged,
    this.radios,
    this.maxline,
    this.labelText,
    this.spaceFromTop,
    this.spaceFromdown,
    this.borderColor,
    this.backgroundColor,
    this.fillColor,
    this.haveBorder,
  }) : super(key: key);
  final int? maxline;
  final String? labelText;
  final String? hintValue;
  final Color? fillColor;
  final bool? validation;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? validationErrorMsg;
  final bool? hidePassword;
  final bool? isCenterText;
  final bool? isCircularBorder;
  final Widget? iconButton;
  final Widget? icon;
  final bool? readOnly;
  final int? maxLength;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final double? radios;
  final double? spaceFromTop;
  final double? spaceFromdown;
  final Color? borderColor;
  final Color? backgroundColor;
  final bool? haveBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: spaceFromTop ?? 0.0, bottom: spaceFromdown ?? 0.0),
      child: TextFormField(
        maxLines: maxline ?? 1,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black, fontSize: 13),
        controller: controller,
        textAlign: (isCenterText ?? false) ? TextAlign.center : TextAlign.start,
        validator: validator,
        cursorColor: AppColors.blackColor2,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: hidePassword ?? false,
        readOnly: readOnly == null ? false : readOnly!,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: labelText,
          counterText: '',
          filled: true,
          hintText: (hintValue) ?? '',
          alignLabelWithHint: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          labelStyle: TextStyle(
              color: borderColor ?? AppColors.greyColor2, fontSize: 13),
          hintStyle: TextStyle(
              color: AppColors.greyColor2,
              fontSize: AppSize(context).smallText4),
          suffixIcon: iconButton,
          prefixIcon: icon,
          fillColor: fillColor ?? Colors.white,
          border: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                  color: borderColor == null
                      ? AppColors.greyColor1
                      : borderColor as Color),
              borderRadius: BorderRadius.circular(radios ?? 10)),
          focusedBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                  color: haveBorder == null
                      ? AppColors.greyColor1
                      : AppColors.whiteColor1),
              borderRadius: BorderRadius.circular(radios ?? 10)),
          disabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                  color: haveBorder == null
                      ? AppColors.greyColor1
                      : AppColors.whiteColor1),
              borderRadius: BorderRadius.circular(radios ?? 10)),
          enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                  color: haveBorder == null
                      ? AppColors.greyColor1
                      : AppColors.whiteColor1),
              borderRadius: BorderRadius.circular(radios ?? 10)),
          errorBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: const BorderSide(color: AppColors.redColor),
            borderRadius: BorderRadius.circular(radios ?? 40),
          ),
        ),
      ),
    );
  }
}
