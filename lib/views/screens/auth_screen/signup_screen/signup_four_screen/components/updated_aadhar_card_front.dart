import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/services/extra_methods.dart';
import 'package:village_wheels_delivery_boy/services/input_decoration.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/views/base/image_picker_sheet.dart';
import 'package:village_wheels_delivery_boy/views/screens/auth_screen/signup_screen/components/components/show_image.dart';

import '../../components/components/icons_widget.dart';

class UpdatedAadharCardFront extends StatefulWidget {
  const UpdatedAadharCardFront({super.key});

  @override
  State<UpdatedAadharCardFront> createState() => _UpdatedAadharCardFrontState();
}

class _UpdatedAadharCardFrontState extends State<UpdatedAadharCardFront> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (regiCtrl) {
        return GetBuilder<AuthController>(
          builder: (authCtrl) {
            // final data = authCtrl.userModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  readOnly: false,
                  controller: regiCtrl.aadharCardNumber,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  decoration: CustomDecoration.inputDecoration(
                    floating: true,
                    label: "Enter Aadhar Card Number ",
                    labelColor: const Color(0xffF97316),
                    borderColor: const Color(0xff1E3A8A),
                    borderWidth: 0.5,
                    borderRadius: 8,
                    hint: "Aadhar Card",
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty && !ExtraMethods.isValidAadhaar(value)) {
                      return "Invalid Aadhar Number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Upload Aadhar Card ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.deepOrange,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (regiCtrl.selectedAadhaarCard != null) {
                                Navigator.of(context).push(getCustomRoute(child: ShowImage(img: regiCtrl.selectedAadhaarCard!)));
                              } else {
                                await getImageBottomSheet(context).then((value) {
                                  if (value != null) regiCtrl.selectFiles(isAadharCard: true, val: value);
                                });
                              }
                            },
                            child: Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFB0B8C7),
                                  style: BorderStyle.solid,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFF5F5F5),
                              ),
                              child: regiCtrl.selectedAadhaarCard != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        regiCtrl.selectedAadhaarCard!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.camera_alt,
                                            color: Color(0xFF233A7D),
                                            size: 32),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Front Image",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: const Color(0xff233A7D),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          if (regiCtrl.selectedAadhaarCard != null)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await getImageBottomSheet(context)
                                          .then((value) {
                                        if (value != null) {
                                          regiCtrl.selectFiles(
                                              isAadharCard: true, val: value);
                                        }
                                      });
                                    },
                                    icon: const IconsWidget(
                                      icon: Icons.edit,
                                    ),
                                  ),
                                  if (regiCtrl.selectedAadhaarCard != null)
                                    IconButton(
                                      onPressed: () {
                                        regiCtrl.removeFiles(
                                            isAadharCard: true);
                                      },
                                      icon: const IconsWidget(
                                        icon: Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (regiCtrl.selectedAadhaarBackCard != null) {
                                Navigator.of(context).push(
                                  getCustomRoute(
                                    child: ShowImage(
                                        img: regiCtrl.selectedAadhaarBackCard!),
                                  ),
                                );
                                return;
                              }
                              await getImageBottomSheet(context).then((value) {
                                if (value != null) {
                                  regiCtrl.selectFiles(
                                      isAadharBackCard: true, val: value);
                                }
                              });
                            },
                            child: Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFB0B8C7),
                                  style: BorderStyle.solid,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFF5F5F5),
                              ),
                              child: regiCtrl.selectedAadhaarBackCard != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        regiCtrl.selectedAadhaarBackCard!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.camera_alt,
                                            color: Color(0xFF233A7D),
                                            size: 32),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Back Image",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: const Color(0xff233A7D),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          //
                          if (regiCtrl.selectedAadhaarBackCard != null)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await getImageBottomSheet(context)
                                            .then((value) {
                                          if (value != null) {
                                            regiCtrl.selectFiles(
                                                isAadharBackCard: true,
                                                val: value);
                                          }
                                        });
                                      },
                                      icon: const IconsWidget(
                                        icon: Icons.edit,
                                      )),
                                  if (regiCtrl.selectedAadhaarBackCard != null)
                                    IconButton(
                                      onPressed: () {
                                        regiCtrl.removeFiles(
                                            isAadharBackCard: true);
                                      },
                                      icon: const IconsWidget(
                                        icon: Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
