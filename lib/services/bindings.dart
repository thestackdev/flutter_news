import 'package:flutter_news/services/controllers.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controllers>(() => Controllers());
  }
}
