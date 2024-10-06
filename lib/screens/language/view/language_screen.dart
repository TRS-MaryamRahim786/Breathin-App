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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../services/shared-pref/shared-pref-service.dart';
import '../model/language_model.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  get _focusBorder => const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor));

  get _border => const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.greyDivider, width: 1.5));

  @override
  Widget build(BuildContext context) {
    SharedPrefService.instance.getIsUserLogin().then((value) {
      if (value) {
        context.go(Routes.home);
      } else {
        context.go(Routes.login);
      }
    });
    final languageBlocProvider = BlocProvider.of<LanguageBloc>(context);
    languageBlocProvider.add(LanguageInitialEvent(
        defaultLanguage: languageBlocProvider.languages.first));

    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return Scaffold(
      appBar: AppBar(
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
              context.sizeBoxHeight(0.01),
              const CustomText(
                text:
                    'Please select your language, you can always change your preference in settings.',
                color: AppColors.grey157,
                fontSize: 16,
                fontFamily: AppFonts.helvetica,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                maxLines: 3,
                textAlign: TextAlign.left,
              ),
              context.sizeBoxHeight(0.02),
              TextFormField(
                focusNode: languageBlocProvider.focusNode,
                controller: languageBlocProvider.languageController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    languageBlocProvider.add(LanguageResetEvent());
                  }
                  if (value.length >= 2) {
                    languageBlocProvider
                        .add(LanguageSearchEvent(searchLanguage: value));
                  }
                },
                onFieldSubmitted: (value) {},
                decoration: InputDecoration(
                    enabledBorder: _border,
                    focusedBorder: _focusBorder,
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.greyDivider, width: 1)),
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        color: AppColors.black50, fontSize: 18.5),
                    prefixIcon: Container(
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
              ),
              context.sizeBoxHeight(0.03),
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
                              // return Text('index $index');
                              return GestureDetector(
                                onTap: () {
                                  languageBlocProvider.add(
                                      LanguageSelectionEvent(
                                          language: language));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: (languageBlocProvider
                                                      .selectedLanguage ==
                                                  language)
                                              ? AppColors.borderColor
                                              : AppColors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // color: AppColors.grey,
                                    child: ListTile(
                                        leading: Container(
                                          child: SvgPicture.asset(
                                            language.flag,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: CustomText(
                                          text: language.name,
                                          color: AppColors.black70,
                                          fontSize: 18,
                                          fontFamily: AppFonts.helvetica,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                        trailing: (languageBlocProvider
                                                    .selectedLanguage ==
                                                language)
                                            ? SizedBox(
                                                height: height * 0.06,
                                                child: SvgPicture.asset(
                                                  AppAssets.checkBox,
                                                  // fit: BoxFit.cover,
                                                ),
                                              )
                                            : const SizedBox())),
                              );
                            }),
                      );
                    }
                    return const Text('Something went wrong.');
                  },
                ),
              ),
              CustomButton(
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
              context.sizeBoxHeight(0.04)
            ],
          ),
        ),
      ),
    );
  }
}
