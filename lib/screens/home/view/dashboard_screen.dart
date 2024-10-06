import 'package:breathin_app/screens/home/view/home_screen.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/app_assets.dart';
import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: 'Breathin',
            color: AppColors.black,
            fontSize: 24.5,
            fontFamily: AppFonts.raglika,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
            maxLines: 3,
            height: 32 / 20,
            // Line height (34.4px) divided by font size (24px)

            textAlign: TextAlign.left,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppAssets.chatCounter),
                context.sizeBoxWidth(0.03),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.01, right: width * 0.03),
                  child: SvgPicture.asset(AppAssets.bellCounter),
                )
              ],
            )
          ],
        ),
        body: const TabBarView(
          children: [
            Center(child: HomeScreen()),
            Center(child: Text('Content for Tab 2')),
            Center(child: Text('Content for Tab 3')),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: AppColors.white),
          child: TabBar(
            indicatorColor:
                Colors.white, // Color of the tab indicator (underline)
            unselectedLabelColor: Colors.amber,
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
