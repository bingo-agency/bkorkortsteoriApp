import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/configurations/setLanguage.dart';
import 'package:bingo_project/screens/language_select/primary_langugage_controller.dart';
import 'package:bingo_project/screens/language_select/secondary_langugage_controller.dart';
import 'package:bingo_project/sharedPrefrences/shared_prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/widgets/widget.dart';

class LanguageSelect extends StatefulWidget {
  const LanguageSelect({super.key});

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  LocaleModel? localeModel;
  final PrimaryLanguageController onSelectedLanguageController =
      Get.put(PrimaryLanguageController());

  @override
  void initState() {
    super.initState();
    _loadLocaleModel();
  }

  Future<void> _loadLocaleModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localeModel = LocaleModel(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: localeModel == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "Select your primary language".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "urbani_extrabold",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: _buildLanguageOptions()),
                  Container(
                    width: Get.width,
                    child: commonButton(
                      textcolor: textBlackColor,
                      title: "Continue".tr,
                      onTapp: () {
                        Get.offAllNamed(Routes.onSecondaryLanguageSelectScreen,
                            arguments:
                                onSelectedLanguageController.selectedLanguage);
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildLanguageOptions() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        _languageOption(
          assetPath: "assets/logo/arabic.jpg",
          language: "العربية".tr,
          // Arabic
          locale: const Locale('ar', 'ar'),
          isSelected: onSelectedLanguageController.selectedLanguage == 1,
          onTap: () {
            _selectLanguage(1, const Locale('ar', 'ar'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/043-liberia.png",
          language: "English".tr,
          // English
          locale: const Locale('en', 'US'),
          isSelected: onSelectedLanguageController.selectedLanguage == 0,
          onTap: () {
            _selectLanguage(0, const Locale('en', 'US'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/urdu2.jpg",
          language: "Urdu".tr,
          // Urdu
          locale: const Locale('ur', 'ar'),
          isSelected: onSelectedLanguageController.selectedLanguage == 2,
          onTap: () {
            _selectLanguage(2, const Locale('ur', 'ar'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/afrikaans.png",
          language: "Afrikaans".tr,
          // Afrikaans
          locale: const Locale('af', 'ge'),
          isSelected: onSelectedLanguageController.selectedLanguage == 3,
          onTap: () {
            _selectLanguage(3, const Locale('af', 'ge'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/belarusian.png",
          language: "Belarusian".tr,
          // Belarusian
          locale: const Locale('be', 'ge'),
          isSelected: onSelectedLanguageController.selectedLanguage == 4,
          onTap: () {
            _selectLanguage(4, const Locale('be', 'ge'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/spanish.png",
          language: "Spanish".tr,
          // Spanish
          locale: const Locale('sp', 'GE'),
          isSelected: onSelectedLanguageController.selectedLanguage == 5,
          onTap: () {
            _selectLanguage(5, const Locale('sp', 'GE'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/hindi.png",
          language: "Hindi".tr,
          // Hindi
          locale: const Locale('hi', 'IN'),
          isSelected: onSelectedLanguageController.selectedLanguage == 6,
          onTap: () {
            _selectLanguage(6, const Locale('hi', 'IN'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/german.png",
          language: "German".tr,
          // German
          locale: const Locale('ge', 'In'),
          isSelected: onSelectedLanguageController.selectedLanguage == 7,
          onTap: () {
            _selectLanguage(7, const Locale('ge', 'In'));
          },
        ),
        const SizedBox(height: 20),
        _languageOption(
          assetPath: "assets/logo/indonesian.png",
          language: "Indonesian".tr,
          // Indonesian
          locale: const Locale('Id', 'Ge'),
          isSelected: onSelectedLanguageController.selectedLanguage == 8,
          onTap: () {
            _selectLanguage(8, const Locale('Id', 'Ge'));
          },
        ),
      ],
    );
  }

  void _selectLanguage(int index, Locale locale) {
    Get.updateLocale(locale);
    localeModel?.setPrimaryLocale(locale);
    SharedPreference.savePrimaryLanguage(locale.languageCode);
    onSelectedLanguageController.setSelectedLanguage(index);
  }

  Widget _languageOption({
    required String assetPath,
    required String language,
    required Locale locale,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: primary2),
          color: isSelected ? primary2 : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(assetPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  language,
                  style: TextStyle(
                    fontFamily: "urbani_extrabold",
                    fontSize: 16,
                    color: textBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
