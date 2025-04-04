import 'package:bingo_project/core/services/config.dart';
import 'package:bingo_project/core/services/dio_api.dart';
import 'package:bingo_project/model/get_topic_description_model.dart';
import 'package:bingo_project/model/steps_model.dart';

class ApiProvider {
  final api = Api();
  Map<String, String> header = {'Content-Type': 'application/json'};

  Future<StepsModel> getSteps() async {
    var response = await api.sendRequest.get(getStepsUrl);
    return StepsModel.fromJson(response.data);
  }

  Future<GetTopicDescriptionModel> getTopicDescription(String topicId) async {
    var response =
        await api.sendRequest.get("${fetchQuestionsByTopicURl}id=$topicId ");
    return GetTopicDescriptionModel.fromJson(response.data);
  }

  Future<dynamic> getTopicQuestion(String topicId) async {
    var response = await api.sendRequest.get("$getStepsQuestions$topicId ");
    return response.data;
  }
}
