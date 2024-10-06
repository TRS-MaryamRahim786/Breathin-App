import 'package:breathin_app/Utilities/helpers/app_colors.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/helpers/app_fonts.dart';
import '../utilities/helpers/colors.dart';
import '../utilities/helpers/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.onTap,
      required this.btnName,
      this.width,
      this.height,
      this.btnRadius,
      this.btnBoxBorder,
      this.btnColor = AppColors.black,
      this.isPrefixIcon = false,
      this.prefixIcon,
      this.iconColor,
      this.textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontFamily: AppFonts.semiBold,
      )});

  final Function() onTap;
  final String btnName;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? btnColor;
  final BoxBorder? btnBoxBorder;
  final double? btnRadius;
  bool? isPrefixIcon;
  String? prefixIcon;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final screenHeight = screenSize.height;
    return GestureDetector(
      onTap: () {
        // Default behavior: Unfocus keyboard
        FocusScope.of(context).unfocus();

        // Execute user-provided onTap function (if available)
        if (onTap != null) {
          FocusScope.of(context).unfocus();
          onTap!();
        }
      },
      child: Container(
        width: width,
        height: height ?? screenHeight * 0.066,
        decoration: BoxDecoration(
            color: btnColor,
            border: btnBoxBorder,
            borderRadius: BorderRadius.circular(btnRadius ?? 3)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isPrefixIcon == true)
              Row(
                children: [
                  SvgPicture.asset(
                    prefixIcon ?? "",

                    /*   colorFilter: ColorFilter.mode(
                        iconColor ?? AppColors.transparent, BlendMode.srcIn),*/
                    //color: iconColor ?? AppColors.transparent,
                  ),
                  context.sizeBoxWidth(0.05),
                ],
              ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                btnName,
                style: textStyle,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
