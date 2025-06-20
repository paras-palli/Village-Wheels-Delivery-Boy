import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:village_wheels_delivery_boy/data/models/basic/city_model.dart';
import 'package:village_wheels_delivery_boy/data/models/basic/settings_model.dart';
import 'package:village_wheels_delivery_boy/data/models/basic/state_model.dart';
import 'package:village_wheels_delivery_boy/data/models/response/response_model.dart';
import 'package:village_wheels_delivery_boy/services/enums/settings_enum.dart';

import '../data/repositories/basic_repo.dart';

class BasicController extends GetxController implements GetxService {
  final BasicRepo basicRepo;
  BasicController({required this.basicRepo});

  bool isLoading = false;
  bool statesLoading = false;
  bool cityLoading = false;

  //
  List<SettingsModel> settings = [];
  Future<ResponseModel> fetchSettings() async {
    log('----------- fetchSettings Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await basicRepo.settings();
      if (response.statusCode == 200) {
        if (response.body['success'] == true && response.body['data'] is List) {
          settings = (response.body['data'] as List<dynamic>).map((e) => SettingsModel.fromJson(e)).toList();
          responseModel = ResponseModel(true, '${response.body['message']}');
        } else {
          responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong',);
        }
      } else {
        responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT fetchSettings()");
      responseModel = ResponseModel(false, "$e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  String? getAppLinkAndAppVersion(String key) {
    for (var element in settings) {
      if (element.key == key) return element.value;
    }
    return null;
  }

  String getHtmlContent(BusinessSettingName name) {
    for (int i = 0; i < settings.length; i++) {
      if (name == BusinessSettingName.privacyPolicy) {
        if (settings[i].key == 'privacy_policy') {
          return settings[i].value ?? 'NA';
        }
      } else if (name == BusinessSettingName.contactUs) {
        if (settings[i].key == 'contact_us') {
          return settings[i].value ?? 'NA';
        }
      } else if (name == BusinessSettingName.aboutUs) {
        if (settings[i].key == 'about_us') {
          return settings[i].value ?? 'NA';
        }
      } else if (name == BusinessSettingName.helpCenter) {
        if (settings[i].key == 'help_center') {
          return settings[i].value ?? 'NA';
        }
      } else if (name == BusinessSettingName.termsAndCondition) {
        if (settings[i].key == 'terms_and_condition') {
          return settings[i].value ?? 'NA';
        }
      }
    }
    return 'NA';
  }

  List<StateModel> states = [];
  Future<ResponseModel> fetchStates() async {
    log('----------- fetchStates Called ----------');

    ResponseModel responseModel;
    statesLoading = true;
    update();

    try {
      Response response = await basicRepo.getStates();
      if (response.statusCode == 200) {
        if (response.body['success'] == true && response.body['data'] is List) {
          states = (response.body['data'] as List<dynamic>).map((state) => StateModel.fromJson(state)).toList();
          responseModel = ResponseModel(true, response.body['message']?.toString() ?? 'Success');
        } else {
          responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
        }
      } else {
        responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT fetchStates()");
      responseModel = ResponseModel(false, "$e");
    }

    statesLoading = false;
    update();
    return responseModel;
  }

  List<CityModel> cities = [];
  Future<ResponseModel> fetchCities({required int stateId}) async {
    log('----------- fetchCities Called ----------');

    ResponseModel responseModel;
    cityLoading = true;
    update();

    try {
      Response response = await basicRepo.getCity(stateId: stateId);
      if (response.statusCode == 200) {
        if (response.body['success'] == true && response.body['data'] != null) {
          cities = (response.body['data'] as List<dynamic>).map((state) => CityModel.fromJson(state)).toList();
          responseModel = ResponseModel(true, response.body['message']?.toString() ?? 'Success');
        } else {
          responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
        }
      } else {
        responseModel = ResponseModel(false, response.body['message']?.toString() ?? 'Something Went Wrong');
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT fetchCities()");
      responseModel = ResponseModel(false, "$e");
    }

    cityLoading = false;
    update();
    return responseModel;
  }
}
