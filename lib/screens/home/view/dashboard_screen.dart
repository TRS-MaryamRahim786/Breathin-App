import 'package:breathin_app/screens/home/view/home_screen.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/app_assets.dart';
import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/home_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ========================== [ HOME BLOC PROVIDER ]
    final homeBlocProvider = BlocProvider.of<HomeBloc>(context);

    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: breathin,
            color: AppColors.black,
            fontSize: 24.5,
            fontFamily: AppFonts.raglika,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
            maxLines: 3,
            height: 32 / 20,
            textAlign: TextAlign.left,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppAssets.chatCounter),
                context.sizeBoxWidth(0.03),
                SvgPicture.asset(AppAssets.bellCounter),
                Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.01, right: width * 0.01),
                    child: IconButton(
                      onPressed: () {
                        homeBlocProvider
                            .add(HomeSignOutEvent(context: context));
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: AppColors.grey,
                      ),
                    ))
              ],
            )
          ],
        ),
        body: const TabBarView(
          children: [
            /// Home Screen
            Center(child: HomeScreen()),
            Center(
              child: CustomText(
                text: 'Explore',
                color: AppColors.black,
                fontSize: 24.5,
                fontFamily: AppFonts.raglika,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                maxLines: 3,
                height: 32 / 20,
                textAlign: TextAlign.left,
              ),
            ),
            Center(
              child: CustomText(
                text: 'Profile',
                color: AppColors.black,
                fontSize: 24.5,
                fontFamily: AppFonts.raglika,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                maxLines: 3,
                height: 32 / 20,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: AppColors.white),
          child: TabBar(
            indicatorColor:
                AppColors.white, // Color of the tab indicator (underline)
            dividerColor: AppColors.white,
            tabs: [
              Tab(icon: SvgPicture.asset(AppAssets.homeIcon)),
              Tab(icon: SvgPicture.asset(AppAssets.explore)),
              Tab(icon: SvgPicture.asset(AppAssets.profile)),
            ],
          ),
        ),
      ),
    );
  }
}
