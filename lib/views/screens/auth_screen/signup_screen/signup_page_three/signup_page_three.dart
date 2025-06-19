import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:village_wheels/controllers/location_controller.dart';
import 'package:village_wheels/controllers/register_controller.dart';
import 'package:village_wheels/generated/assets.dart';
import 'package:village_wheels/services/input_decoration.dart';
import 'package:village_wheels/services/route_helper.dart';

import 'package:village_wheels/views/base/custom_image.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/choose_location_screen/choose_location_screen.dart';

import '../signup_four_screen/signup_page_four.dart';
import 'components/location_custom_widget.dart';

class SignupPageThree extends StatefulWidget {
  const SignupPageThree({super.key});

  @override
  State<SignupPageThree> createState() => _SignupPageThreeState();
}

class _SignupPageThreeState extends State<SignupPageThree> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      final controller = Get.find<LocationController>();
      if (controller.location != null) return;
      Navigator.of(context).push(getCustomRoute(child: ChooseLocationScreen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<RegisterController>(
            builder: (registerCtrl) {
              return GetBuilder<LocationController>(
                builder: (locationCtrl) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageAndTitleWidget(
                        image: Assets.imagesAddress,
                        title: "Address Details",
                      ),
                      const SizedBox(height: 25),
                      LocationCustomWidget(),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: registerCtrl.streetOne,
                        keyboardType: TextInputType.text,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: 'Address Line 1',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: registerCtrl.streetTwo,
                        keyboardType: TextInputType.text,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: 'Address Line 2 (Optional)',
                          label: "Address Line 2 (Optional)",
                          labelColor: Color(0xffF97316),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        readOnly: true,
                        controller: registerCtrl.state,
                        keyboardType: TextInputType.text,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: Color(0xff1E3A8A),
                          borderWidth: 0.5,
                          borderRadius: 8,
                          label: "State",
                          labelColor: Color(0xffF97316),
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: registerCtrl.city,
                              keyboardType: TextInputType.text,
                              decoration: CustomDecoration.inputDecoration(
                                floating: true,
                                label: 'City Name',
                                labelColor: Color(0xffF97316),
                                borderColor: Color(0xff1E3A8A),
                                borderRadius: 8,
                                borderWidth: 0.5,
                                contentPadding: EdgeInsets.all(15),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              enabled: false,
                              controller: registerCtrl.pincode,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),
                              ],
                              keyboardType: Platform.isIOS
                                  ? TextInputType.numberWithOptions(
                                      signed: true, decimal: true)
                                  : TextInputType.number,
                              decoration: CustomDecoration.inputDecoration(
                                floating: true,
                                label: 'Pin Code',
                                borderRadius: 8,
                                labelColor: Color(0xffF97316),
                                borderColor: Color(0xff1E3A8A),
                                borderWidth: 0.5,
                                contentPadding: EdgeInsets.all(15),
                              ),
                              validator: (value) {
                                if (value!.isEmpty && value.length < 6) {
                                  return "Required";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
