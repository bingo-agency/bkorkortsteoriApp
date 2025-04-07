import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/topic_descriptions_controller.dart';
import '../questions_page/questions.dart';

class QuestionScreen extends StatefulWidget {
  final String title;
  final String topicId;
  late bool completed;

  QuestionScreen(
      {Key? key,
      required this.title,
      required this.topicId,
      required this.completed})
      : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final WebViewController _webViewController;
  final TopicDescriptionController controller =
      Get.put(TopicDescriptionController());

  @override
  void initState() {
    super.initState();
    controller.fetchTopicDescription(widget.topicId);
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Show shimmer while loading
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: List.generate(
                  5,
                  (index) => Container(
                    width: double.infinity,
                    height: 20,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        // Load HTML content into WebView
        String description =
            controller.GetTopicDecription.value.topics?.isNotEmpty == true
                ? controller.GetTopicDecription.value.topics![0]?.description ??
                    "No description available"
                : "No description available";

        _webViewController.loadHtmlString('''
  <html>
    <head>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
      <style>
        body { 
          font-family: 'Poppins', sans-serif;
          font-size: 32px; 
          padding: 16px;
          line-height: 1.6;
          padding-bottom: 100px;
        }
        img {
          width: 100%;
        }
      </style>
    </head>
    <body>$description</body>
  </html>
''');

        return WebViewWidget(controller: _webViewController);
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity, // Makes the button full width
          height: 50, // Adjust height as needed
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Green button from theme
              foregroundColor: Colors.white, // White text
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
            onPressed: () async {
              print(widget.topicId); // Debugging purpose

              if (widget.topicId == "1") {
                // markTopicCompleted(widget.topicId, "123"); // Pass actual userId

                Navigator.of(context).pop(); // Go back if topicId is "1"
                // Will to update here "Completed" for the first one when i click continue.
                widget.completed = true;
                // await controller.markTopicCompleted(widget.topicId, "123"); // Replace with actual user ID

                // controller.markTopicCompleted(
                // widget.topicId); // ✅ Mark as complete in controller + API
              } else {
                Get.to(() => QuestionsScreen(
                    topicId: widget.topicId)); // Navigate to QuestionsScreen
              }
            },
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
