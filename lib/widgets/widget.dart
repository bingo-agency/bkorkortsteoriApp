// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../AppConstData/app_colors.dart';

commonButton({required String title, required void Function() onTapp, Color? textcolor, bool? fill, Color? color}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          side: BorderSide(color: color != null ? color : Colors.transparent),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size.fromHeight(48),
          backgroundColor: fill == false ? Colors.white : primary2),
      onPressed: onTapp,
      child: Text(
        title.tr,
        style: TextStyle(color: textcolor, fontSize: 16, fontFamily: "urbani_extrabold", fontWeight: FontWeight.w700),
      ));
}

commonTextField({required TextEditingController controller, required String hintText, required TextInputType keyBordType, bool? isValide, void Function(String)? onTap}) {
  return TextField(
    onChanged: onTap,
    style: TextStyle(color: whiteColor, fontFamily: "urbani_regular", fontSize: 16),
    controller: controller,
    keyboardType: keyBordType,
    decoration: InputDecoration(
      hintStyle: TextStyle(color: whiteColor, fontFamily: "urbani_regular", fontSize: 14),
      hintText: hintText.tr,
      suffixIcon: isValide.isNull
          ? const SizedBox()
          : isValide!
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: Center(
                      child: SvgPicture.asset(
                    "assets/icons/alert-circle.svg",
                    color: Colors.red,
                    height: 22,
                    width: 22,
                  )))
              : const SizedBox(),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: textGreyColor)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: textGreyColor)),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: textGreyColor)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: textGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

showCommonToast(String msg) {
  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
}
