import 'package:bingo_project/core/services/api_service.dart';
import 'package:get/get.dart';

class TopicQuestionController extends GetxController implements GetxService {
  var GetTopicQuestion = <String, dynamic>{}.obs; // Use a Map to hold the data

  final isLoading = false.obs;

  Future<void> fetchTopicQuestion(String topicId) async {
    isLoading.value = true;
    try {
      // Fetch the data using the API service
      final model = await ApiProvider().getTopicQuestion(topicId);

      // Directly assign the fetched model (which is a Map) to GetTopicQuestion
      GetTopicQuestion.value =
          model; // No need for toMap() if model is already a Map
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false; // Stop loading once data is fetched
    }
  }
}
