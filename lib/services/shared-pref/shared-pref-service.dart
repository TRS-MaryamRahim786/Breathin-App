import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService instance = SharedPrefService._internal();

  SharedPrefService._internal();
  static SharedPreferences? sharedInstance;

  Future<SharedPreferences> get database async {
    if (sharedInstance != null) return sharedInstance!;
    sharedInstance = await init();
    return sharedInstance!;
  }

  /// SHARED PREF KEYS
  static String isLogin = "isLogin";

  Future init() async {
    sharedInstance ??= await SharedPreferences.getInstance();
    return sharedInstance;
  }

  setIsUserLogin(bool isLogin) async {
    final instance = await SharedPrefService.instance.database;
    await instance.setBool(SharedPrefService.isLogin, isLogin);
  }

  Future<bool> getIsUserLogin() async {
    final instance = await SharedPrefService.instance.database;

    bool? isUserLogin = instance.getBool(SharedPrefService.isLogin);
    return isUserLogin ?? false;
  }
}
