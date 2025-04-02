import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/AppConstData/helper_function.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrivingScreen extends StatefulWidget {
  const DrivingScreen({Key? key}) : super(key: key);

  @override
  State<DrivingScreen> createState() => _DrivingScreenState();
}

class _DrivingScreenState extends State<DrivingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Driving',
        titleColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Sign in or register to view your upcoming bookings and track your educational progress.",
                  style: TextStyles.font14Grey400Weight,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              icon: Icons.manage_accounts_outlined,
              title: "Create an Account",
              onTap: () => Get.toNamed(Routes.signupScreen),
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              icon: Icons.login,
              title: "Sign in",
              onTap: () => Get.toNamed(Routes.loginScreen),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a reusable action tile widget
  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Icon(icon, size: 40, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}
