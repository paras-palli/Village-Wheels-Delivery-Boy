import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repositories/basic_repo.dart';

class BasicController extends GetxController implements GetxService {
  final BasicRepo basicRepo;
  BasicController({required this.basicRepo});

  bool isLoading = false;
  bool statesLoading = false;
  bool cityLoading = false;

  // SettingsModel? settings;
  // List<BannerModel> banners = [];
  //
  // List<StateModel> states = [];
  // List<CityModel> cities = [];


  //
  // Future<ResponseModel> fetchSettings() async {
  //   log('----------- fetchSettings Called ----------');
  //
  //   ResponseModel responseModel;
  //   isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await basicRepo.settings();
  //     if (response.statusCode == 200) {
  //       if (response.data['success'] == true && response.data['data'] != null) {
  //         settings = SettingsModel.fromJson(response.data['data']);
  //         update();
  //         Get.find<FilterController>()
  //             .changeRangeValue(RangeValues(double.parse(settings?.propertyMinAmount ?? '0'), double.parse(settings?.propertyMaxAmount ?? '0')));
  //
  //         responseModel = ResponseModel(true, response.statusMessage ?? '', response.data['message']);
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['message']);
  //       }
  //     } else {
  //       responseModel = ResponseModel(false, "${response.statusMessage}", response.data['message']);
  //     }
  //   } catch (e) {
  //     log('---- ${e.toString()} ----', name: "ERROR AT fetchSettings()");
  //     responseModel = ResponseModel(false, "$e");
  //   }
  //
  //   isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> fetchStates() async {
  //   log('----------- fetchStates Called ----------');
  //
  //   ResponseModel responseModel;
  //   statesLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await basicRepo.getStates();
  //     if (response.statusCode == 200) {
  //       if (response.data['success'] == true && response.data['data'] != null && response.data['data'] is List) {
  //         states = (response.data['data'] as List<dynamic>).map((state) => StateModel.fromJson(state)).toList();
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '');
  //       }
  //     } else {
  //       responseModel = ResponseModel(false, "${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     log('---- ${e.toString()} ----', name: "ERROR AT fetchStates()");
  //     responseModel = ResponseModel(false, "$e");
  //   }
  //
  //   statesLoading = false;
  //   update();
  //   return responseModel;
  // }
  //
  // Future<ResponseModel> fetchCities({required int stateId}) async {
  //   log('----------- fetchCities Called ----------');
  //
  //   ResponseModel responseModel;
  //   cityLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await basicRepo.getCity(stateId: stateId);
  //     if (response.statusCode == 200) {
  //       if (response.data['success'] == true && response.data['data'] != null) {
  //         cities = (response.data['data'] as List<dynamic>).map((state) => CityModel.fromJson(state)).toList();
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '');
  //       }
  //     } else {
  //       responseModel = ResponseModel(false, "${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     log('---- ${e.toString()} ----', name: "ERROR AT fetchSettings()");
  //     responseModel = ResponseModel(false, "$e");
  //   }
  //
  //   cityLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> fetchBanner() async {
  //   log('----------- fetchBanner Called ----------');
  //
  //   ResponseModel responseModel;
  //   isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await basicRepo.getBanner();
  //     log('${response.data}', name: 'FetchBanner');
  //     if (response.statusCode == 200) {
  //       if (response.data['success'] == true && response.data['data'] != null && response.data['data'] is List) {
  //         banners = (response.data['data'] as List<dynamic>).map((banner) => BannerModel.fromJson(banner)).toList();
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '');
  //       }
  //     } else {
  //       responseModel = ResponseModel(false, "${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     log('---- ${e.toString()} ----', name: "ERROR AT fetchBanner()");
  //     responseModel = ResponseModel(false, "$e");
  //   }
  //
  //   isLoading = false;
  //   update();
  //   return responseModel;
  // }

//
}
