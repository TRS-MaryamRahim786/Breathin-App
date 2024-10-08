import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      this.controller,
      this.label,
      this.onTap,
      this.obscureText = false,
      this.enabled = true,
      this.onChanged,
      this.maxLines,
      this.maxLength,
      this.keyboardType,
      this.suffixIcon,
      this.validator,
      this.prefixIcon,
      this.textInputAction,
      this.filled = true,
      this.fillColor = AppColors.transparent,
      this.hintStyle,
      this.isReadOnly,
      this.edgeInsets,
      this.horizontalPadding,
      this.inputFormatters,
      this.textFieldHeading,
      this.headingFontSize,
      this.verticalFieldPadding,
      this.isRequireField,
      this.contentPadding,
      this.headingBottomPadding});

  final String hintText;
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  final bool enabled;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? edgeInsets;
  final bool? isReadOnly;
  final VoidCallback? onTap;
  double? horizontalPadding;
  List<TextInputFormatter>? inputFormatters;
  final String? textFieldHeading;
  final double? headingFontSize;
  final double? headingBottomPadding;
  final double? verticalFieldPadding;
  bool? isRequireField;
  double? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsets ??
          EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 10,
              vertical: verticalFieldPadding ?? 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isRequireField == true)
              ? RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: textFieldHeading ?? "",
                          style: TextStyle(
                              fontSize: headingFontSize ?? 13,
                              color: AppColors.grey157)),
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors
                                  .red)), // Optional: Customize asterisk style
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                      bottom: headingBottomPadding ??
                          MediaQuery.of(context).size.height * 0.01),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      text: textFieldHeading ?? "",
                      color: AppColors.black,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.bold,
                      fontSize: headingFontSize ?? 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
          // context.height(0.01),
          TextFormField(
            cursorColor: AppColors.blackOpacity50,
            onTap: onTap,
            validator: validator,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            // obscuringCharacter: "*",
            style: TextStyle(fontSize: 16, color: AppColors.black70),
            textInputAction: textInputAction,
            maxLines: maxLines ?? 1,
            enabled: enabled,
            onChanged: onChanged,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            readOnly: isReadOnly ?? false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              alignLabelWithHint: true,
              isDense: true,
              counterText: '',
              suffixIcon: suffixIcon,
              // prefixIcon: prefixIcon,
              // label: Text(
              //   label ?? "",
              //   maxLines: 1,
              //   softWrap: true,
              //   overflow: TextOverflow.clip,
              //   style: hintStyle ??
              //       const TextStyle(
              //         fontSize: 16.0,
              //         color: AppColors.grey,
              //         fontFamily: AppFonts.semiBold,
              //       ),
              // ),
              border: _border,
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(
                      fontSize: 16.0,
                      color: AppColors.blackOpacity50,
                      fontFamily: AppFonts.semiBold,
                      letterSpacing: 1),
              enabledBorder: _border,
              focusedBorder: _focusBorder,
              filled: filled,
              fillColor: fillColor,
            ),
          ),
        ],
      ),
    );
  }

  get _focusBorder => OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(12));

  get _border => OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.white, width: 1.5),
      borderRadius: BorderRadius.circular(12));
}

/// Search Text Field
class SearchTextField extends StatelessWidget {
  SearchTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.onClear,
      this.onFieldSubmitted,
      required this.focusBorderColor,
      required this.title,
      required this.titleColor});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final Function()? onClear;
  Color? focusBorderColor = AppColors.grey157;
  Color? titleColor = AppColors.grey157;
  final String title;

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return SizedBox(
      height: 46,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: focusBorderColor ?? AppColors.grey157)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyDivider, width: 1)),
            hintText: title,
            hintStyle:
                TextStyle(color: titleColor ?? AppColors.red, fontSize: 18.5),
            prefixIcon: Container(
              constraints: BoxConstraints(maxWidth: width * 0.02),
              // color: AppColors.primary,
              // height: height * 0.002,
              // width: width * 0.002,
              child: const Icon(
                Icons.search,
                color: AppColors.darkGrey60,
                size: 32,
              ),
            )),
      ),
    );
  }
}
