import 'package:get/get_connect/http/src/response/response.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class BasicRepo {
  final ApiClient apiClient;
  const BasicRepo({required this.apiClient});

  Future<Response> settings() async => apiClient.getData(AppConstants.settings);

  // Future<Response> getCity({required int stateId}) async => apiClient.getData(AppConstants.cities, query: {
  //   'id': stateId,
  // });
  //
  // Future<Response> getStates() async => apiClient.getData(AppConstants.states);

}
