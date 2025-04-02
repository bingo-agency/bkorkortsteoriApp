import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/AppConstData/rive_controller.dart';
import 'package:bingo_project/core/widgets/login_and_signup_animated_form.dart';
import 'package:bingo_project/core/widgets/no_internet.dart';
import 'package:bingo_project/core/widgets/sign_in_with_google_text.dart';
import 'package:bingo_project/core/widgets/terms_and_conditions_text.dart';
import 'package:bingo_project/screens/login/widgets/do_not_have_an_account.dart';
import 'package:bingo_project/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final RiveAnimationControllerHelper riveHelper =
      RiveAnimationControllerHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? _loginPage(context) : const BuildNoInternet();
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: ColorsManager.mainBlue,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  SafeArea _loginPage(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
                left: 30.w, right: 30.w, bottom: 15.h, top: 30.h),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyles.font24Blue700Weight,
                      ),
                      Gap(10.h),
                      Text(
                        "Login To Continue Using The App",
                        style: TextStyles.font14Grey400Weight,
                      ),
                    ],
                  ),
                ),
                Text('EmailAndPassword()'),
                // EmailAndPassword(),
                Gap(10.h),
              ],
            ))));
  }
}
