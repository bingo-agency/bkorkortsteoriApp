import 'package:bingo_project/screens/bottomNavigationBar/custom_bottom_navigation_bar.dart';
import 'package:bingo_project/screens/driving/driving_screen.dart';
import 'package:bingo_project/screens/forget/ui/forget_screen.dart';
import 'package:bingo_project/screens/language_select/select_primary_language_screen.dart';
import 'package:bingo_project/screens/language_select/select_secondary_language.dart';
import 'package:bingo_project/screens/login/login_screen.dart';
import 'package:bingo_project/screens/questions_page/questions.dart';
import 'package:bingo_project/screens/signup/ui/sign_up_sceen.dart';
import 'package:bingo_project/screens/theory_page/step_by_step_flow_screen.dart';
import 'package:bingo_project/screens/theory_page/topic_description.dart';
import 'package:get/get.dart';

class Routes {
  static String signupScreen = '/signupScreen';
  static String loginScreen = '/loginScreen';
  static String forgotScreen = '/forgotScreen';
  static String splashScreen = '/';
  static String bottomNavigationScreen = '/bottomNavigationScreen';
  static String stepByStopFlowScreen = '/stepByStopFlowScreen';
  static String drivingScreen = '/drivingScreen';
  static String onPrimaryLanguageSelectScreen = '/onPrimaryLanguageSelectScreen';
  static String onSecondaryLanguageSelectScreen = '/onSecondaryLanguageSelectScreen';
  static String getTopicDescriptionById = '/getTopicDescriptionById';
  static String getTopicQuestionsById = '/getTopicQuestionsById';
}

final getpage = [
  GetPage(
    name: Routes.bottomNavigationScreen,
    page: () => CustomBottomNavigationBar(),
  ),
  GetPage(
    name: Routes.stepByStopFlowScreen,
    page: () => StepByStepFlow(),
  ),
  GetPage(
    name: Routes.loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: Routes.signupScreen,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: Routes.forgotScreen,
    page: () => const ForgetScreen(),
  ),
  GetPage(
    name: Routes.drivingScreen,
    page: () => const DrivingScreen(),
  ),
  GetPage(name: Routes.onPrimaryLanguageSelectScreen, page: () => const LanguageSelect()),
  GetPage(
      name: Routes.onSecondaryLanguageSelectScreen,
      page: () => SecondaryLanguageSelect(
            langIndex: Get.arguments,
          )),
  GetPage(
    name: Routes.getTopicDescriptionById,
    page: () => TopicDescriptionFlow(
      topicId: (Get.arguments as Map)['index'],
      topicName: (Get.arguments as Map)['topicName'],
    ),
  ),
  GetPage(name: Routes.getTopicQuestionsById, page: () => QuestionsScreen(topicId: Get.arguments))
];