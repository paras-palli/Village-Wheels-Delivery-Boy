import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/views/base/common_button.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import 'package:village_wheels_delivery_boy/views/base/dialogs/logout_dialog.dart';
import 'package:village_wheels_delivery_boy/views/screens/dashboard_screen/dashboard_screen.dart';

class ProfileUnderReviewScreen extends StatelessWidget {
  const ProfileUnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.red,
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const LogoutDialog();
                },
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: () async {
              final controller = Get.find<AuthController>();
              controller.getUserProfileData().then((value) {
                if (value.isSuccess) {
                  if (controller.userModel?.status == 'active') {
                    Navigator.of(context).pushAndRemoveUntil(
                      getCustomRoute(child: const DashboardScreen()), (route) => false,
                    );
                  }
                }
              });
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomImage(
                    path: Assets.imagesProfileUnderReview,
                    fit: BoxFit.contain,
                    height: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Profile Under Review!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "We are in the process of reviewing your profile. This may take some time. You will be notified once your profile is approved. Thank you for your patience.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onTap: () {},
                    child: Text(
                      "Support",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
