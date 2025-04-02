import 'package:bingo_project/AppConstData/extension.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/theming/style.dart';
import 'package:flutter/material.dart';



class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamedAndRemoveUntil(
          Routes.loginScreen,
          predicate: (route) => false,
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account?',
              style: TextStyles.font11DarkBlue400Weight,
            ),
            TextSpan(
              text: ' Login',
              style: TextStyles.font11Blue600Weight,
            ),
          ],
        ),
      ),
    );
  }
}
