import 'package:bingo_project/AppConstData/extension.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/theming/style.dart';
import 'package:flutter/material.dart';



class DoNotHaveAccountText extends StatelessWidget {
  const DoNotHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.signupScreen);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account yet?',
              style: TextStyles.font11DarkBlue400Weight,
            ),
            TextSpan(
              text: ' Sign Up',
              style: TextStyles.font11Blue600Weight,
            ),
          ],
        ),
      ),
    );
  }
}