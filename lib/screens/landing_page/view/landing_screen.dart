import 'dart:ui';

import 'package:breathin_app/routes/routes.dart';
import 'package:breathin_app/services/shared-pref/shared-pref-service.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/app_assets.dart';
import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utilities/helpers/colors.dart';
import '../../../widgets/custom_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;

    /// ==================== [ Checking User Session ]
    SharedPrefService.instance.getIsUserLogin().then((value) {
      if (value) {
        if (!context.mounted) return;
        context.go(Routes.home);
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.landingBg),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: AppColors.halfWhite
                    .withOpacity(0.01), // Optional overlay color
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent, // Transparent at the top
                            Colors.white.withOpacity(
                                0.2), // Semi-transparent in the middle
                            Colors.white.withOpacity(
                                0.5), // Semi-transparent in the middle
                            Colors.white, // Solid white at the bottom
                          ],
                          stops: [
                            0.0,
                            0.6,
                            0.7,
                            1.0
                          ], // Control the transition points
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.07,
                          right: width * 0.07,
                          top: height * 0.04,
                          bottom: height * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: 'Welcome to $breathin',
                            color: AppColors.black,
                            fontSize: 24.5,
                            fontFamily: AppFonts.raglika,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.5,
                            maxLines: 3,
                            height: 34.4 / 24,
                            textAlign: TextAlign.left,
                          ),
                          context.sizeBoxHeight(0.001),
                          const CustomText(
                            text: 'Take care of your hives through $breathin',
                            color: AppColors.black,
                            fontSize: 14,
                            fontFamily: AppFonts.helvetica,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.5,
                            maxLines: 3,
                            height: 34.4 / 24,
                            textAlign: TextAlign.center,
                          ),
                          context.sizeBoxHeight(0.05),
                          CustomButton(
                            btnName: 'Get Started',
                            textStyle: const TextStyle(
                                color: AppColors.black,
                                fontFamily: AppFonts.helvetica,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1),
                            btnColor: AppColors.buttonColor,
                            onTap: () {
                              context.push(Routes.language);
                            },
                            btnRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
