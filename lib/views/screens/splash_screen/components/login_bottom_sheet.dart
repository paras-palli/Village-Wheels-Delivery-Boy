import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/views/base/common_button.dart';

import '../../../../controllers/auth_controller/otp_controller.dart';
import '../../../../services/input_decoration.dart';
import '../../../../services/route_helper.dart';
import '../../../../services/theme.dart';
import '../../../base/custom_toast.dart';
import '../../auth_screen/verify_otp_screen.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Become a Village Wheels delivery partner today!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: primaryColor,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: controller.phoneController,
                      keyboardType: Platform.isIOS
                          ? const TextInputType.numberWithOptions(
                              signed: true, decimal: true)
                          : TextInputType.number,
                      decoration: CustomDecoration.inputDecoration(
                        borderRadius: 15,
                        borderColor: primaryColor,
                        label: 'Phone Number',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: secondaryColor),
                        icon: const Icon(
                          Icons.phone_outlined,
                          size: 19,
                          color: Color(0xFF130F26),
                        ),
                        hint: 'Enter your mobile number',
                        hintStyle:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: const Color(0xff6B7280),
                                  fontWeight: FontWeight.w300,
                                ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'Please enter a valid 10-digit number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'OTP will be sent to this number',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: primaryColor,
                        ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    isLoading: controller.isLoading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          'phone': controller.phoneController.text.trim(),
                          'app_signature':
                              await Get.find<OTPAutofillController>()
                                  .getAppSignature(),
                        };
                        log('$data');
                        controller.generatedOtp(data: data).then((value) {
                          if (value.isSuccess) {
                            if (!context.mounted) return;
                            Navigator.push(
                              context,
                              getCustomRoute(
                                child: OtpVerificationScreen(
                                    phoneNumber:
                                        controller.phoneController.text.trim()),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          } else {
                            showCustomToast(
                                msg: value.message,
                                toastType: ToastType.warning);
                          }
                        });
                      }
                    },
                    title: "Get OTP",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
