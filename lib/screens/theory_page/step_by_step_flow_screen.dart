import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/AppConstData/helper_function.dart';
// import 'package:bingo_project/AppConstData/routes.dart';
import 'package:bingo_project/controllers/steps_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'questionScreen.dart';

class StepByStepFlow extends StatefulWidget {
  const StepByStepFlow({super.key});

  @override
  State<StepByStepFlow> createState() => _StepByStepFlowState();
}

class _StepByStepFlowState extends State<StepByStepFlow> {
  final StepsController _controller = Get.put(StepsController());

  @override
  void initState() {
    super.initState();
    _controller.fetchSteps(); // Trigger the API call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Theory Steps',
        showBackIcon: true,
        titleColor: Colors.black,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.stepModel.value.topics?.isEmpty ?? false) {
          return const Center(child: Text('No items available.'));
        }

        return Column(
          children: [
            ProgressBar(),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.stepModel.value.topics?.length ?? 0,
                itemBuilder: (context, index) {
                  var topic = _controller.stepModel.value.topics![index];
                  return QuizStep(
                    number: index + 1,
                    title: topic?.questionTopic ?? "Theory practise",
                    completed:
                        false, // You can update logic for completed status
                    context: context,
                  );
                },
              ),
            ),
          ],
        );

        // return Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Column(
        //     children: [

        //       Expanded(
        //         child:

        //         ListView.builder(
        //           itemCount: _controller.stepModel.value.topics?.length ?? 0,
        //           itemBuilder: (context, index) {
        //             bool isLeft =
        //                 index % 2 == 0; // Alternate between left and right
        //             return Column(
        //               children: [
        //                 InkWell(
        //                   onTap: () {
        //                     Get.toNamed(
        //                       Routes.getTopicDescriptionById,
        //                       arguments: {
        //                         'index': _controller
        //                             .stepModel.value.topics?[index]?.id,
        //                         'topicName': _controller.stepModel.value
        //                             .topics?[index]?.questionTopic,
        //                       },
        //                     );
        //                   },
        //                   child: StepWidget(
        //                     read: index == 0 ? true : false,
        //                     stepNumber: _controller
        //                             .stepModel.value.topics?[index]?.id ??
        //                         "",
        //                     label: _controller.stepModel.value.topics?[index]
        //                             ?.questionTopic ??
        //                         "",
        //                     isLeft: isLeft,
        //                     isLast: index ==
        //                         (_controller.stepModel.value.topics?.length ??
        //                                 0) -
        //                             1,
        //                   ),
        //                 ),
        //               ],
        //             );
        //           },
        //         ),
        //       ),

        //     ],
        //   ),
        // );
      }),
    );
  }
}

class StepWidget extends StatelessWidget {
  final String stepNumber;
  final String label;
  final bool isLeft;
  final bool isLast;
  bool read;

  StepWidget(
      {Key? key,
      required this.stepNumber,
      required this.label,
      required this.isLeft,
      required this.isLast,
      required this.read})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLeft
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: !read ? whiteColor : primary2,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primary2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: !read ? Colors.black : whiteColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                stepNumber,
                                style: TextStyle(
                                  color: !read ? Colors.black : whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              label,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: !read ? Colors.black : whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Only show image if not the last step
                  if (!isLast)
                    Image.asset(
                      "assets/images/right_line.png",
                      height: 50,
                      width: 150,
                    ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Only show image if not the last step
                  if (!isLast)
                    Image.asset(
                      "assets/images/left_line.png",
                      height: 50,
                      width: 150,
                    ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primary2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                stepNumber,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              label,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Start", style: TextStyle(color: Colors.white)),
          Expanded(
            child: LinearProgressIndicator(
              value: 0.15,
              backgroundColor: Colors.grey[700],
              color: const Color(0xFF05CB8D),
            ),
          ),
          const Text("Finish", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class QuizStep extends StatelessWidget {
  final int number;
  final String title;
  final bool completed;
  final BuildContext context;

  const QuizStep(
      {super.key,
      required this.number,
      required this.title,
      required this.completed,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
          () => QuestionScreen(title: title, topicId: number.toString())),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: completed ? const Color(0xFF05CB8D) : Colors.white,
              border: completed
                  ? null
                  : Border.all(color: const Color(0xFF05CB8D), width: 5),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              "$number",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: completed ? Colors.white : const Color(0xFF05CB8D),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // void _showModal(BuildContext context, String title) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Color(0xFF18181B),
  //         title: Text(title, style: TextStyle(color: Colors.white)),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               "Learn all the theory you need for your driving licence, step by step.",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             SizedBox(height: 10),
  //             Image.asset("assets/intro-img-1.jpeg"),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("Close", style: TextStyle(color: Colors.white)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
