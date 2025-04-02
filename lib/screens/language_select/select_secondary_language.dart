import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/configurations/setLanguage.dart';
import 'package:bingo_project/screens/language_select/primary_langugage_controller.dart';
import 'package:bingo_project/sharedPrefrences/shared_prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/widgets/widget.dart';

class SecondaryLanguageSelect extends StatefulWidget {
  final int langIndex;

  const SecondaryLanguageSelect({super.key, required this.langIndex});

  @override
  State<SecondaryLanguageSelect> createState() =>
      _SecondaryLanguageSelectState();
}

class _SecondaryLanguageSelectState extends State<SecondaryLanguageSelect> {
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
                    "Select your secondary language".tr,
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
                        SharedPreference.saveIsOnboarding(true);

                        Get.offAllNamed(Routes.bottomNavigationScreen);
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildLanguageOptions() {
    final languages = [
      {
        "assetPath": "assets/logo/arabic.jpg",
        "language": "العربية".tr, // Arabic
        "locale": const Locale('ar', 'ar'),
        "index": 1,
      },
      {
        "assetPath": "assets/logo/043-liberia.png",
        "language": "English".tr, // English
        "locale": const Locale('en', 'US'),
        "index": 0,
      },
      {
        "assetPath": "assets/logo/urdu2.jpg",
        "language": "Urdu".tr, // Urdu
        "locale": const Locale('ur', 'ar'),
        "index": 2,
      },
      {
        "assetPath": "assets/logo/afrikaans.png",
        "language": "Afrikaans".tr, // Afrikaans
        "locale": const Locale('af', 'ge'),
        "index": 3,
      },
      {
        "assetPath": "assets/logo/belarusian.png",
        "language": "Belarusian".tr, // Belarusian
        "locale": const Locale('be', 'ge'),
        "index": 4,
      },
      {
        "assetPath": "assets/logo/spanish.png",
        "language": "Spanish".tr, // Spanish
        "locale":  const Locale('sp', 'GE'),
        "index": 5,
      },
      {
        "assetPath": "assets/logo/hindi.png",
        "language": "Hindi".tr, // Hindi
        "locale": const Locale('hi', 'IN'),
        "index": 6,
      },
      {
        "assetPath": "assets/logo/german.png",
        "language": "German".tr, // German
        "locale":  const Locale('ge', 'In'),
        "index": 7,
      },
      {
        "assetPath": "assets/logo/indonesian.png",
        "language": "Indonesian".tr, // Indonesian
        "locale": const Locale('Id', 'Ge'),
        "index": 8,
      },
    ];

    // Filter out the language matching the primary screen's langIndex
    final filteredLanguages =
        languages.where((lang) => lang['index'] != widget.langIndex).toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredLanguages.length,
      itemBuilder: (context, index) {
        final lang = filteredLanguages[index];

        // Explicitly cast the values to String
        final assetPath = lang['assetPath'] as String;
        final language = lang['language'] as String;
        final locale = lang['locale'] as Locale;
        final indexValue = lang['index'] as int;

        return Column(
          children: [
            _languageOption(
              assetPath: assetPath,
              language: language,
              locale: locale,
              isSelected:
                  onSelectedLanguageController.selectedLanguage == indexValue,
              onTap: () {
                _selectLanguage(indexValue, locale);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  void _selectLanguage(int index, Locale locale) {
    Get.updateLocale(locale);
    localeModel?.setPrimaryLocale(locale);
    SharedPreference.saveSecondaryLanguage(locale.languageCode);
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
