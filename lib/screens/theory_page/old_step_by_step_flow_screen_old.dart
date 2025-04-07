// import 'package:bingo_project/AppConstData/app_colors.dart';
// import 'package:bingo_project/AppConstData/helper_function.dart';
// import 'package:bingo_project/AppConstData/routes.dart';
// import 'package:bingo_project/controllers/steps_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class StepByStepFlow extends StatefulWidget {
//   @override
//   State<StepByStepFlow> createState() => _StepByStepFlowState();
// }

// class _StepByStepFlowState extends State<StepByStepFlow> {
//   final StepsController _controller = Get.put(StepsController());

//   @override
//   void initState() {
//     super.initState();
//     _controller.fetchSteps(); // Trigger the API call
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//         title: 'Step by step',
//         showBackIcon: true,
//         titleColor: Colors.black,
//       ),
//       body: Obx(() {
//         if (_controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (_controller.stepModel.value.topics?.isEmpty ?? false) {
//           return const Center(child: Text('No items available.'));
//         }

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _controller.stepModel.value.topics?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     bool isLeft =
//                         index % 2 == 0; // Alternate between left and right
//                     return Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Get.toNamed(
//                               Routes.getTopicDescriptionById,
//                               arguments: {
//                                 'index': _controller
//                                     .stepModel.value.topics?[index]?.id,
//                                 'topicName': _controller.stepModel.value
//                                     .topics?[index]?.questionText,
//                               },
//                             );
//                           },
//                           child: StepWidget(
//                             // read: inde÷x == 0 ? true : false,
//                             read: _controller.stepModel.value.topics?[index]
//                                     ?.completed ??
//                                 false,
//                             stepNumber: _controller
//                                     .stepModel.value.topics?[index]?.id ??
//                                 "",
//                             label: _controller.stepModel.value.topics?[index]
//                                     ?.questionText ??
//                                 "",
//                             isLeft: isLeft,
//                             isLast: index ==
//                                 (_controller.stepModel.value.topics?.length ??
//                                         0) -
//                                     1,
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// class StepWidget extends StatelessWidget {
//   final String stepNumber;
//   final String label;
//   final bool isLeft;
//   final bool isLast;
//   bool read;

//   StepWidget(
//       {Key? key,
//       required this.stepNumber,
//       required this.label,
//       required this.isLeft,
//       required this.isLast,
//       required this.read})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         isLeft
//             ? Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 150,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: !read ? whiteColor : primary2,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: primary2),
//                     ),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     color: !read ? Colors.black : whiteColor)),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 stepNumber,
//                                 style: TextStyle(
//                                   color: !read ? Colors.black : whiteColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               label,
//                               maxLines: 2,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: !read ? Colors.black : whiteColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Only show image if not the last step
//                   if (!isLast)
//                     Image.asset(
//                       "assets/images/right_line.png",
//                       height: 50,
//                       width: 150,
//                     ),
//                 ],
//               )
//             : Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Only show image if not the last step
//                   if (!isLast)
//                     Image.asset(
//                       "assets/images/left_line.png",
//                       height: 50,
//                       width: 150,
//                     ),
//                   Container(
//                     width: 150,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: primary2),
//                     ),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.black)),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 stepNumber,
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               label,
//                               maxLines: 2,
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ],
//     );
//   }
// }
