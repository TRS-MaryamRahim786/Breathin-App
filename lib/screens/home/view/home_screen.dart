import 'package:breathin_app/screens/home/bloc/home_bloc.dart';
import 'package:breathin_app/screens/home/home_widgets/exercise_card.dart';
import 'package:breathin_app/screens/home/home_widgets/favorite_card.dart';
import 'package:breathin_app/screens/home/home_widgets/feature_card.dart';
import 'package:breathin_app/screens/home/model/item_model.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/basic_circular_progress_indicator.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/exercise_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;

    /// =========================== [ HOME BLOC PROVIDER ]
    final homeBlocProvider = BlocProvider.of<HomeBloc>(context);
    return SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                  ),
                ),
              ),
              context.sizeBoxHeight(0.02),
              _favoriteView(homeBlocProvider, height, width),
              _featuredView(homeBlocProvider, height, width),
              _exerciseView(homeBlocProvider, height, width),
            ],
          ),
        );
      },
    ));
  }

  /// EXERCISE WIDGET
  Widget _exerciseView(HomeBloc homeBlocProvider, double height, double width) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('exercies').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        // Get the data from the snapshot
        final data = snapshot.data!.docs;

        List<FeaturedItem> list = [];
        for (var item in data) {
          final userData = item.data() as Map<String, dynamic>;

          var featureItem = FeaturedItem(
            name: userData['name'],
            duration: userData['duration'],
            type: userData['type'],
            imageLink: userData['imageLink'],
            musicLink: userData['link'],
            keyValue: '',
          );
          list.add(featureItem);
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final ExerciseItem exerciseItem = ExerciseItem(
                time: list[index].duration,
                exercises: list[index].type,
                imageUrl: list[index].imageLink,
                musicLink: list[index].musicLink);
            return ExerciseCard(
              item: exerciseItem,
              homeBlocProvider: homeBlocProvider,
            );
          },
        );
      },
    );
  }

  /// FEATURED WIDGET
  Widget _featuredView(HomeBloc homeBlocProvider, double height, double width) {
    return Column(
      children: [
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

        /// ============================= [ FEATURED LIST VIEW ]
        Padding(
          padding: EdgeInsets.only(top: height * 0.014, left: width * 0.04),
          child: SizedBox(
            height: height * 0.22, // Height of the horizontal list
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('feature').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                }

                // Get the data from the snapshot
                final data = snapshot.data!.docs;

                List<FeaturedItem> list = [];
                for (var item in data) {
                  final userData = item.data() as Map<String, dynamic>;

                  var featureItem = FeaturedItem(
                      name: userData['name'],
                      duration: userData['duration'],
                      type: userData['type'],
                      imageLink: userData['imageLink'],
                      musicLink: userData['link'],
                      keyValue: userData['keyValue'],
                      isFavorite: userData['isFavorite']);
                  list.add(featureItem);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.02, bottom: height * 0.001),
                      child: FeaturedCard(
                        item: list[index],
                        onFavoriteToggle: () {
                          FirebaseFirestore.instance
                              .collection('feature')
                              .doc(list[index].keyValue)
                              .update({
                            'isFavorite': !list[index].isFavorite,
                          });
                        },
                        homeBlocProvider: homeBlocProvider,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// FAVORITE WIDGET
  Widget _favoriteView(HomeBloc homeBlocProvider, double height, double width) {
    return Column(
      children: [
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

        /// ============================= [ FAVOURITE LIST VIEW ]
        Padding(
          padding: EdgeInsets.only(top: height * 0.014, left: width * 0.04),
          child: SizedBox(
            height: height * 0.21,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('favorite').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: BasicCircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                }

                // Get the data from the snapshot
                final data = snapshot.data!.docs;

                List<FeaturedItem> list = [];
                for (var item in data) {
                  final userData = item.data() as Map<String, dynamic>;

                  var featureItem = FeaturedItem(
                      name: userData['name'],
                      duration: userData['duration'],
                      type: userData['type'],
                      imageLink: userData['imageLink'],
                      musicLink: userData['link'],
                      keyValue: userData['keyValue'],
                      isFavorite: userData['isFavorite']);
                  list.add(featureItem);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.02, bottom: height * 0.001),
                      child: FavoriteCard(
                        item: list[index],
                        onFavoriteToggle: () {
                          FirebaseFirestore.instance
                              .collection('favorite')
                              .doc(list[index].keyValue)
                              .update({
                            'isFavorite': !list[index].isFavorite,
                          });
                        },
                        homeBlocProvider: homeBlocProvider,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
