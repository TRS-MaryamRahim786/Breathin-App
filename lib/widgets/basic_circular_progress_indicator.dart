import 'package:breathin_app/utilities/helpers/app_colors.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:flutter/material.dart';

import '../utilities/helpers/constants.dart';

class BasicCircularProgressIndicator extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const BasicCircularProgressIndicator(
      {super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    final width1 = screenSize.width;
    final height1 = screenSize.height;
    return SizedBox(
      height: height ?? height1 * 0.03,
      width: width ?? width1 * 0.06,
      /*height: height ?? 26.0,
      width: width ?? 26.0,*/
      child: CircularProgressIndicator(
        color: color ?? AppColors.black,
        /*  height: height ?? 20.0,
        width: width ?? 20.0,*/
      ),
    );
  }
}
