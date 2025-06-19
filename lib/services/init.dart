import 'dart:developer';

import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/otp_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/dashboard_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/location_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/order_controller/order_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/order_controller/pusher_controller.dart';
import 'package:village_wheels_delivery_boy/data/repositories/order_repo.dart';

import '../controllers/PermissionController.dart';
import '../controllers/auth_controller/auth_controller.dart';
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
      Get.lazyPut(() => LocationController());

      Get.lazyPut(() => PermissionController());

      // Get Repo's...
      Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
      Get.lazyPut(() => BasicRepo(apiClient: Get.find()));
      Get.lazyPut(() => OrderRepo(apiClient: Get.find()));


      // Get Controller's...
      Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Get.lazyPut(() => BasicController(basicRepo: Get.find()));

      Get.lazyPut(() => OrderController(orderRepo: Get.find()));

      Get.lazyPut(() => OTPAutofillController());
      Get.lazyPut(() => PusherController());
      Get.lazyPut(() => DashBoardController());
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT initialize()");
    }
  }
}
