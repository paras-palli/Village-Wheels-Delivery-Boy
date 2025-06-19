import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/otp_controller.dart';
import 'package:village_wheels_delivery_boy/services/extensions.dart';
import 'package:village_wheels_delivery_boy/services/input_decoration.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/common_button.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';

import 'package:village_wheels_delivery_boy/views/base/custom_toast.dart';
import 'package:village_wheels_delivery_boy/views/screens/auth_screen/verify_otp_screen.dart';

import 'components/term_and_condition_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomImage(
                      width: 200,
                      height: 200,
                      path: Assets.imagesLogin,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enter Your Mobile Number",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "We will send you a confirmation code",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: CustomDecoration.inputDecoration(
                        borderRadius: 4,
                        floating: true,
                        label: 'Mobile Number',
                        icon: const Icon(
                          Icons.phone_in_talk_outlined,
                          size: 19,
                          color: Color(0xFF130F26),
                        ),
                        hint: 'Enter your mobile number',
                      ),
                      validator: (val) {
                        if (val.isNotValid) {
                          return 'Enter Mobile Number';
                        } else if (val?.length != 10) {
                          return 'Enter 10 Digit Mobile Number';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    const SizedBox(height: 50),
                    GetBuilder<AuthController>(
                      builder: (authController) {
                        return CustomButton(
                          isLoading: authController.isLoading,
                          radius: 5,
                          elevation: 0,
                          onTap: () async {
                            Map<String, dynamic> data = {
                              'phone': _phoneController,
                              'app_signature':
                              await Get.find<OTPAutofillController>().getAppSignature(),
                            };
                            log('$data');
                            if (_formKey.currentState!.validate()) {
                              authController.generatedOtp(data: data).then((value) {
                                if (value.isSuccess) {
                                  Navigator.push(
                                    context,
                                    getCustomRoute(
                                      child: OtpVerificationScreen(phoneNumber: _phoneController.text.trim()),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                } else {
                                  showCustomToast(msg: value.message, toastType: ToastType.warning);
                                }
                              });
                            }
                          },
                          child: const Text(
                            "Get OTP",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TermsAndConditionsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
