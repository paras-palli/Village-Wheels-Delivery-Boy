import 'dart:async';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/location_controller.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import '../../../../../generated/assets.dart';
import '../../../../../services/input_decoration.dart';
import '../../../../base/common_button.dart';
import '../choose_location_screen/choose_location_screen.dart';

class SignupPageThree extends StatefulWidget {
  const SignupPageThree({super.key, this.isFrmProfile = false});
  final bool isFrmProfile;

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
      Navigator.of(context).push(getCustomRoute(child: const ChooseLocationScreen()));
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
                      Text(
                        'Address :',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 10),
                      locationCtrl.location != null
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      locationCtrl.location ?? '',
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  CustomButton(
                                    radius: 4,
                                    height: 30,
                                    elevation: 0,
                                    onTap: () {
                                      Navigator.of(context).push(getCustomRoute(child: const ChooseLocationScreen()));
                                    },
                                    child: Text(
                                      'Change',
                                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(getCustomRoute(child: const ChooseLocationScreen()));
                              },
                              child: TextFormField(
                                readOnly: true,
                                enabled: false,
                                decoration: CustomDecoration.inputDecoration(
                                  borderRadius: 8,
                                  borderColor: Colors.grey.shade400,
                                  label: 'Chose location from map',
                                  // hint: 'Chose',
                                  icon: const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Center(
                                      child: Icon(
                                        Icons.map_outlined,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: registerCtrl.streetOne,
                        decoration: CustomDecoration.inputDecoration(
                          borderRadius: 8,
                          borderColor: Colors.grey.shade400,
                          label: 'Address line 1',
                          hint: 'Enter your Address line 1',
                          icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.svgsFrame3,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(Color(0xFF292D32), BlendMode.srcIn),
                              ),
                            ),
                          ),
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
                        decoration: CustomDecoration.inputDecoration(
                          borderRadius: 8,
                          borderColor: Colors.grey.shade400,
                          label: 'Address line 2 (Optional)',
                          hint: 'Enter your address line 2',
                          icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.svgsFrame3,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(Color(0xFF292D32), BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        readOnly: true,
                        enabled: false,
                        controller: registerCtrl.pincode,
                        keyboardType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: true) : TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: CustomDecoration.inputDecoration(
                          borderRadius: 8,
                          borderColor: Colors.grey.shade400,
                          label: 'Pincode',
                          hint: 'Enter your Pincode',
                          icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.svgsFrame4,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(Color(0xFF292D32), BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty && value.length < 6) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        readOnly: true,
                        enabled: false,
                        controller: registerCtrl.state,
                        decoration: CustomDecoration.inputDecoration(
                          borderRadius: 8,
                          borderColor: Colors.grey.shade400,
                          label: 'State',
                          hint: 'Enter your State',
                          icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.svgsFrame5,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(Color(0xFF292D32), BlendMode.srcIn),
                              ),
                            ),
                          ),
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
                        readOnly: true,
                        enabled: false,
                        controller: registerCtrl.city,
                        decoration: CustomDecoration.inputDecoration(
                          borderRadius: 8,
                          borderColor: Colors.grey.shade400,
                          label: 'City',
                          hint: 'Enter your City',
                          icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.svgsFrame6,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(Color(0xFF292D32), BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
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
