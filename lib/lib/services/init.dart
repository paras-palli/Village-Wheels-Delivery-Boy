import 'dart:developer';

import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/PermissionController.dart';
import '../controllers/auth_controller.dart';
import '../controllers/basic_controller.dart';
import '../data/api/api_client.dart';
import '../data/repositories/auth_repo.dart';
import '../data/repositories/basic_repo.dart';
import 'constants.dart';

class Init {
  initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);

    try {
      // ApiClient
      Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: sharedPreferences));

      // Location Controller
      // Get.lazyPut(() => LocationController());

      Get.lazyPut(() => PermissionController());

      // Get Repo's...
      Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
      Get.lazyPut(() => BasicRepo(dioClient: Get.find()));


      // Get Controller's...
      Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Get.lazyPut(() => BasicController(basicRepo: Get.find()));
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT initialize()");
    }
  }
}
