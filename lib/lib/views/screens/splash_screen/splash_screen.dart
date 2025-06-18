import 'dart:async';

import 'package:flutter/material.dart';

import '../../base/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.propertyID});
  final String? propertyID;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Timer(const Duration(seconds: 2), () {
        // IntroScreen
      });


      // Get.find<BasicController>().fetchSettings().then((value) async {
      //   if (value.isSuccess) {
      //     PackageInfo info = await PackageInfo.fromPlatform();
      //     log(info.buildNumber, name: 'Build Number');
      //     log(info.version, name: 'Version');
      //
      //     if ((Platform.isIOS ? Get.find<BasicController>().settings?.iosAppVersion : Get.find<BasicController>().settings?.appVersion).toInt >
      //         info.buildNumber.toInt) {
      //       if (!mounted) return;
      //       await showUpdateDialogue(
      //         context: context,
      //         skip: (Platform.isAndroid
      //             ? (Get.find<BasicController>().settings?.forceUpdate != 'on')
      //             : (Get.find<BasicController>().settings?.iosForceUpdate != 'on')),
      //       );
      //     } else if ((Platform.isAndroid
      //             ? Get.find<BasicController>().settings?.maintenanceMode
      //             : Get.find<BasicController>().settings?.iosMaintenanceMode) ==
      //         'on') {
      //       if (!mounted) return;
      //       await showMaintenanceDialog(
      //         context: context,
      //       );
      //     }
      //
      //     Timer(const Duration(seconds: 2), () {
      //       if (Get.find<AuthController>().isLoggedIn()) {
      //         Get.find<AuthController>().getUserProfileData();
      //       }
      //
      //       ///
      //       if (Get.find<SharedPreferences>().getBool(AppConstants.isFirstVisit) ?? true) {
      //         Navigator.pushReplacement(context, getCustomRoute(child: const IntroScreen()));
      //       } else {
      //         Navigator.pushReplacement(context, getCustomRoute(child: const DashboardScreen()));
      //         if (widget.propertyID != null && widget.propertyID!.isNotEmpty) {
      //           Navigator.of(context).push(getCustomRoute(child: PropertyDetailsScreen(propertyId: widget.propertyID.toInt)));
      //         }
      //       }
      //     });
      //   } else {
      //     showCustomToast(msg: value.data?.toString() ?? 'Something Went Wrong');
      //   }
      // });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF242223),
      body: Center(
        child: CustomImage(
          width: 200,
          height: 200,
          path: Assets.imagesAppLogo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
