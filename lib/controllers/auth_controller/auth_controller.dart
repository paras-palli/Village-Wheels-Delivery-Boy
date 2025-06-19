import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/response/response_model.dart';
import '../../data/models/user/user_model.dart';
import '../../data/repositories/auth_repo.dart';
import '../../views/base/custom_toast.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool isLoading = false;
  UserModel? userModel;

  Future<ResponseModel> generatedOtp({required Map<String, dynamic> data}) async {
    log('----------- generatedOtp Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();
    try {
      Response response = await authRepo.generateOtp(data: data);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, response.body['message']?.toString() ?? 'Otp Generated');
      } else {
        responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT generatedOtp()");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyOtp({required String phone, required String otp}) async {
    log('----------- verifyOtp Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await authRepo.verifyOtp(phone: phone, otp: otp);
      if (response.statusCode == 200 && (response.body as Map).containsKey('token')) {
        responseModel = ResponseModel(true, response.body['message'] ?? 'Otp Verified',
          {'new': response.body['user_type'] == 'new'},
        );
        await setUserToken(token: response.body['token']);
      } else {
        showCustomToast(msg: '${response.body['message']}', toastType: ToastType.warning);
        responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT verifyOtp()");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> logoutUser() async {
    log('----------------- logoutUser Called ----------------');
    ResponseModel responseModel;

    try {
      Response response = await authRepo.logoutUser();

      if (response.statusCode == 200 && response.body['success'] == true) {
        clearSharedData();
        responseModel = ResponseModel(true, response.body['message']?.toString() ?? 'Logout Successful');
      } else {
        responseModel = ResponseModel(false,  response.body['message']?.toString() ?? 'Something Went Wrong');
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++ ${e.toString()} +++++++++++++++', name: "ERROR AT logoutUser()");
    }

    return responseModel;
  }

  Future<ResponseModel> getUserProfileData() async {
    log('----------- getUserProfileData Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await authRepo.getUser();
      if (response.statusCode == 200 && response.body['success'] == true && response.body['data'] != null) {
        userModel = UserModel.fromJson(response.body['data']);
        responseModel = ResponseModel(true, 'Success');
      } else {
        responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getUserProfileData()");
      responseModel = ResponseModel(false, "$e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  Future<void> setUserToken({required String token}) async {
    await authRepo.setUserToken(token);
  }
}
