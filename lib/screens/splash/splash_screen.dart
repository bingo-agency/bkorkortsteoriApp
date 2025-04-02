import 'package:bingo_project/AppConstData/app_prefrences.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/configurations/setLanguage.dart';
import 'package:bingo_project/sharedPrefrences/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isOnBoarding;

  @override
  void initState() {
    super.initState();

    getDataFromLocal();
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (isOnBoarding == false) {
          Get.offAllNamed(Routes.onPrimaryLanguageSelectScreen);
        } else if (isOnBoarding != null && isOnBoarding != false) {
          Get.offAllNamed(Routes.bottomNavigationScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/images/B..png",
              height: 260,
              width: 260,
            )),
          ],
        ),
      ),
    );
  }

  Future getDataFromLocal() async {
    bool? primaryLanguage = await SharedPreference.getIsOnboardingFromSF();
    String? primaryLanguageCode = await SharedPreference.getPrimaryFromSF();
    String? secondaryLanguageCode = await SharedPreference.getSecondaryFromSF();

    if (primaryLanguageCode != null && secondaryLanguageCode != null) {
      // Update AppPrefrences with the fetched language codes.
      AppPrefrences.primaryLanguageCode = primaryLanguageCode;
      AppPrefrences.secondaryLanguageCode = secondaryLanguageCode;

      // Convert language codes to Locale objects
      Locale primaryLocale = Locale(
        primaryLanguageCode.split("_").first,
        primaryLanguageCode.split("_").last,
      );

      Locale secondaryLocale = Locale(
        secondaryLanguageCode.split("_").first,
        secondaryLanguageCode.split("_").last,
      );

      // Assuming you have a method to update LocaleModel
      SharedPreferences prefs = await SharedPreferences.getInstance();
      LocaleModel localeModel = LocaleModel(prefs);
      localeModel.setPrimaryLocale(primaryLocale);
      localeModel.setSecondaryLocale(secondaryLocale);
    }

    // Set onboarding state
    setState(() {
      isOnBoarding = primaryLanguage ?? false;
    });
  }
}
