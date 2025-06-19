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
    if (!kDebugMode || productionMode) return 'https://admin.villagewheels.in/';
    return 'http://192.168.1.10:8005/';
  }

  static String appName = 'Village Wheels';
  static String googleMapAndroidKey = 'AIzaSyCPMgv3duvS967kagdXKvcn0eD72L3sdF4';

  // Auth
  static const String generateOtp = 'api/vendor/v1/auth/otp/send';
  static const String loginUri = 'api/vendor/v1/auth/otp/verify';
  static const String logoutUri = 'api/vendor/v1/auth/logout';

  // Profile
  static const String getProfileData = 'api/vendor/v1/auth/profile';

  //--------basic---------
  static const String settings = 'api/v1/basic/settings';

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
