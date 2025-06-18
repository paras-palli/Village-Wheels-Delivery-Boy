import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class PriceConverter {
  static num wholeConvert(num number) {
    if (number == number.toInt()) {
      return (number.toInt());
    }
    return double.parse(number.toStringAsFixed(2));
  }

  static convert({required num price}) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '₹',
    ).format(wholeConvert(price));
  }

  static convertRound(price) {
    return '₹ ${double.parse('$price').toInt()}';
  }

  static convertToNumberFormat(num price) {
    final format = NumberFormat("#,##,##,##0.00", "en_IN");
    return '₹ ${format.format(price)}';
  }
}

String getStringFromList(List<dynamic>? data) {
  String str = data.toString();
  return data.toString().substring(1, str.length - 1);
}

class AppConstants {
  String get getBaseUrl => baseUrl;

  static bool productionMode = true;
  static String get baseUrl {
    if (!kDebugMode || productionMode) return 'https://property.com.heenahealth.in/';
    return 'http://192.168.1.10:8005/';
  }

  static String appName = 'AnyProperty';
  static String googleMapAndroidKey = 'AIzaSyCPMgv3duvS967kagdXKvcn0eD72L3sdF4';

  // Auth
  static const String generateOtp = 'api/v1/user/generate-otp';
  static const String loginUri = 'api/v1/user/login';
  static const String logoutUri = 'api/v1/user/logout';

  // Profile
  static const String signUp = 'api/v1/user/signup';
  static const String profileUri = 'api/v1/basic/profile';

  // Basic
  static const String settings = 'api/v1/basic/business-setting';
  static const String cities = 'api/v1/basic/city';
  static const String states = 'api/v1/basic/state';
  static const String banner = 'api/v1/basic/banner';
  static const String amenities = 'api/v1/basic/amenities';
  static const String areaUnit = 'api/v1/basic/area-unit';
  static const String propertyType = 'api/v1/basic/property-type';
  static const String floorPlan = 'api/v1/basic/floor-plan';
  static const String ownerType = 'api/v1/basic/owner-type';

  // Service
  static const String services = 'api/v1/service/service-type';
  static const String subServices = 'api/v1/service/service-sub-type';
  static const String serviceProviders = 'api/v1/service/service-provider';

  static const String generateServiceLead = 'api/v1/service/lead';

  // Builder
  static const String getBuilders = 'api/v1/project/get-builder';
  static const String getBuilderProfile = 'api/v1/project/builder-profile';
  static const String getBuilderProjects = 'api/v1/project/builder-project';

  static const String getProjects = 'api/v1/project/get-projects';
  static const String getProjectDetails = 'api/v1/project/project-detail';
  static const String generateProjectLead = 'api/v1/project/lead';

  // Property
  static const String getProperties = 'api/v1/property/get';
  static const String getMyProperties = 'api/v1/property/get-my-properties';
  static const String getPropertyDetails = 'api/v1/property/detail';
  static const String generatePropertyLead = 'api/v1/property/lead';
  static const String addProperty = 'api/v1/property/store';
  static const String markAsSold = 'api/v1/property/sold';

  // Favourite
  static const String getFavourites = 'api/v1/favourite/my-favourite';
  static const String addFavourites = 'api/v1/favourite/store';

  //filter
  static const String filterUri = 'api/v1/property/search';

  //subscription
  static const String subscriptionUri = 'api/v1/subscription/get';
  //Payment
  static const String createOrderUri = 'api/v1/subscription/create';
  static const String fetchOrderUri = 'api/v1/subscription/fetch';
  //

  //
  static const double padding = 16;
  static const String extras = 'api/v1/extra';

  // Shared Key
  static const String token = 'user_app_token';
  static const String userId = 'user_app_id';
  static const String razorpayKey = 'razorpay_key';
  static const String recentOrders = 'recent_orders';
  static const String isUser = 'is_user';
  static const String isFirstVisit = 'is_first_visit';
  static const String recentLocations = 'recent_locations';
}
