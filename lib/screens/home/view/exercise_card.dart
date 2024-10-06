// Exercise Card Widget
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../../../utilities/helpers/app_fonts.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/home_bloc.dart';
import '../model/exercise_model.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseItem item;
  HomeBloc homeBlocProvider;

  ExerciseCard({required this.item, required this.homeBlocProvider});

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.007, horizontal: width * 0.044),
      child: FutureBuilder(
        future: homeBlocProvider.getImageUrl(item.imageUrl),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                homeBlocProvider.playAudio(item.musicLink);
              },
              child: Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(snapshot.data.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: item.time,
                          color: AppColors.white,
                          fontSize: 18,
                          fontFamily: AppFonts.raglika,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          maxLines: 2,
                          height: 22.6 / 16,
                          textAlign: TextAlign.left,
                        ),
                        context.sizeBoxHeight(0.007),
                        CustomText(
                          text: item.exercises,
                          color: AppColors.white,
                          fontSize: 14,
                          fontFamily: AppFonts.raglika,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          maxLines: 2,
                          height: 14.75 / 12,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: SizedBox());
          return Container(
            height: height * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black),
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1415383474815-00dea34b4fd9?q=80&w=2075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: item.time,
                      color: AppColors.white,
                      fontSize: 18,
                      fontFamily: AppFonts.raglika,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      maxLines: 2,
                      height: 22.6 / 16,
                      textAlign: TextAlign.left,
                    ),
                    context.sizeBoxHeight(0.007),
                    CustomText(
                      text: item.exercises,
                      color: AppColors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.raglika,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      maxLines: 2,
                      height: 14.75 / 12,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
