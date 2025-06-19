import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/views/base/common_button.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import 'package:village_wheels_delivery_boy/views/screens/auth_screen/verification_screen/verification_failed_screen.dart';

import '../../../../services/route_helper.dart';
import '../../../../services/theme.dart';
import '../../dashboard_screen/dashboard_screen.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          onRefresh: () async {
            // Navigator.push(
            //     context, getCustomRoute(child: const VerificationFailedScreen()));
          },
          child: Center(
              child: Container(
            padding: const EdgeInsets.all(32),
            height: 450,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 65),
                      Text(
                        "CONGRATULATIONS",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: const Color(0xff28B339),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        textAlign: TextAlign.center,
                        "Your documents have been successfully verified.\nWelcome to Village Wheels!\nYou're all set to get started!",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onTap: () {
                          Navigator.push(context, getCustomRoute(child: VerificationFailedScreen()));

                        },
                        title: "Get Started",
                      )
                    ],
                  ),
                  const Positioned(
                    top: -65,
                    left: 50,
                    right: 50,
                    child: CustomImage(
                      path: Assets.imagesRegistrationSuccess,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Positioned(
                    top: -65,
                    left: 40,
                    child: CustomImage(
                      path: Assets.imagesStar,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  const Positioned(
                    top: -10,
                    right: 45,
                    child: CustomImage(
                      path: Assets.imagesStar,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  const Positioned(
                    top: -10,
                    left: 60,
                    child: CustomImage(
                      path: Assets.imagesStar,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const Positioned(
                    top: 25,
                    left: 25,
                    right: 0,
                    child: CustomImage(
                      path: Assets.imagesStar,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const Positioned(
                    top: -80,
                    right: 85,
                    child: CustomImage(
                      path: Assets.imagesStar,
                      width: 10,
                      height: 10,
                    ),
                  ),
                  const Positioned(
                    top: -45,
                    left: 85,
                    right: 0,
                    child: CustomImage(
                      path: Assets.imagesStar,
                      width: 10,
                      height: 10,
                    ),
                  ),
                  const Positioned(
                    top: -60,
                    right: 60,
                    left: -20,
                    child: CustomImage(
                      path: Assets.imagesStar,
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
