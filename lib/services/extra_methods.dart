import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../views/base/custom_toast.dart';

class ExtraMethods {
  String getWhatsAppUrl(String number, [String msg = '']) {
    return 'https://wa.me/91$number?text=$msg';
  }

  void makeCall(String number) async {
    final url = Uri(scheme: 'tel', path: number);
    launchUrl(url);
  }

  void shareMyApp(BuildContext context, String appLink) async {
    final box = context.findRenderObject() as RenderBox?;
    {
      await Share.share(
        appLink,
        subject: 'AnyProperty',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  void makeMail(String email, [String subject = '']) {
    try {
      Uri emailLaunchUri = Uri(scheme: 'mailto', path: email, queryParameters: {'subject': subject});
      var url = emailLaunchUri.toString().replaceAll('+', ' ');
      launchInBrowser(url);
    } catch (e) {
      log(e.toString(), name: "Error at makeMail");
    }
  }

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'},
        ),
      );
    } else {
      showCustomToast(msg: 'Invalid url {$url}', toastType: ToastType.error);
      log('Could not launch $url');
    }
  }

  static Future<void> launchWebsite(String url) async {
    if (!(url.startsWith('http'))) {
      if (!(url.startsWith('https://'))) {
        url = 'https://$url';
      }
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      log('Could not launch $url');
    }
  }

  static bool isValidAadhaar(String input) {
    final aadhaarRegExp = RegExp(r'^[2-9]{1}[0-9]{11}$');
    return aadhaarRegExp.hasMatch(input);
  }

  static bool isValidPAN(String input) {
    final panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegExp.hasMatch(input.toUpperCase());
  }

  static bool isValidDrivingLicense(String input) {
    final dlRegExp = RegExp(r'^[A-Z]{2}[0-9]{2}[0-9]{4}[0-9]{7,8}$');
    return dlRegExp.hasMatch(input.toUpperCase());
  }
}

String formatIndianNumber(double number) {
  if (number >= 10000000) {
    return "${(number / 10000000).toStringAsFixed(2)} Cr";
  } else if (number >= 100000) {
    return "${(number / 100000).toStringAsFixed(2)} Lakh";
  } else {
    return number.toStringAsFixed(2);
  }
}
