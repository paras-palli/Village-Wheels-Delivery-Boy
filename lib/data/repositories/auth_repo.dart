import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_wheels_delivery_boy/services/extensions.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  AuthRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> generateOtp({required Map<String, dynamic> data}) async => await apiClient.postData(AppConstants.generateOtp, data);

  Future<Response> verifyOtp({required String phone, required String otp}) async => await apiClient.postData(
    AppConstants.loginUri, {
      "phone": phone,
      'otp': otp,
      'device_id': await getDeviceId(),
    },
  );

  Future<Response> getUser() async => await apiClient.getData(AppConstants.getProfileData);

  Future<Response> logoutUser() async => await apiClient.getData(AppConstants.logoutUri);

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<void> setUserToken(String token) async {
    apiClient.updateHeader(token);
    await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.userId);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  Future<String> getDeviceId() async {
    int count = 0;

    while (OneSignal.User.pushSubscription.id.isNotValid && count < 0) {
      await Future.delayed(const Duration(seconds: 1));
      count++;

      log(count.toString(), name: 'DeviceId Wait Count');
      log('${OneSignal.User.pushSubscription.id}', name: "12345678");
      log('${OneSignal.User.pushSubscription.token}', name: "12345678");
    }

    return OneSignal.User.pushSubscription.id.isValid ? OneSignal.User.pushSubscription.id.getOrNa : '12345678';
  }
}
