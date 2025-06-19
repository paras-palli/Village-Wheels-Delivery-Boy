import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/basic_controller.dart';
import 'package:village_wheels_delivery_boy/services/extensions.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/views/base/dialogs/maintenance_dialog.dart';
import 'package:village_wheels_delivery_boy/views/base/dialogs/update_dialog.dart';
import 'package:village_wheels_delivery_boy/views/screens/auth_screen/components/profile_under_review_screen.dart';
import 'package:village_wheels_delivery_boy/views/screens/auth_screen/signup_screen/signup_screen.dart';
import 'package:village_wheels_delivery_boy/views/screens/dashboard_screen/dashboard_screen.dart';
import 'package:village_wheels_delivery_boy/views/screens/splash_screen/components/login_bottom_sheet.dart';
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
      Get.find<BasicController>().fetchSettings().then((value) async {
        if (value.isSuccess) {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          var setting = Get.find<BasicController>();
          if (setting.getAppLinkAndAppVersion(
                      'user_android_maintenance_mode') !=
                  null &&
              setting.getAppLinkAndAppVersion(
                      'user_android_maintenance_mode') ==
                  '1') {
            if (!mounted) return;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const MaintenanceDialog(),
            );
          } else if (int.parse(packageInfo.buildNumber) <
              int.parse(
                  setting.getAppLinkAndAppVersion('user_app_version') ?? '0')) {
            bool isSkippable = Platform.isAndroid
                ? (((setting.getAppLinkAndAppVersion(
                                'user_force_update_android') !=
                            null &&
                        setting.getAppLinkAndAppVersion(
                                'user_force_update_android') ==
                            '0'))
                    ? true
                    : false)
                : (((setting.getAppLinkAndAppVersion('force_update_ios') !=
                            null &&
                        setting.getAppLinkAndAppVersion('force_update_ios') ==
                            '0'))
                    ? true
                    : false);

            if (!mounted) return;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => UpdateDialog(
                remark: 'Please update app to the latest version',
                skip: isSkippable,
              ),
            ).then((value) {
              if (value == true) initMethod();
            });
          } else {
            initMethod();
          }
        }
      });
    });
    super.initState();
  }

  void initMethod() {
    final AuthController auth = Get.find<AuthController>();
    if (auth.isLoggedIn()) {
      auth.getUserProfileData().then((value) {
        if (!mounted) return;
        if (value.isSuccess) {
          if (auth.userModel?.name == null) {
            Get.find<RegisterController>().loadSignUpData();
            Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const SignupScreen()), (route) => false);
            return;
          }
          if (auth.userModel?.status == 'pending') {
            Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const ProfileUnderReviewScreen()),
                (route) => false);
            return;
          }
          if ((auth.userModel?.name).isValid &&
              (auth.userModel?.phone).isPhone) {
            Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const DashboardScreen()),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const SignupScreen()), (route) => false);
          }
        } else {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container();
            },
          );
          // Navigator.of(context).pushAndRemoveUntil(getCustomRoute(child: const LoginScreen()), (route) => false);
        }
      });
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.white,
        builder: (context) {
          return const LoginBottomSheet();
        },
      );


      // Navigator.of(context).pushAndRemoveUntil(
      //     getCustomRoute(child: const LoginScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesSplash), fit: BoxFit.cover)),
      ),
    );
  }
}
