import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/basic_controller.dart';
import 'package:village_wheels_delivery_boy/services/extensions.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_toast.dart';
import 'package:village_wheels_delivery_boy/views/screens/dashboard_screen/dashboard_screen.dart';

import '../../../../controllers/auth_controller/auth_controller.dart';
import '../../../../controllers/location_controller.dart';
import '../../../../services/route_helper.dart';
import '../../../base/common_button.dart';
import '../components/profile_under_review_screen.dart';
import 'components/signup_page_five.dart';
import 'components/signup_page_one.dart';
import 'components/signup_page_three.dart';
import 'components/signup_page_two.dart';
import 'signup_four_screen/signup_page_four.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, this.isFrmProfile = false});
  final bool isFrmProfile;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final PageController controller = PageController();
  List<Widget> signupPages = [
    const SignupPageOne(),
    const SignUpPageTwo(),
    const SignupPageThree(),
    SignupPageFour(),
    const SignUpPageFive(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      final BasicController basicController = Get.find<BasicController>();
      if (basicController.states.isEmpty) {
        final statesResponse = await basicController.fetchStates();
        if (!statesResponse.isSuccess) showCustomToast(msg: statesResponse.message, toastType: ToastType.warning);
      }

      final RegisterController registerController = Get.find<RegisterController>();
      if (widget.isFrmProfile) {
        registerController.prefillProfileData();
      } else {
        registerController.phone.text = (Get.find<AuthController>().userModel?.phone).getIfValid;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFrmProfile
          ? AppBar(
              title: Text(
                'Update Profile',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < signupPages.length; i++)
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: selectedIndex < i
                                          ? const Color(0xFFE6ECF5)
                                          : const Color(0xFF233A7D),
                                      height: 8,
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE6ECF5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selectedIndex < i
                                              ? Colors.white
                                              : const Color(0xFF233A7D),
                                        ),
                                        child: Center(
                                          child: selectedIndex > i
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  '${i + 1}',
                                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: selectedIndex < i ? const Color(0xFF233A7D) : Colors.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: selectedIndex < i
                                          ? const Color(0xFFE6ECF5)
                                          : const Color(0xFF233A7D),
                                      height: 8,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                [
                                  'Personal',
                                  'Business',
                                  'Address',
                                  'KYC',
                                  'Bank'
                                ][i],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: PageView.builder(
                    // controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (val) {
                      setState(() {
                        selectedIndex = val;
                      });
                    },
                    itemCount: signupPages.length,
                    itemBuilder: (context, index) {
                      return signupPages[selectedIndex];
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (selectedIndex != 0)
                      Expanded(
                        child: CustomButton(
                          radius: 8,
                          onTap: () {
                            if (selectedIndex > 0) {
                              selectedIndex--;
                              setState(() {});
                            }
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GetBuilder<RegisterController>(
                        builder: (controller) {
                          return CustomButton(
                            radius: 8,
                            isLoading: controller.isLoading,
                            onTap: () {
                              final LocationController locationCtrl = Get.find<LocationController>();
                              if (formkey.currentState!.validate()) {
                                if (selectedIndex < signupPages.length - 1) {
                                  if (selectedIndex == 1 && controller.selectedBussiness.isEmpty) {
                                    showCustomToast(msg: "Please select a bussiness", toastType: ToastType.info);
                                    return;
                                  }
                                  if (selectedIndex == 2 && locationCtrl.latLng == null) {
                                    showCustomToast(msg: "Please select a location on the map", toastType: ToastType.info);
                                    return;
                                  }

                                  selectedIndex++;
                                  setState(() {});
                                  controller.saveSignupData(
                                      index: selectedIndex);
                                } else {
                                  if (widget.isFrmProfile) {
                                    updateProfile(controller);
                                  } else {
                                    signupUser(controller);
                                  }
                                }
                              }
                            },
                            child: Text(
                              selectedIndex >= 3 ? "Next" : "Next",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signupUser(RegisterController controller) {
    log("${controller.registerData()}", name: 'registerData');

    controller.registerUser().then((value) {
      if (value.isSuccess) {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          getCustomRoute(child: const ProfileUnderReviewScreen()),
          (route) => false,
        );
        showCustomToast(msg: value.message);
        final auth = Get.find<AuthController>();
        auth.getUserProfileData().then((value) {
          if (value.isSuccess) {
            if (auth.userModel?.status == 'active') {
              Navigator.of(context).pushAndRemoveUntil(getCustomRoute(child: const DashboardScreen()), (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(getCustomRoute(child: const ProfileUnderReviewScreen()), (route) => false);
            }
          }
        });
      } else {
        showCustomToast(msg: value.message, toastType: ToastType.warning);
      }
    });
  }

  void updateProfile(RegisterController controller) {
    controller.updateProfile().then((val) {
      if (val.isSuccess) {
        if (!mounted) return;
        Navigator.pop(context);
        showCustomToast(msg: 'Profile updated successfully');
        Get.find<AuthController>().getUserProfileData();
      }
    });
  }
}
