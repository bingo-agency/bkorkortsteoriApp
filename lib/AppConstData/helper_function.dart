import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

TextStyle customTextStyle({
  double size = 14.0, // Default size
  FontWeight weight = FontWeight.normal, // Default weight
  Color color = Colors.black,
  // Default color
}) {
  return TextStyle(
      fontSize: size, fontWeight: weight, color: color, fontFamily: "Poppins");
}

Widget buildTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 34,
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  );
}

PreferredSizeWidget customAppBar({
  required String title,
  Color titleColor = Colors.black,
  Color backgroundColor = Colors.white,
  bool? showBackIcon, // Nullable boolean parameter
}) {
  return AppBar(
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(FeatherIcons.command,
            color: Color(0xFF4d4949)), // Custom hamburger icon
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Open the drawer manually
        },
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
          color: titleColor, fontWeight: FontWeight.w600, fontSize: 30),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
            icon: const Icon(FeatherIcons.user),
            onPressed: () {
              debugPrint("awesome platform to share code and ideas");
            }),
      )
    ],
    backgroundColor: backgroundColor,
    centerTitle: false,
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Color(0xFF4d4949), // Set the icon color to black
    ),
    automaticallyImplyLeading:
        showBackIcon ?? false, // Use showBackIcon or default to false
  );
}
