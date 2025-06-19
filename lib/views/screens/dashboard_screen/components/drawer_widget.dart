import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/services/enums/settings_enum.dart';
import 'package:village_wheels_delivery_boy/services/extensions.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/common_button.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_html_widget.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_toast.dart';
import 'package:village_wheels_delivery_boy/views/base/dialogs/delete_dialogue.dart';
import 'package:village_wheels_delivery_boy/views/base/dialogs/logout_dialog.dart';
import 'package:village_wheels_delivery_boy/views/screens/splash_screen/splash_screen.dart';

import '../../auth_screen/signup_screen/signup_screen.dart';
import 'drawer_item_widget.dart';

class DrawerScreens extends StatelessWidget {
  const DrawerScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: primaryColor.lighten(.55),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const CustomImage(
                        path: Assets.imagesAppLogo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<AuthController>(builder: (auth) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (auth.userModel?.name.toString() ?? 'NA').capitalizeFirstOfEach,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            auth.userModel?.email ?? 'NA',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomButton(
                              elevation: 0,
                              height: 40,
                              radius: 4,
                              onTap: () {
                                Navigator.of(context).push(getCustomRoute(
                                  child: const SignupScreen(
                                    isFrmProfile: true,
                                  )),
                                );
                              },
                              child: Text(
                                'Edit Profile',
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Divider(color: Color(0xFFEDEDED)),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              DrawerItemWidget(
                title: 'Privacy Policy',
                icon: Assets.svgsFrame,
                onTap: () {
                  Navigator.of(context).push(
                    getCustomRoute(
                      child: const CustomHtmlScreen(
                        title: 'Privacy Policy',
                        businessSettingName: BusinessSettingName.privacyPolicy,
                      ),
                    ),
                  );
                },
              ),
              DrawerItemWidget(
                title: 'Terms & Conditions',
                icon: Assets.svgsFrame,
                onTap: () {
                  Navigator.of(context).push(
                    getCustomRoute(
                      child: const CustomHtmlScreen(
                        title: 'Terms & Conditions',
                        businessSettingName: BusinessSettingName.termsAndCondition,
                      ),
                    ),
                  );
                },
              ),
              DrawerItemWidget(
                title: 'About Us',
                icon: Assets.svgsInfoCircle,
                onTap: () {
                  Navigator.of(context).push(
                    getCustomRoute(
                      child: const CustomHtmlScreen(
                        title: 'About Us',
                        businessSettingName: BusinessSettingName.aboutUs,
                      ),
                    ),
                  );
                },
              ),
              DrawerItemWidget(
                title: 'Contact Us',
                icon: Assets.svgsMessages,
                onTap: () {
                  Navigator.of(context).push(
                    getCustomRoute(
                      child: const CustomHtmlScreen(
                        title: 'Contact Us',
                        businessSettingName: BusinessSettingName.contactUs,
                      ),
                    ),
                  );
                },
              ),
              DrawerItemWidget(
                title: 'Delete Account',
                icon: Assets.svgsDelete,
                isLogOut: true,
                onTap: () {
                  showDeleteDialogue(context: context).then((value) {
                    if (value == true) {
                      Get.find<AuthController>().logoutUser().then((value) {
                        if (value.isSuccess) {
                          Navigator.pushAndRemoveUntil(context, getCustomRoute(child: const SplashScreen()), (route) => false);
                          showCustomToast(msg: 'Logout Successful');
                        } else {
                          showCustomToast(msg: 'Something Went Wrong!!!', toastType: ToastType.error);
                        }
                      });
                    }
                  });
                },
              ),
              DrawerItemWidget(
                title: 'Log Out',
                icon: Assets.svgsLogout,
                isLogOut: true,
                onTap: () {
                  showLogoutDialogue(context: context).then((value) {
                    if (value == true) {
                      Get.find<AuthController>().logoutUser().then((value) {
                        if (value.isSuccess) {
                          Navigator.pushAndRemoveUntil(context, getCustomRoute(child: const SplashScreen()), (route) => false);
                          showCustomToast(msg: 'Logout Successful');
                        } else {
                          showCustomToast(msg: 'Something Went Wrong!!!', toastType: ToastType.error);
                        }
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
