import 'package:get/get_connect/http/src/response/response.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class BasicRepo {
  final ApiClient dioClient;
  const BasicRepo({required this.dioClient});

  Future<Response> settings() async => dioClient.getData(AppConstants.settings);

  Future<Response> getCity({required int stateId}) async => dioClient.getData(AppConstants.cities, query: {
    'id': stateId,
  });

  Future<Response> getStates() async => dioClient.getData(AppConstants.states);

  // Future<Response> getBanner() async => dioClient.getData(AppConstants.banner);
}
