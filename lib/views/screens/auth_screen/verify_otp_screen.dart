import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/otp_controller.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/common_button.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_toast.dart';
import '../../../controllers/auth_controller/auth_controller.dart';
import '../../../../services/route_helper.dart';
import '../dashboard_screen/dashboard_screen.dart';
import 'components/profile_under_review_screen.dart';
import 'components/resend_otp_widget.dart';
import 'signup_screen/signup_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: GetBuilder<OTPAutofillController>(
          dispose: (_) => Get.find<OTPAutofillController>().currentCode = '',
          initState: (_) =>
              Get.find<OTPAutofillController>().startResendOtpTimer(),
          builder: (otpController) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const CustomImage(
                      height: 130,
                      path: Assets.imagesOtpLogin,
                      width: 190,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enter Verification Code",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: primaryColor),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'OTP sent to  ',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: secondaryColor),
                        children: [
                          TextSpan(
                            text: '+91 $phoneNumber',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: secondaryColor),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10),
                      child: PinFieldAutoFill(
                        currentCode: otpController.currentCode,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder:
                              const FixedColorBuilder(Colors.grey),
                        ),
                        onCodeChanged: (code) async {
                          if (code == null) return;
                          otpController.updateCurrentCode(code);
                          if (otpController.currentCode.length == 4) {
                            FocusScope.of(context).unfocus();
                            verifyOtp(context, otpController,
                                Get.find<AuthController>());
                          }
                        },
                        codeLength: 4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (otpController.isTextVisible)
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'Please wait for ${otpController.resendOtpTimer} seconds to resend the OTP',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(),
                          children: [
                            TextSpan(
                              text: '\nResend OTP',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: otpController.isResendOtpEnabled
                                        ? primaryColor
                                        : Colors.grey,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = otpController.isResendOtpEnabled
                                    ? otpController.startResendOtpTimer
                                    : null,
                            ),
                          ],
                        ),
                      ),
                    if (!otpController.isTextVisible)
                      ResendOtpWidget(phoneNumber: phoneNumber),
                    const SizedBox(height: 20),
                    GetBuilder<AuthController>(builder: (authController) {
                      return CustomButton(
                        isLoading: authController.isLoading,
                        onTap: () =>
                            verifyOtp(context, otpController, authController),
                        child: const Text(
                          "Verify OTP",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //------------otp verify-----------
  void verifyOtp(BuildContext context, OTPAutofillController otpController,
      AuthController authController) {
    if (otpController.currentCode.isNotEmpty) {
      authController
          .verifyOtp(otp: otpController.currentCode, phone: phoneNumber)
          .then((value) {
        if (value.isSuccess) {
          log(value.message.toString(), name: 'OtpData');
          if ((value.data as Map)['new']) {
            if (!context.mounted) return;

            Navigator.pushAndRemoveUntil(
              context,
              getCustomRoute(child: const SignupScreen()),
              (route) => false,
            );
          } else {
            authController.getUserProfileData().then(
              (value) {
                if (value.isSuccess) {
                  if (!context.mounted) return;

                  if (authController.userModel?.status == 'pending') {
                    Navigator.of(context).pushAndRemoveUntil(
                        getCustomRoute(child: const ProfileUnderReviewScreen()),
                        (route) => false);
                  } else if (authController.userModel?.status == 'active') {
                    Navigator.of(context).pushAndRemoveUntil(
                        getCustomRoute(child: const DashboardScreen()),
                        (route) => false);
                  }
                }
              },
            );
          }
        } else {
          showCustomToast(msg: value.message, toastType: ToastType.warning);
        }
      });
    } else {
      showCustomToast(msg: 'Please Enter OTP!', toastType: ToastType.warning);
    }
  }
}
