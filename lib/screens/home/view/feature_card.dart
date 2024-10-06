import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/helpers/app_fonts.dart';
import '../../../utilities/helpers/colors.dart';
import '../../../utilities/helpers/constants.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/home_bloc.dart';
import '../model/item_model.dart';

/// FeaturedCard widget for each item
class FeaturedCard extends StatelessWidget {
  final FeaturedItem item;
  final VoidCallback onFavoriteToggle;

  HomeBloc homeBlocProvider;

  FeaturedCard(
      {required this.item,
      required this.onFavoriteToggle,
      required this.homeBlocProvider});

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * 0.39, // Width of each card
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.greyDivider.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1560193327-e52dafa295f4?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      width: width * 1,
                      // height: height * 0.4,
                      fit: BoxFit.cover,
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
                        color:
                            item.isFavorite ? AppColors.red : AppColors.black,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 6),
          child: CustomText(
            text: item.title,
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
            text: '${item.time} • ${item.category}',
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
    );
  }
}
