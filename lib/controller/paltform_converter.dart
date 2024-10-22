import 'package:get/get.dart';

class PaltformConverter
{
  RxBool isIos = false.obs;

  void changePlatform()
  {
    isIos.value = !isIos.value;
  }
}