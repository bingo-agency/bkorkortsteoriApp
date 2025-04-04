import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/controllers/topic_question_controller.dart';
import 'package:bingo_project/widgets/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../AppConstData/helper_function.dart';
// import 'questionWebView.dart';

class QuestionsScreen extends StatefulWidget {
  final String topicId;

  const QuestionsScreen({super.key, required this.topicId});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final TopicQuestionController _controller =
      Get.put(TopicQuestionController());
  final PageController _pageController = PageController();

  int correctIndex = -1;
  int selectedIndex = -1;
  bool isContinueEnabled = false;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.fetchTopicQuestion(
      widget.topicId,
    ); // Load questions
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Quiz",
        showBackIcon: true,
        titleColor: Colors.black,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.GetTopicQuestion.value.isEmpty) {
          return const Center(child: Text('No questions available.'));
        }

        // Convert API response to List
        List questions = _controller.GetTopicQuestion.value.values.toList()
          ..removeLast();

        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Prevent swipe
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  var question = questions[index];
                  print("IMAGE LINK HERE : ");
                  print("question['image_link']");
                  print(question['image_link']);

                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 200, // Set a fixed height
                                  width: double.infinity,
                                  child: Image.network(
                                    question['image_link']?.isNotEmpty == true
                                        ? question['image_link']!
                                        : "https://via.placeholder.com/300.png", // Default image
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: 200,
                                          width: double.infinity,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 200,
                                        width: double.infinity,
                                        color: Colors.grey[
                                            300], // Placeholder background
                                        child: const Icon(Icons.error,
                                            color: Colors.red, size: 50),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    question['question_text'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ...List.generate(4, (i) {
                                  String option =
                                      question['option_${i + 1}'] ?? "";
                                  return buildOption(option, i,
                                      question['correct_option'] ?? "E");
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isContinueEnabled
                                  ? Colors.green
                                  : Colors.grey, // Enable when option selected
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: isContinueEnabled
                                ? () {
                                    if (currentQuestionIndex <
                                        questions.length - 1) {
                                      setState(() {
                                        currentQuestionIndex++;
                                        selectedIndex = -1;
                                        correctIndex = -1;
                                        isContinueEnabled = false;
                                      });
                                      _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut);
                                    } else {
                                      // Last question -> Show summary or results
                                      Get.back();
                                      print("Quiz Completed!");
                                    }
                                  }
                                : null,
                            child: Text(
                                currentQuestionIndex == questions.length - 1
                                    ? "Finish"
                                    : "Continue"),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildOption(String text, int index, String correctAns) {
    bool isSelected = index == selectedIndex;
    bool isCorrect = index == correctAnswer(correctAns);

    Color backgroundColor = Colors.grey.shade200;
    if (selectedIndex != -1) {
      if (isSelected) {
        backgroundColor = isCorrect
            ? Colors.green
            : Colors.red; // Highlight correct/incorrect selection
      } else if (isCorrect) {
        backgroundColor = Colors.green; // Show correct answer after selection
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          correctIndex = correctAnswer(correctAns);
          isContinueEnabled = true; // Enable "Continue" button
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  int correctAnswer(String correctOption) {
    switch (correctOption) {
      case "A":
        return 0;
      case "B":
        return 1;
      case "C":
        return 2;
      case "D":
        return 3;
      default:
        throw ArgumentError("Invalid option: $correctOption");
    }
  }
}
