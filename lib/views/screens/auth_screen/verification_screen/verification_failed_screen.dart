import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/views/screens/dashboard_screen/dashboard_screen.dart';

import '../../../../services/theme.dart';
import '../../../base/common_button.dart';
import '../../../base/custom_image.dart';

class VerificationFailedScreen extends StatelessWidget {
  const VerificationFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      "SORRY",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xffEC2717),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      textAlign: TextAlign.center,
                      "Document Verification Failed Unfortunately, your documents could not be verified. Please review and upload the correct documents to proceed.",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      onTap: () {
                        Navigator.push(
                            context, getCustomRoute(child: DashboardScreen()));
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
                    path: Assets.imagesRegistrationFailure,
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
