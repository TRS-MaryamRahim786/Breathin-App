import 'package:breathin_app/routes/routes.dart';
import 'package:breathin_app/services/firebase/firebase_auth.dart';
import 'package:breathin_app/services/firebase/firestore_base_service.dart';
import 'package:breathin_app/services/shared-pref/shared-pref-service.dart';
import 'package:breathin_app/widgets/custom_snackBar.dart';
import 'package:breathin_app/widgets/no_internet_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// =============== [Text Editing Controllers]
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  /// =============== [Form Key]
  GlobalKey<FormState> authKey = GlobalKey<FormState>();

  final FirebaseAuthService authService;
  // final FirestoreService? fireStoreService;

  /// Password Toggle
  void togglePasswordVisibility() {
    if (state is PasswordVisible) {
      emit(PasswordHidden());
    } else {
      emit(PasswordVisible());
    }
  }

  AuthBloc({required this.authService}) : super(AuthInitialState()) {
    on<AuthSubmittedEvent>((event, emit) async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (authKey.currentState!.validate()) {
        if (event.isTermsAndConditionAccepted) {
          if (connectivityResult != ConnectivityResult.none) {
            try {
              // Check if user is registered

              bool isRegistered =
                  await authService.isUserRegistered(event.user.email);

              if (isRegistered) {
                // Login the user
                await authService.loginUser(event.user);
              } else {
                // Register the user
                await authService.registerUser(event.user);
              }
              if (event.context.mounted) {
                SharedPrefService.instance.setIsUserLogin(true);
                _navigateToHome(event.context);
              }
            } catch (e) {
              print("e: $e");
              SharedPrefService.instance.setIsUserLogin(false);
              emit(AuthFailureState(error: e.toString()));
            }
          } else {
            if (event.context.mounted) {
              showNoInternetDialog(event.context);
            }
          }
        } else {
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
}
