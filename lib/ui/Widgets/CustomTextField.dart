import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  bool? obscureText;
  Color? colorBorder;
  Color? cursorColor;
  String? hintText;
  bool? isFilled;
  Color? fillColor;
  TextStyle? hintTextStyle;
  int? maxLine;
  String? labelText;
  TextStyle? labelStyle;
  Color? prefixIconColor;
  Widget? prefixIcon;
  Color? suffixIconColor;
  Widget? suffixIcon;
  TextInputType? textInputType;
  TextEditingController? controller;
  String? Function(String?)? validator;

  CustomTextField(
      {super.key, this.textInputType,
      this.maxLine,
      this.colorBorder,
      this.hintText,
      this.cursorColor,
      this.hintTextStyle,
      this.prefixIcon,
      this.fillColor,
      this.isFilled,
      this.prefixIconColor,
      this.suffixIcon,
      this.suffixIconColor,
      this.labelText,
      this.labelStyle,
      this.controller,
      this.validator,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscuringCharacter: '*',
        obscureText: obscureText ?? false,
        validator: validator,
        controller: controller,
        style: AppStyles.regular16white,
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLine ?? 1,
        cursorColor: cursorColor ?? AppColors.yellowColor,
        decoration: InputDecoration(
            filled: isFilled ?? false,
            fillColor: fillColor ?? AppColors.transparentColor,
            suffixIconColor: suffixIconColor,
            suffixIcon: suffixIcon,
            labelText: labelText,
            labelStyle: labelStyle,
            prefixIconColor: prefixIconColor ?? AppColors.whiteColor,
            prefixIcon: prefixIcon,
            hintStyle: hintTextStyle ?? AppStyles.regular16white,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: colorBorder ?? AppColors.yellowColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: colorBorder ?? AppColors.yellowColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.red))));
  }
}
