import 'dart:ui';

import 'package:breathin_app/screens/auth/login/model/user_model.dart';
import 'package:breathin_app/screens/language/bloc/language_bloc.dart';
import 'package:breathin_app/utilities/extensions/size_extensions.dart';
import 'package:breathin_app/utilities/helpers/app_assets.dart';
import 'package:breathin_app/utilities/helpers/app_fonts.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:breathin_app/widgets/custom_divider.dart';
import 'package:breathin_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/routes.dart';
import '../../../../utilities/helpers/colors.dart';
import '../../../../utilities/helpers/validation.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_snackBar.dart';
import '../../../../widgets/custom_text_field.dart';
import '../bloc/login_bloc.dart';
import '../cubits/terms_cubit.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key, required this.language});
  final String language;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authBlocProvider = BlocProvider.of<AuthBloc>(context);

    ///========= [Responsive Screen Size]
    screenSize = MediaQuery.sizeOf(context);
    final width = screenSize.width;
    final height = screenSize.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.homeBg),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                color: AppColors.halfWhite
                    .withOpacity(0.3), // Optional overlay color

                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07,
                      right: width * 0.07,
                      top: height * 0.04,
                      bottom: height * 0.1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        context.sizeBoxHeight(0.04),
                        const CustomText(
                          text: 'Welcome to Breathin',
                          color: AppColors.white,
                          fontSize: 24.5,
                          fontFamily: AppFonts.raglika,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.5,
                          maxLines: 3,
                          height: 34.4 / 24,
                          // Line height (34.4px) divided by font size (24px)

                          textAlign: TextAlign.left,
                        ),
                        context.sizeBoxHeight(0.01),
                        const CustomText(
                          text: 'Please enter your details to continue.',
                          color: AppColors.white8,
                          fontSize: 16,
                          fontFamily: AppFonts.helvetica,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          maxLines: 3,
                          height: 25.65 / 16,
                          textAlign: TextAlign.left,
                        ),
                        context.sizeBoxHeight(0.06),
                        _authFormWidget(
                            authBlocProvider, height, width, context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  /// FORM WIDGET
  Widget _authFormWidget(AuthBloc authBlocProvider, double height, double width,
      BuildContext context) {
    return Form(
        key: authBlocProvider.authKey,
        child: Column(
          children: [
            CustomTextField(
              textFieldHeading: 'Email',
              horizontalPadding: 0,
              hintText: 'example@gmail.com',
              controller: authBlocProvider.emailController,
              validator: (value) => isValidEmail(value),
              verticalFieldPadding: 0,
              contentPadding: 20,
              fillColor: AppColors.white20,
              filled: true,
            ),
            context.sizeBoxHeight(0.02),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return CustomTextField(
                  textFieldHeading: 'Password',
                  horizontalPadding: 0,
                  hintText: 'must be 8 characters',
                  obscureText: state is PasswordHidden,
                  controller: authBlocProvider.passwordController,
                  validator: (value) => isValidPassword(value),
                  verticalFieldPadding: 0,
                  contentPadding: 20,
                  fillColor: AppColors.white20,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state is PasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.darkGrey60,
                    ),
                    onPressed: () {
                      authBlocProvider.togglePasswordVisibility();
                    },
                  ),
                );
              },
            ),
            context.sizeBoxHeight(0.02),
            const Align(
              alignment: Alignment.topRight,
              child: CustomText(
                text: 'Forgot Password?',
                color: AppColors.black,
                fontSize: 15.5,
                fontFamily: AppFonts.helvetica,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                maxLines: 3,
                height: 16.1 / 14.0,
                textAlign: TextAlign.right,
              ),
            ),

            /// Terms and Conditions
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.03, bottom: height * 0.008),
              child: Row(
                children: [
                  BlocBuilder<TermsCubit, bool>(
                    builder: (context, isChecked) {
                      return Transform.scale(
                        scale:
                            1.2, // Increase this value to enlarge the checkbox
                        child: Checkbox(
                          shape: const CircleBorder(
                            // Set the shape to circle
                            side: BorderSide(
                              color: AppColors.black,
                            ),
                          ),
                          checkColor: AppColors.white,
                          // White check/tick color

                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.black; // Black fill when checked
                            }
                            return AppColors
                                .white20; // White fill when unchecked
                          }),
                          value: isChecked,
                          onChanged: (value) {
                            context.read<TermsCubit>().toggleTerms();
                          },
                        ),
                      );
                    },
                  ),
                  const CustomText(
                    text: 'I accept the terms and privacy policy',
                    color: AppColors.black,
                    fontSize: 15.5,
                    fontFamily: AppFonts.helvetica,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                    height: 16.1 / 14.0,
                    // Line height (16.1px divided by 14px gives the line-height multiplier)
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),

            /// Continue Button
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                /// Success state
                if (state is AuthSuccessState) {
                  CustomSnackBar.show(context,
                      message: state.successMessage, isError: false);
                }

                /// Error state
                else if (state is AuthFailureState) {
                  CustomSnackBar.show(context,
                      message: state.error, isError: true);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  btnName: 'Continue',
                  textStyle: const TextStyle(
                      color: AppColors.black,
                      fontFamily: AppFonts.helvetica,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                  btnColor: AppColors.buttonColor,
                  onTap: () {
                    /// USER
                    final user = UserModel(
                      email: authBlocProvider.emailController.text,
                      password: authBlocProvider.passwordController.text,
                      language: widget.language,
                    );
                    authBlocProvider.add(AuthSubmittedEvent(
                        user: user,
                        context: context,
                        isTermsAndConditionAccepted:
                            (context.read<TermsCubit>().state)));
                  },
                  btnRadius: 14,
                );
              },
            ),
            context.sizeBoxHeight(0.07),
            Row(
              children: [
                Expanded(child: CustomDivider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: const CustomText(
                    text: ' or ',
                    color: AppColors.white,
                    fontSize: 16.5,
                    fontFamily: AppFonts.helvetica,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                    height: 16.1 / 14.0,
                    // Line height (16.1px divided by 14px gives the line-height multiplier)

                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: CustomDivider()),
              ],
            ),

            /// Social Buttons
            _socialButton(),
          ],
        ));
  }

  /// SOCIAL BUTTONS WIDGET
  Widget _socialButton() {
    return Column(
      children: [
        context.sizeBoxHeight(0.02),
        CustomButton(
          btnName: 'Sign in with Google',
          btnBoxBorder: Border.all(color: AppColors.black, width: 1),
          textStyle: const TextStyle(
              color: AppColors.black,
              fontFamily: AppFonts.helvetica,
              fontSize: 16,
              height: 16.1 / 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.4),
          prefixIcon: AppAssets.google,
          isPrefixIcon: true,
          btnColor: AppColors.halfWhite,
          onTap: () {
            context.goNamed(Routes.login);
          },
          btnRadius: 14,
        ),
        context.sizeBoxHeight(0.02),
        CustomButton(
          btnName: 'Sign in with Google',
          btnBoxBorder: Border.all(color: AppColors.black, width: 1),
          textStyle: const TextStyle(
              color: AppColors.black,
              fontFamily: AppFonts.helvetica,
              fontSize: 16,
              height: 16.1 / 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.4),
          prefixIcon: AppAssets.apple,
          isPrefixIcon: true,
          btnColor: AppColors.halfWhite,
          onTap: () {
            context.goNamed(Routes.login);
          },
          btnRadius: 14,
        ),
      ],
    );
  }
}
