import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/AppConstData/helper_function.dart';
import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/controllers/topic_descriptions_controller.dart';
import 'package:bingo_project/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TopicDescriptionFlow extends StatefulWidget {
  final String topicId;
  final String topicName;

  const TopicDescriptionFlow({super.key, required this.topicId, required this.topicName});

  @override
  State<TopicDescriptionFlow> createState() => _TopicDescriptionFlowState();
}

class _TopicDescriptionFlowState extends State<TopicDescriptionFlow> {
  final TopicDescriptionController _controller = Get.put(TopicDescriptionController());

  @override
  void initState() {
    super.initState();
    _controller.fetchTopicDescription(widget.topicId); // Trigger the API call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: widget.topicName,
        showBackIcon: true,
        titleColor: Colors.black,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            color: primary2,
          ));
        }

        if (_controller.GetTopicDecription.value.topics?.isEmpty ?? false) {
          return const Center(child: Text('No items available.'));
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: _controller.GetTopicDecription.value.topics?.first?.description ?? '',
                  style: {
                    "p": Style(
                      fontSize: FontSize(16),
                      lineHeight: LineHeight(1.5),
                      margin: Margins.only(bottom: 16),
                    ),
                    "img": Style(
                      width: Width(400, Unit.px), // Specify unit
                      height: Height(200, Unit.px), // Specify unit
                    ),
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: Get.width,
                child: commonButton(
                    title: "Continue",
                    onTapp: () {
                      Get.toNamed(Routes.getTopicQuestionsById, arguments: widget.topicId);
                    }),
              ),
            )
          ],
        );
      }),
    );
  }
}
