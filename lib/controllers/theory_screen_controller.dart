import 'package:bingo_project/model/theory_model.dart';
import 'package:get/get.dart';

class TheoryController extends GetxController implements GetxService {
  // Reactive list of theory items
  final theoryItems = <TheoryItemModel>[].obs;

  // Loading state
  final isLoading = false.obs;

  // Function to fetch and populate the list
  Future<void> fetchTheoryItems() async {
    isLoading.value = true; // Start loading
    try {
      final fetchedItems = [
        TheoryItemModel(
          assetImage: 'assets/images/step_by_step.png',
          title: 'Step by Step',
        ),
        TheoryItemModel(
          assetImage: 'assets/images/question.png',
          title: 'Questions',
        ),
        TheoryItemModel(
          assetImage: 'assets/images/book.png',
          title: 'Book',
        ),
        TheoryItemModel(
          assetImage: 'assets/images/knowledge_base.png',
          title: 'Knowledge Base',
        ),
      ];

      theoryItems.assignAll(fetchedItems); // Update the list
    } catch (e) {
      print('Error fetching data: $e'); // Handle errors appropriately
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
