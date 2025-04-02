import 'package:get/get.dart';

class PrimaryLanguageController extends GetxController implements GetxService {
  int selectedLanguage = 1;

  setSelectedLanguage(int index) {
    selectedLanguage = index;
    update();
  }
}
