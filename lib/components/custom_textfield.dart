import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const  CustomTextField({
    super.key,
    required this.hintText,
    this.enableBorderColor = Colors.orangeAccent,
    this.focusBorderColor = Colors.orange,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixWidget,
    this.fontSize = 14,
    this.obscureText = false,
    this.fillColor = Colors.white,
    this.bottomMargin = 20,
    this.verticalPadding = 16.0,
    this.horizontalPadding = 16.0,
    this.height = 42,
    this.onTap,
    this.controller,
    this.inputType,
    this.textColor = AppColors.blackColor,
    this.inputFormatters,
    this.onSaved,
    this.onChange,
    this.onValidate,
    this.hasTitle = true,
    this.hintColor = AppColors.blackColor,
  });

  final Color fillColor;
  final Color textColor;
  final String hintText;
  final double bottomMargin;
  final double verticalPadding;
  final double horizontalPadding;
  final double height;
  final bool readOnly;
  final Color enableBorderColor;
  final Color focusBorderColor;
  final Color hintColor;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final double? fontSize;
  final bool obscureText;
  final VoidCallback? onTap;
  final bool hasTitle;

  final TextEditingController? controller;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String? val)? onSaved;
  final void Function(String val)? onChange;
  final String? Function(String? val)? onValidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          style: TextStyle(fontSize: fontSize, color: textColor),
          keyboardType: inputType,
          validator: onValidate,
          onSaved: onSaved,
          onChanged: onChange,
          inputFormatters: inputFormatters,
          onTap: onTap,
          cursorColor: AppColors.primaryLight,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            contentPadding:  EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
            filled: true,
            isDense: true,
            fillColor: fillColor,

            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            prefixIcon: prefixIcon,
            suffixIcon: suffixWidget,
          ),
        ),
        SizedBox(
          height: bottomMargin,
        ),
      ],
    );
  }
}
