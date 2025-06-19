import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class RegisterRepo {
  final ApiClient apiClient;
  RegisterRepo({required this.apiClient});

  Future<Response> register({required Map<String, dynamic> data}) async =>
      await apiClient.postData(AppConstants.registerUri, FormData(data));

  Future<Response> updateProfile({required Map<String, dynamic> data}) async =>
      await apiClient.postData(AppConstants.updateProfileUri, FormData(data));

  // Future<Response> getAddressData() async =>
  //     await apiClient.getData(AppConstants.addressUri);
}
