import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/otp_controller.dart';
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
      body: GetBuilder<OTPAutofillController>(
        dispose: (_) => Get.find<OTPAutofillController>().currentCode = '',
        initState: (_) => Get.find<OTPAutofillController>().startResendOtpTimer(),
        builder: (otpController) {
          return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomImage(
                  height: 200,
                  width: 300,
                  path: Assets.imagesOtpLogin,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 25),
                Text(
                  "Enter Verification Code",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'We have sent the verification to ',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                        text: '+91 $phoneNumber',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                PinFieldAutoFill(
                  currentCode: otpController.currentCode,
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder: const FixedColorBuilder(Colors.grey),
                  ),
                  onCodeChanged: (code) async {
                    if (code == null) return;
                    otpController.updateCurrentCode(code);
                    if (otpController.currentCode.length == 4) {
                      FocusScope.of(context).unfocus();
                      verifyOtp(context, otpController, Get.find<AuthController>());
                    }
                  },
                  codeLength: 4,
                ),
                const SizedBox(height: 20),
                if (otpController.isTextVisible)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Please wait for ${otpController.resendOtpTimer} seconds to resend the OTP',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                      children: [
                        TextSpan(
                          text: '\nResend OTP',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: otpController.isResendOtpEnabled ? const Color(0xff09596F) : Colors.grey,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = otpController.isResendOtpEnabled ? otpController.startResendOtpTimer : null,
                        ),
                      ],
                    ),
                  ),
                if (!otpController.isTextVisible) ResendOtpWidget(phoneNumber: phoneNumber),
                const SizedBox(height: 20),
                GetBuilder<AuthController>(builder: (authController) {
                  return CustomButton(
                    isLoading: authController.isLoading,
                    onTap: () => verifyOtp(context, otpController, authController),
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
    );
  }

  //------------otp verify-----------
  void verifyOtp(BuildContext context, OTPAutofillController otpController, AuthController authController) {
    if (otpController.currentCode.isNotEmpty) {
      authController.verifyOtp(otp: otpController.currentCode, phone: phoneNumber).then((value) {
        if (value.isSuccess) {
          log(value.message.toString(), name: 'OtpData');
          if ((value.data as Map)['new']) {
            Navigator.pushAndRemoveUntil(
              context,
              getCustomRoute(child: const SignupScreen()), (route) => false,
            );
          } else {
            authController.getUserProfileData().then((value) {
              if (value.isSuccess) {
                if (authController.userModel?.status == 'pending') {
                  Navigator.of(context).pushAndRemoveUntil(getCustomRoute(child: const ProfileUnderReviewScreen()), (route) => false);
                } else if (authController.userModel?.status == 'active') {
                  Navigator.of(context).pushAndRemoveUntil(getCustomRoute(child: const DashboardScreen()), (route) => false);
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
