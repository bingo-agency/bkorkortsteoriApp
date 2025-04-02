import 'package:bingo_project/core/services/api_service.dart';
import 'package:bingo_project/model/steps_model.dart';
import 'package:bingo_project/model/theory_model.dart';
import 'package:get/get.dart';

class StepsController extends GetxController implements GetxService {
  // Reactive model for steps
  var stepModel = StepsModel().obs;

  // Loading state
  final isLoading = false.obs;

  // Function to fetch and populate the model
  Future<void> fetchSteps() async {
    isLoading.value = true; // Start loading
    try {
      // Fetch steps model from API
      StepsModel model = await ApiProvider().getSteps();

      // Update stepModel using `.value`
      stepModel.value = model;
    } catch (e) {
      print('Error fetching data: $e'); // Handle errors appropriately
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
