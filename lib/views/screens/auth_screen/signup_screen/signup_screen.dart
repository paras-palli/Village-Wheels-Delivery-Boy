import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:village_wheels/views/screens/DashBoard/dashboard_screen.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/signup_page_three/signup_page_three.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/components/signup_page_two.dart';

import '../../../../controllers/auth_controller/auth_controller.dart';
import '../../../../controllers/register_controller.dart';
import '../../../../services/route_helper.dart';
import '../../../base/common_button.dart';
import '../under_review_screen.dart';
import 'components/signup_page_five.dart';
import 'signup_four_screen/signup_page_four.dart';
import 'components/signup_page_one.dart';
import '../../../../controllers/location_controller.dart';

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
      final locationCtrl = Get.find<LocationController>();
      if (locationCtrl.states.isEmpty) {
        log('Loading states...', name: 'RegisterUser');
        final statesResponse = await locationCtrl.getStates();
        if (!statesResponse.isSuccess) {
          throw Exception('Failed to load states: ${statesResponse.message}');
        }
        log('States loaded successfully', name: 'RegisterUser');
      }
      signupPages = [
        const SignupPageOne(),
        const SignUpPageTwo(),
        const SignupPageThree(),
        SignupPageFour(),
        const SignUpPageFive(),
      ];
      final authCtrl = Get.find<AuthController>();
      if (widget.isFrmProfile) {
        authCtrl.updateProfileData();
        //---updated---
      } else {
        if (authCtrl.userModel != null) {
          authCtrl.setNumber();
        }
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
                                          ? Color(0xFFE6ECF5)
                                          : Color(0xFF233A7D),
                                      height: 8,
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE6ECF5),
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
                                              : Color(0xFF233A7D),
                                        ),
                                        child: Center(
                                          child: selectedIndex > i
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  '${i + 1}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: selectedIndex < i
                                                            ? Color(0xFF233A7D)
                                                            : Colors.white,
                                                      ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: selectedIndex < i
                                          ? Color(0xFFE6ECF5)
                                          : Color(0xFF233A7D),
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
                                style: TextStyle(
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
                              final locationCtrl =
                                  Get.find<LocationController>();
                              if (formkey.currentState!.validate()) {
                                if (selectedIndex < signupPages.length - 1) {
                                  if (selectedIndex == 1 &&
                                      controller.selectedBussiness.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please select a bussiness");

                                    return;
                                  }
                                  if (selectedIndex == 2 &&
                                      locationCtrl.latLng == null) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please select a location on the map");
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
    log("${controller.registerData()}");
    // if (false)
    controller.registerUser().then((value) {
      if (value.isSuccess) {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          getCustomRoute(child: const ProfileUnderReviewScreen()),
          (route) => false,
        );
        Fluttertoast.showToast(msg: value.message);
        final auth = Get.find<AuthController>();
        auth.getUserProfileData().then((value) {
          if (value.isSuccess) {
            if (auth.userModel?.status == 'active') {
              Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const DashboardScreen()),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                getCustomRoute(child: const ProfileUnderReviewScreen()),
                (route) => false,
              );
            }
          } else {}
        });
      } else {
        Fluttertoast.showToast(msg: value.message);
      }
    });
  }

  void updateProfile(RegisterController controller) {
    controller.updateProfile().then((val) {
      if (val.isSuccess) {
        if (!mounted) return;
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Profile updated successfully');
        Get.find<AuthController>().getUserProfileData();
      }
    });
  }
}
