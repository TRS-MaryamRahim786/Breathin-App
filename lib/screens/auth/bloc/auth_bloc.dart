import 'package:breathin_app/routes/routes.dart';
import 'package:breathin_app/services/firebase/firebase_auth.dart';
import 'package:breathin_app/services/shared-pref/shared-pref-service.dart';
import 'package:breathin_app/widgets/no_internet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../services/internet_connectivity/internet_connectivity.dart';
import '../model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// =============== [Text Editing Controllers]
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  /// =============== [Form Key]
  GlobalKey<FormState> authKey = GlobalKey<FormState>();

  final FirebaseAuthService authService;

  /// =========================== [ Password Toggle ]
  void togglePasswordVisibility() {
    if (state is PasswordVisible) {
      emit(PasswordHidden());
    } else {
      emit(PasswordVisible());
    }
  }

  AuthBloc({required this.authService}) : super(AuthInitialState()) {
    on<AuthSubmittedEvent>((event, emit) async {
      if (authKey.currentState!.validate()) {
        if (event.isTermsAndConditionAccepted) {
          /// Check for actual internet availability
          bool hasInternet = await hasInternetConnection();
          if (hasInternet) {
            emit(AuthLoadingState());
            try {
              // Check if user is registered
              bool isRegistered =
                  await authService.isUserRegistered(event.user.email);

              if (isRegistered) {
                /// Login the user
                await authService.loginUser(event.user);
              } else {
                /// Register the user
                await authService.registerUser(event.user);
              }

              /// Navigate to Home Screen
              if (event.context.mounted) {
                _clearControllers();

                /// Handling Signed User Session
                SharedPrefService.instance.setIsUserLogin(true);
                emit(AuthSuccessState());
                _navigateToHome(event.context);
              }
            } catch (e) {
              SharedPrefService.instance.setIsUserLogin(false);
              emit(AuthFailureState(error: e.toString()));
            }
          } else {
            /// No Internet Widget
            if (event.context.mounted) {
              showNoInternetDialog(event.context);
            }
          }
        } else {
          /// Error State
          emit(AuthFailureState(
              error: 'Please accept the terms and conditions.'));
        }
      }
    });
  }

  /// NAVIGATE IT TO HOME SCREEN
  void _navigateToHome(BuildContext context) {
    context.pushReplacement(Routes.home);
  }

  /// CLEARING CONTROLLERS AFTER SUCCESS
  void _clearControllers() {
    emailController.clear();
    passwordController.clear();
  }
}
