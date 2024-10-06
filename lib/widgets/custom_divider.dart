import 'package:flutter/material.dart';

import '../utilities/helpers/colors.dart';

class CustomDivider extends StatelessWidget {
  Color? color = AppColors.white;
  double? width = 1;
  CustomDivider({super.key, this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: width ?? 1,
      color: color ?? AppColors.halfWhite,
    );
  }
}
