import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import 'package:village_wheels_delivery_boy/views/screens/auth_screen/verification_screen/verification_success_screen.dart';

class DriverVerificationScreen extends StatefulWidget {
  const DriverVerificationScreen({super.key});

  @override
  State<DriverVerificationScreen> createState() =>
      _DriverVerificationScreenState();
}

class _DriverVerificationScreenState extends State<DriverVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () async {
          Navigator.push(context, getCustomRoute(child: VerificationSuccessScreen()));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(path: Assets.gifsReviewDoc),
                const SizedBox(height: 20),
                Text(
                  "We're reviewing your documents",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "You'll be notified once the verification is complete.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: secondaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
