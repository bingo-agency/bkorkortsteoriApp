import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:flutter/material.dart';


class ProgressIndicaror {
  static showProgressIndicator(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: ColorsManager.mainBlue,
          ),
        );
      },
    );
  }
}
