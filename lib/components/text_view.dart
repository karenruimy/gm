import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView(
    this.text, {
    Key? key,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.textAlign,
    this.color = Colors.black,
    this.fontFamily,
    this.overflow,
    this.decoration,
    this.maxLines,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final String? fontFamily;
  final TextDecoration? decoration;
  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow,
        color: color,
        height: height,
        fontFamily: fontFamily,
        decoration: decoration,
      ),
    );
  }
}
