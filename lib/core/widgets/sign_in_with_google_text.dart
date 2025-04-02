import 'package:bingo_project/AppConstData/build_devider.dart';
import 'package:bingo_project/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';



class SigninWithGoogleText extends StatelessWidget {
  const SigninWithGoogleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        BuildDivider.buildDivider(),
        Gap(5.w),
        Text(
          'or Sign in with',
          style: TextStyles.font13Grey400Weight,
        ),
        Gap(5.w),
        BuildDivider.buildDivider(),
      ],
    );
  }
}
