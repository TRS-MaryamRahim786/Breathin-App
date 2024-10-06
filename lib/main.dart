import 'dart:developer';

import 'package:breathin_app/firebase_options.dart';
import 'package:breathin_app/lang/codegen_loader.g.dart';
import 'package:breathin_app/services/shared-pref/shared-pref-service.dart';
import 'package:breathin_app/utilities/helpers/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }

    // Configure Firebase Crashlytics and Analytics
    // configureFirebaseServices();
  } catch (e) {
    log(
      "Failed to initialize Firebase: $e",
    );
  }

  runApp(EasyLocalization(
    path: 'assets/lang',
    supportedLocales: const [
      Locale(ENGLISH_LANGUAGE_KEY),
      Locale(DANISH_LANGUAGE_KEY),
    ],
    fallbackLocale: const Locale(ENGLISH_LANGUAGE_KEY),
    assetLoader: const CodegenLoader(),
    child: const App(),
  ));
}
