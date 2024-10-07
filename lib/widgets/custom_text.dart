import 'package:flutter/material.dart';

import '../utilities/helpers/app_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final String? fontFamily;
  final int? maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final Color? backgroundColor;
  final Locale? locale;
  final List<Shadow>? shadows;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textOverflow,
    this.fontFamily,
    this.maxLines,
    this.textAlign,
    this.textDecoration,
    this.letterSpacing,
    this.wordSpacing,
    this.backgroundColor,
    this.locale,
    this.height,
    this.shadows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      locale: locale,
      overflow: textOverflow,
      softWrap: true,
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        backgroundColor: backgroundColor,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        color: color ?? Colors.grey,
        height: height,
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? AppFonts.helvetica,
        decoration: textDecoration ?? TextDecoration.none,
        shadows: shadows,
      ),
    );
  }
}
