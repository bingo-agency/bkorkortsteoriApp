import 'package:get/get.dart';

class SecondaryLanguageController extends GetxController implements GetxService {
  int selectedLanguage = 1;

  setSelectedLanguage(int index) {
    selectedLanguage = index;
    update();
  }
}
