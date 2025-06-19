import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/otp_controller.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_toast.dart';

class ResendOtpWidget extends StatelessWidget {
  final String phoneNumber;
  const ResendOtpWidget({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPAutofillController>(builder: (controller) {
      return GestureDetector(
        onTap: controller.resendOtpTimer != 0
            ? null
            : () async {
          Map<String, dynamic> data = {
            'phone': phoneNumber,
            'app_signature': await controller.getAppSignature(),
          };
          log('$data');
          Get.find<AuthController>().login(data: data).then((value) {
            showCustomToast(msg: value.message, toastType: !value.isSuccess ? ToastType.warning : null);
            if (value.isSuccess) controller.startResendOtpTimer();
          });
        },
        child: Column(
          children: [
            Text(
              "Didn't receive the code?",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            controller.resendOtpTimer != 0
                ? Text(
              ' in ${controller.resendOtpTimer} seconds',
            ) : Text(
              'Resend OTP',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
