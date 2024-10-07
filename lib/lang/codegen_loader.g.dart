// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> da = {
    "title": "Başlık",
    "message": "Merhaba, Nasılsınız?",
    "skipProductEntryOver": "Spring produktindtastning over",
    "unknownError":
        "Ukendt fejl: Din anmodning kan ikke behandles i øjeblikket. Prøv venligst igen!",
    "badCertificateError": "Dårligt certifikat: Serverfejl!",
    "comment": "Kommentar",
    "enterCode": "Indtast kode",
    "codeIsRequired": "Kode er påkrævet."
  };

  /// ENGLISH KEYS
  static const Map<String, dynamic> en = {
    "title": "Title",
    "message": "Hello, How are you?",
    "skipProductEntryOver": "Skip Product Entry Over",
    "pleaseAgreeTheTermsAndConditionsToContinue":
        "Please agree the terms and conditions to continue.",
    "sessionExpired": "Session expired.",
    "connectionError":
        "Connection Error: Your request can not be proceeded at this time due to connection error!",
    "noInternetError":
        "Connection Error: Please checkout your internet connection or you may have poor internet access.",
    "unknownError":
        "unknown Error: Your request can not be proceeded at this time. Please try again!",
    "badCertificateError": "Bad Certificate: Server error!",
    "comment": "Comment",
    "enterCode": "Enter code",
    "codeIsRequired": "Code is required."
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "da": da,
    "en": en
  };
}
