import 'package:breathin_app/utilities/helpers/app_assets.dart';
import 'package:breathin_app/widgets/custom_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utilities/helpers/app_fonts.dart';
import '../../../utilities/helpers/colors.dart';
import '../../../utilities/helpers/constants.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/home_bloc.dart';
import '../model/item_model.dart';

/// FeaturedCard widget for each item
class FavoriteCard extends StatelessWidget {
  final FeaturedItem item;
  final VoidCallback onFavoriteToggle;

  HomeBloc homeBlocProvider;

  FavoriteCard(
      {required this.item,
      required this.onFavoriteToggle,
      required this.homeBlocProvider});

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              homeBlocProvider.playAudio(item.musicLink);
            },
            child: Container(
              width: width * 0.39, // Width of each card
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyDivider.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FutureBuilder(
                              future:
                                  homeBlocProvider.getImageUrl(item.imageLink),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CustomImageWidget(
                                    imageUrl: snapshot.data.toString(),
                                    width: width * 1,
                                    height: height * 0.13,
                                  );
                                }
                                return Image.asset(
                                    AppAssets.imageReplaceHolder);
                              }),
                        ),
                      ),
                      Positioned(
                        top: height * 0.0,
                        right: width * 0.01,
                        child: IconButton(
                          icon: Icon(
                            item.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: item.isFavorite
                                ? AppColors.red
                                : AppColors.black,
                          ),
                          onPressed: onFavoriteToggle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 6),
            child: CustomText(
              text: item.name,
              color: AppColors.black,
              fontSize: 14,
              fontFamily: AppFonts.raglika,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              maxLines: 2,
              height: 22 / 14,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 4),
            child: CustomText(
              text: '${item.duration} • ${item.type}',
              color: AppColors.black,
              fontSize: 12,
              fontFamily: AppFonts.raglika,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
              maxLines: 2,
              height: 22 / 14,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
