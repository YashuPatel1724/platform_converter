import 'package:get/get.dart';

class ThemeController {
  RxBool isDark = false.obs;

  void darkMode() {
    isDark.value = !isDark.value;
    print(isDark);
  }
}
