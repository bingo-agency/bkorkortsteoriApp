import 'package:bingo_project/AppConstData/helper_function.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/controllers/theory_screen_controller.dart';
import 'package:bingo_project/model/theory_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheoryScreen extends StatefulWidget {
  const TheoryScreen({super.key});

  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  final TheoryController _controller = Get.put(TheoryController());

  @override
  void initState() {
    super.initState();
    _controller.fetchTheoryItems(); // Trigger the API call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Theory',
        titleColor: Colors.black,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.theoryItems.isEmpty) {
          return const Center(child: Text('No items available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: _controller.theoryItems.length,
          itemBuilder: (context, index) {
            final item = _controller.theoryItems[index];
            return _buildTheoryItem(item);
          },
        );
      }),
    );
  }

  Widget _buildTheoryItem(TheoryItemModel item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
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
        leading: Image.asset(
          item.assetImage,
          height: 40,
          fit: BoxFit.contain,
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        onTap: () {
          Get.toNamed(Routes.stepByStopFlowScreen);
          // Handle item tap
          print('Tapped on ${item.title}');
        },
      ),
    );
  }
}