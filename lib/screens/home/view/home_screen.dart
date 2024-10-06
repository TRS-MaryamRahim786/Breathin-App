import 'package:breathin_app/screens/home/bloc/home_bloc.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    final homeBlocProvider = BlocProvider.of<HomeBloc>(context);
    return SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: TextFormField(
                controller: homeBlocProvider.homeSearchBarController,
                onChanged: (value) {},
                onFieldSubmitted: (onFieldSubmitted) {},
                cursorColor: AppColors.black,
                decoration: InputDecoration(
                    hintText: 'Search here',
                    hintStyle: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 18.5,
                        height: 14.75 / 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.helvetica,
                        letterSpacing: 0.6),
                    prefixIcon: Container(
                      constraints: BoxConstraints(maxWidth: width * 0.02),
                      child: const Icon(
                        Icons.search,
                        color: AppColors.grey,
                        size: 30,
                      ),
                    )),
              ),
            ),
            context.sizeBoxHeight(0.04),

            /// FAVOURITE LIST VIEW
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Favorites',
                    color: AppColors.black,
                    fontSize: 18,
                    fontFamily: AppFonts.raglika,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    maxLines: 3,
                    height: 22.6 / 16,
                    textAlign: TextAlign.left,
                  ),
                  CustomText(
                    text: 'See All',
                    color: AppColors.black,
                    fontSize: 18,
                    fontFamily: AppFonts.raglika,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    maxLines: 3,
                    height: 22.6 / 16,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.014,
                  bottom: height * 0.02,
                  left: width * 0.04),
              child: SizedBox(
                // width: width * 0.1,
                height: height * 0.19, // Height of the horizontal list
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: homeBlocProvider.featuredItems.length,
                  itemBuilder: (context, index) {
                    final item = homeBlocProvider.featuredItems[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.02, bottom: height * 0.001),
                      child: FeaturedCard(
                        item: item,
                        onFavoriteToggle: () {
                          homeBlocProvider
                              .add(HomeItemFavouriteEvent(featuredItem: item));
                          // Trigger the toggle event
                          // BlocProvider.of<FavoriteBloc>(context).add(ToggleFavoriteEvent(index));
                        },
                        homeBlocProvider: homeBlocProvider,
                      ),
                    );
                  },
                ),
              ),
            ),

            /// FEATURED LIST VIEW
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Featured',
                    color: AppColors.black,
                    fontSize: 18,
                    fontFamily: AppFonts.raglika,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    maxLines: 3,
                    height: 22.6 / 16,
                    textAlign: TextAlign.left,
                  ),
                  CustomText(
                    text: 'See All',
                    color: AppColors.black,
                    fontSize: 18,
                    fontFamily: AppFonts.raglika,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    maxLines: 3,
                    height: 22.6 / 16,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.014,
                  bottom: height * 0.02,
                  left: width * 0.04),
              child: SizedBox(
                // width: width * 0.1,
                height: height * 0.19, // Height of the horizontal list
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: homeBlocProvider.featuredItems.length,
                  itemBuilder: (context, index) {
                    final item = homeBlocProvider.featuredItems[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.02, bottom: height * 0.001),
                      child: FeaturedCard(
                        item: item,
                        onFavoriteToggle: () {
                          homeBlocProvider
                              .add(HomeItemFavouriteEvent(featuredItem: item));
                          // Trigger the toggle event
                          // BlocProvider.of<FavoriteBloc>(context).add(ToggleFavoriteEvent(index));
                        },
                        homeBlocProvider: homeBlocProvider,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
