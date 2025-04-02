import 'package:bingo_project/core/services/api_service.dart';
import 'package:bingo_project/model/get_topic_description_model.dart';
import 'package:bingo_project/model/steps_model.dart';
import 'package:bingo_project/model/theory_model.dart';
import 'package:get/get.dart';

class TopicDescriptionController extends GetxController implements GetxService {
  // Reactive model for steps
  var GetTopicDecription = GetTopicDescriptionModel().obs;

  // Loading state
  final isLoading = false.obs;

  // Function to fetch and populate the model
  Future<void> fetchTopicDescription(String topicId) async {
    isLoading.value = true; // Start loading
    try {
      GetTopicDescriptionModel model =
          await ApiProvider().getTopicDescription(topicId);

      GetTopicDecription.value = model;
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
