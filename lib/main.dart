import 'package:bingo_project/AppConstData/app_translation_file.dart';
import 'package:bingo_project/configurations/setLanguage.dart';
import 'package:bingo_project/screens/bottomNavigationBar/custom_bottom_navigation_bar.dart';
import 'package:bingo_project/screens/home_screen/home_screen.dart';
import 'package:bingo_project/screens/language_select/select_primary_language_screen.dart';
import 'package:bingo_project/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppConstData/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Preload any assets like SVGs
  await Future.wait([
    preloadSVGs(['assets/svgs/google_logo.svg']),
  ]);

  // Initialize ScreenUtil for sizing purposes
  await ScreenUtil.ensureScreenSize();
  await Get.putAsync(() async => LocaleController());

  // Get shared preferences
  final localeLanuage = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: localeLanuage,
  ));
}

Future<void> preloadSVGs(List<String> paths) async {
  for (final path in paths) {
    final loader = SvgAssetLoader(path);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences _localeLanuage;

  const MyApp({Key? key, required SharedPreferences prefs})
      : _localeLanuage = prefs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(_localeLanuage),
      child: Consumer<LocaleModel>(builder: (context, localeModel, child) {
        return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: (_, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'bkörkortsteori',
                getPages: getpage,
                locale: localeModel.primaryLocale,
                initialRoute: Routes.splashScreen,
                translations: AppTranslations(),
                theme: ThemeData(
                    useMaterial3: true,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    fontFamily: "Poppins",
                    primaryColor: const Color(0xff1347FF),
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      primary: const Color(0xff194BFB),
                    )),
                home: const SplashScreen(),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
              );
            });
      }),
    );
  }
}
