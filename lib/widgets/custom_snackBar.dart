import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    int duration = 3,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error : Icons.check_circle,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomText(
                text: message.isNotEmpty ? message : 'Something went wrong!',
                color: AppColors.white,
                fontSize: 13.5,
                letterSpacing: 1.5,
                fontFamily: AppFonts.helvetica,
                maxLines: 3,
              ),
            ),
          ],
        ),
        backgroundColor: isError ? AppColors.red : AppColors.green,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
