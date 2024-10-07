import 'dart:ui';

import 'package:breathin_app/Utilities/helpers/app_colors.dart';
import 'package:breathin_app/routes/routes.dart';
import 'package:breathin_app/screens/language/bloc/language_bloc.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/app_assets.dart';
import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/custom_button.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../model/language_model.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  get _focusBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.borderColor),
      borderRadius: BorderRadius.circular(10));

  get _border => OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.greyDivider, width: 1.5),
      borderRadius: BorderRadius.circular(10));

  @override
  Widget build(BuildContext context) {
    final languageBlocProvider = BlocProvider.of<LanguageBloc>(context);
    languageBlocProvider.add(LanguageInitialEvent(
        defaultLanguage: languageBlocProvider.languages.first));

    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        toolbarHeight: DEFAULT_TOOLBAR_HEIGHT,
        leadingWidth: width * 0.2,
        leading: Center(
          child: SizedBox(
            height: height * 0.1,
            width: width * 0.1,
            child: IconButton(
                splashRadius: 1,
                focusColor: AppColors.white,
                hoverColor: AppColors.white,
                highlightColor: AppColors.white,
                splashColor: AppColors.white,
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                padding: const EdgeInsets.all(0.1),
                icon: SvgPicture.asset(
                  AppAssets.back,
                  // fit: BoxFit.cover,
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.01, horizontal: width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _searchBarWidget(languageBlocProvider, height, width),
              context.sizeBoxHeight(0.03),

              /// Languages ListView Builder
              Expanded(
                child: BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                    if (state is LanguageUpdateState) {
                      return CupertinoScrollbar(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.updatedLanguages.length,
                            itemBuilder: (context, index) {
                              final LanguageModel language =
                                  state.updatedLanguages[index];
                              return _languageListTile(languageBlocProvider,
                                  height, width, language);
                            }),
                      );
                    }
                    return const Text('Something went wrong.');
                  },
                ),
              ),
              context.sizeBoxHeight(0.04)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.03, horizontal: width * 0.07),
        child: CustomButton(
          btnName: 'Continue',
          textStyle: const TextStyle(
              color: AppColors.black,
              fontFamily: AppFonts.helvetica,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 1),
          btnColor: AppColors.buttonColor,
          onTap: () {
            context.pushNamed(Routes.login,
                extra: languageBlocProvider.selectedLanguage?.name);
          },
          btnRadius: 14,
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Choose the language',
          color: AppColors.black,
          fontSize: 24.5,
          fontFamily: AppFonts.raglika,
          fontWeight: FontWeight.normal,
          letterSpacing: 1.5,
          maxLines: 3,
          textAlign: TextAlign.left,
        ),
        context.sizeBoxHeight(0.015),
        const CustomText(
          text:
              'Please select your language, you can always change your preference in settings.',
          color: AppColors.grey157,
          fontSize: 16,
          fontFamily: AppFonts.helvetica,
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          maxLines: 3,
          textAlign: TextAlign.left,
        ),
        context.sizeBoxHeight(0.02),
      ],
    );
  }

  /// SEARCH FIELD
  Widget _searchBarWidget(
      LanguageBloc languageBlocProvider, double height, double width) {
    return TextFormField(
      focusNode: languageBlocProvider.focusNode,
      controller: languageBlocProvider.languageController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          languageBlocProvider.add(LanguageResetEvent());
        }
        if (value.length >= 2) {
          languageBlocProvider.add(LanguageSearchEvent(searchLanguage: value));
        }
      },
      onFieldSubmitted: (value) {},
      decoration: InputDecoration(
          filled: true, // Enables the background color
          fillColor: AppColors.white,
          enabledBorder: _border,
          focusedBorder: _focusBorder,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyDivider, width: 1)),
          hintText: '  Search',
          hintStyle: const TextStyle(
              color: AppColors.black50,
              fontSize: 18.5,
              fontFamily: AppFonts.helvetica,
              fontWeight: FontWeight.w400),
          prefixIcon: Container(
            padding: EdgeInsets.only(left: width * 0.03),
            constraints: BoxConstraints(maxWidth: width * 0.02),
            // color: AppColors.primary,
            // height: height * 0.002,
            // width: width * 0.002,
            child: const Icon(
              Icons.search,
              color: AppColors.darkGrey60,
              size: 32,
            ),
          )),
    );
  }

  /// Language List tile widget
  Widget _languageListTile(LanguageBloc languageBlocProvider, double height,
      double width, LanguageModel language) {
    return GestureDetector(
      onTap: () {
        /// Adding event
        languageBlocProvider.add(LanguageSelectionEvent(language: language));
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: (languageBlocProvider.selectedLanguage == language)
                    ? AppColors.borderColor
                    : AppColors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          // color: AppColors.grey,
          child: ListTile(
              leading: Image.asset(
                language.flag, // Path to the image in assets folder
                width: width * 0.07,
                fit: BoxFit
                    .contain, // Adjust how the image fits in the container
              ),
              title: Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: CustomText(
                  text: language.name,
                  color: AppColors.black70,
                  fontSize: 18,
                  fontFamily: AppFonts.helvetica,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                ),
              ),
              trailing: (languageBlocProvider.selectedLanguage == language)
                  ? SizedBox(
                      height: height * 0.06,
                      child: SvgPicture.asset(
                        AppAssets.checkBox,
                        // fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox())),
    );
  }
}
