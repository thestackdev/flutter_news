import 'package:dio/dio.dart';
import 'package:flutter_news/services/utils.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class Controllers extends GetxController {
  static final Controllers find = Get.find();
  final utils = Utils();
  final dio = Dio();

  RxString selectedategory = 'general'.obs;

  final list = [
    {'title': 'General', 'image': 'assets/general_logo.png'},
    {'title': 'Business', 'image': 'assets/business_logo.jpg'},
    {'title': 'Entertainment', 'image': 'assets/entertainment_logo.png'},
    {'title': 'Health', 'image': 'assets/health.png'},
    {'title': 'Science', 'image': 'assets/science_logo.png'},
    {'title': 'Sports', 'image': 'assets/sports.jpg'},
    {'title': 'Technology', 'image': 'assets/technology.jpg'},
  ];

  changeCategory(String category) => selectedategory.value = category;
}
