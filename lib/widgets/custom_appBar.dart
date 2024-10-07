import 'package:breathin_app/utilities/helpers/app_colors.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../utilities/helpers/app_assets.dart';
import '../utilities/helpers/app_fonts.dart';
import '../utilities/helpers/constants.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? customCallBack;
  void Function()? onPressed;
  final String? actionButton;
  double? toolbarHeight; //56.0;
  bool isShowActionButton;
  final Function? onLeadingTap;

  CustomAppBar(
      {Key? key,
      required this.title,
      this.customCallBack,
      this.actionButton,
      this.toolbarHeight = DEFAULT_TOOLBAR_HEIGHT,
      this.isShowActionButton = true,
      this.onLeadingTap,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: AppColors.white,
      toolbarHeight: DEFAULT_TOOLBAR_HEIGHT,
      title: CustomText(
        text: title,
        fontWeight: FontWeight.normal,
        color: AppColors.grey157,
        fontFamily: AppFonts.semiBold,
        letterSpacing: 1,
        fontSize: 19.8,
      ),
      centerTitle: true,
      leadingWidth: width * 0.2,
      leading: Center(
        child: IconButton(
            splashRadius: 1,
            focusColor: AppColors.white,
            hoverColor: AppColors.white,
            highlightColor: AppColors.white,
            splashColor: AppColors.white,
            onPressed: () {
              // Invoke the custom callback
              // customCallBack!();
              // Navigate back
              if (onLeadingTap != null) {
                onLeadingTap!.call();
                return;
              }
              if (context.canPop()) {
                context.pop();
              }
            },
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset(
              AppAssets.search,
              fit: BoxFit.cover,
              height: height * 0.06,
              width: width * 0.06,
              // color: AppColors.red,
            )),
      ),
      // actions: [
      //   isShowActionButton
      //       ? InkWell(
      //           onTap: () {
      //             customCallBack!();
      //           },
      //           child: SvgPicture.asset(actionButton ?? AppAssets.emailInvoice))
      //       : const SizedBox(),
      //   context.sizeBoxWidth(0.04)
      // ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 78);
}
