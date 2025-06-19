import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';

class SignUpPageTwo extends StatefulWidget {
  const SignUpPageTwo({super.key, this.isFrmProfile = false});
  final bool isFrmProfile;

  @override
  State<SignUpPageTwo> createState() => _SignUpPageTwoState();
}

class _SignUpPageTwoState extends State<SignUpPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose Your Business to Start!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Become a partner by selecting the Business you’ll use.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bussinessList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return BussinessItemWidget(bussiness: bussinessList[index]);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BussinessItemWidget extends StatelessWidget {
  const BussinessItemWidget({
    super.key,
    required this.bussiness,
  });

  final Bussiness bussiness;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.selectBussiness(bussiness);
          controller.selectBussinessFromBussinessList();
          log("${controller.selectedBussiness}");
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.3,
                    color: bussiness.isSellected ? primaryColor : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: .3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  CustomImage(
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                    path: bussiness.image ?? '',
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bussiness.name ?? '',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(right: 0),
              decoration: BoxDecoration(
                color: !bussiness.isGrey
                    ? Colors.transparent
                    : Colors.grey.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      );
    });
  }
}
