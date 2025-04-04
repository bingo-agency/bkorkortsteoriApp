import 'package:bingo_project/AppConstData/app_prefrences.dart';
import 'package:bingo_project/AppConstData/helper_function.dart';
import 'package:bingo_project/configurations/setLanguage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: customAppBar(
        title: 'Bkrkortsteori',
        titleColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildHighlightedContainer(
                imagePath: "assets/images/theory.png",
                title: "Theory",
                description: "Master driving rules, ace your test",
              ),
              const SizedBox(height: 10),
              _buildCard(
                context,
                title: "Theory Learning",
                description: "Essential lessons for driving success".tr,
                subDescription: getTextIntoSecondaryLanguage(
                    "Essential lessons for driving success"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distributes space properly
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Theory Quiz', style: TextStyle(fontSize: 32)),
                          Icon(
                            FeatherIcons.arrowRightCircle,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 180, // Adjust width as needed
                      height: 180, // Optional, if needed
                      child: Image.asset(
                        'assets/images/theoryTestIllustration.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildCard(
                context,
                title: "Learning Progress",
                description: "Weekly Report, 12 December - 18 December",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Weekly Progress",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildProgressBar(context, [0.45, 0.25, 0.30]),
                    const SizedBox(height: 10),
                    const Text(
                      "Average Progress",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildProgressBarWithoutPercentage(
                        context, [0.45, 0.25, 0.30]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightedContainer({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue,
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    String? description,
    String? subDescription,
    required Widget child,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 2),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
          if (subDescription != null) ...[
            const SizedBox(height: 2),
            Text(
              subDescription,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final categories = [
      "Introduction Course",
      "Risk Training 1",
      "Risk Training 2",
      "Theory & Driving Test",
    ];
    final imageList = [
      "assets/images/introduction.png",
      "assets/images/vlc.png",
      "assets/images/risk_training.png",
      "assets/images/training_test.png",
    ];
    final boxColor = [
      const Color(0xffFEF2D3),
      const Color(0xffD3FED7),
      const Color(0xffD3E3FE),
      const Color(0xffFED3D4),
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: boxColor[index],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageList[index],
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  categories[index],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressBar(BuildContext context, List<double> percentages) {
    final colors = [
      const Color(0xff46DEAF),
      const Color(0xffFFCE6E),
      const Color(0xffEEEEEE),
    ];

    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: percentages.asMap().entries.map((entry) {
          final index = entry.key;
          final percentage = entry.value;
          return Container(
            width: (MediaQuery.of(context).size.width - 48) * percentage,
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: index == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )
                  : index == percentages.length - 1
                      ? const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      : null,
            ),
            alignment: Alignment.center,
            child: Text(
              "${(percentage * 100).round()}%",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgressBarWithoutPercentage(
      BuildContext context, List<double> percentages) {
    final colors = [
      const Color(0xff46DEAF),
      const Color(0xffFFCE6E),
      const Color(0xffEEEEEE),
    ];

    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: percentages.asMap().entries.map((entry) {
          final index = entry.key;
          final percentage = entry.value;
          return Container(
            width: (MediaQuery.of(context).size.width - 48) * percentage,
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: index == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )
                  : index == percentages.length - 1
                      ? const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      : null,
            ),
          );
        }).toList(),
      ),
    );
  }

  String getTextIntoSecondaryLanguage(String text) {
    // Ensure that LocaleController is initialized.
    final localeController = Get.find<LocaleController>();

    // Temporarily set the locale for translation
    Locale secondaryLocale = Locale(
        localeController.secondaryLocale.languageCode,
        localeController.secondaryLocale.countryCode);

    // Save the current locale
    Locale? currentLocale = Get.locale;

    // Set the locale to the secondary locale temporarily
    Get.locale = secondaryLocale;

    // Get the translation for the secondary locale
    String translatedText = text.tr;

    // Restore the original locale
    Get.locale = currentLocale;

    return translatedText;
  }
}

class LocaleController extends GetxController {
  late LocaleModel localeModel;

  @override
  void onInit() {
    super.onInit();
    _initializeLocale();
  }

  _initializeLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    localeModel = LocaleModel(prefs);
    update(); //
  }

  Locale get secondaryLocale =>
      localeModel.secondaryLocale ?? Locale('es', 'ES');
}
