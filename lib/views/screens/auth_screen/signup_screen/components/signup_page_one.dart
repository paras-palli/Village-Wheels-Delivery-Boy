import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/input_decoration.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../../services/route_helper.dart';
import '../../../../../services/theme.dart';
import 'components/choose_image_selection_bottom_sheet.dart';
import 'components/image_title.dart';
import 'components/remove_image_dailog.dart';
import 'components/show_image.dart';

class SignupPageOne extends StatelessWidget {
  const SignupPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImageAndTitleWidget(
            image: Assets.imagesDeliveryAgent,
            title: "Delivery agent Details",
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: Get.find<RegisterController>().name,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.black),
            keyboardType: TextInputType.text,
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: 'Full Name',
              labelStyle: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: secondaryColor),
              borderColor: const Color(0xff1E3A8A),
              borderWidth: 0.5,
              borderRadius: 15,
              hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xff6B7280),
                    fontWeight: FontWeight.w300,
                  ),
              contentPadding: const EdgeInsets.all(16),
              icon: const Icon(
                Icons.person_outline_outlined,
                size: 20,
                color: Color(0xffA2A2A4),
              ),
              hint: 'Enter Your Name',
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "Name can't be empty!";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          GetBuilder<RegisterController>(
            builder: (regCtrl) {
              return TextFormField(
                style: Theme.of(context).textTheme.labelLarge,
                readOnly: true,
                enabled: false,
                controller: TextEditingController(
                  text: '+91 ${regCtrl.phone.text}',
                ),
                keyboardType: TextInputType.text,
                decoration: CustomDecoration.inputDecoration(
                  floating: true,
                  label: 'Phone Number',
                  labelColor: const Color(0xffF97316),
                  borderColor: const Color(0xff1E3A8A),
                  borderWidth: 0.5,
                  borderRadius: 8,
                  icon: const Icon(
                    Icons.phone_outlined,
                    size: 20,
                    color: Color(0xffA2A2A4),
                  ),
                  hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xff6B7280),
                        fontWeight: FontWeight.w300,
                      ),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: secondaryColor),
                  contentPadding: const EdgeInsets.all(16),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: Get.find<RegisterController>().email,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.black),
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: 'Email Address(Optional)',
              labelStyle: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: secondaryColor),
              labelColor: const Color(0xffF97316),
              borderColor: const Color(0xff1E3A8A),
              borderWidth: 0.5,
              borderRadius: 8,
              icon: const Icon(
                Icons.email_outlined,
                size: 20,
                color: Color(0xffA2A2A4),
              ),
              hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xff6B7280),
                    fontWeight: FontWeight.w300,
                  ),
              hint: 'Enter Your Mail Address(Optional)',
              contentPadding: const EdgeInsets.all(16),
            ),
            // validator: (val) {
            //   if (val!.isNotEmpty && val.isEmail) {
            //     return "Enter valid email";
            //   }
            //   return null;
            // },
          ),
          const SizedBox(height: 20),
          Text(
            "Upload Profile Photo",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: secondaryColor),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => ChooseImageSelectionBottomSheet(
                  onImageSelected: (File selectedFile) {
                    Get.find<RegisterController>().updateprofileImage(selectedFile);
                  },
                ),
              );

            },
            child: GetBuilder<RegisterController>(
              builder: (controller) {
                return DottedBorder(
                  color: Colors.black,
                  radius: const Radius.circular(20),
                  borderType: BorderType.RRect,
                  strokeWidth: 1,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    child: controller.profileImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, color: primaryColor),
                              const SizedBox(height: 10),
                              Text(
                                "Upload Photo",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: primaryColor),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      getCustomRoute(
                                          child: ShowImage(
                                            img: controller.profileImage,
                                          )));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    controller.profileImage!,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 2,
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 4,
                                        )
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 44,
                                top: 2,
                                child: GestureDetector(
                                  onTap: () async {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => const RemoveImageDialog(
                                          title: 'Profile Photo'),
                                    );

                                    if (result == true) {
                                      controller.removeFiles(isProfile: true);
                                    } else {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 4,
                                        )
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
