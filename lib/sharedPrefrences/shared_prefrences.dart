import 'dart:convert';
import 'dart:ffi';

import 'package:bingo_project/AppConstData/app_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static String kPrimaryLanguageKey = 'primaryLanguageKey';
  static String kSecondaryLanguageKey = 'secondaryLanguageKey';
  static String kIsOnboardingKey = 'IsOnboarding';

  static Future<bool> saveIsOnboarding(bool IsOnboarding) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(kIsOnboardingKey, IsOnboarding);
  }

  static Future<Future<bool>> removeIsOnboardingFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.remove(kIsOnboardingKey);
  }

  static Future<bool?> getIsOnboardingFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(kIsOnboardingKey);
  }

  static Future<bool> savePrimaryLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppPrefrences.primaryLanguageCode = languageCode;
    return prefs.setString(kPrimaryLanguageKey, languageCode);
  }

  static Future<Future<bool>> removePrimaryFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.remove(kPrimaryLanguageKey);
  }

  static Future<String?> getPrimaryFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(kPrimaryLanguageKey);
  }

  static Future<bool> saveSecondaryLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppPrefrences.primaryLanguageCode = languageCode;
    return prefs.setString(kSecondaryLanguageKey, languageCode);
  }

  static Future<Future<bool>> removeSecondaryFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.remove(kSecondaryLanguageKey);
  }

  static Future<String?> getSecondaryFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(kSecondaryLanguageKey);
  }
}
