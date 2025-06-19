import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/auth_controller/register_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../../services/input_decoration.dart';
import '../../../../../services/route_helper.dart';
import '../../../../../services/theme.dart';
import 'components/choose_image_selection_bottom_sheet.dart';
import 'components/image_title.dart';
import 'components/remove_image_dailog.dart';
import 'components/show_image.dart';

class SignupPageFour extends StatefulWidget {
  const SignupPageFour({super.key});

  @override
  State<SignupPageFour> createState() => _SignupPageFourState();
}

class _SignupPageFourState extends State<SignupPageFour> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (registerCtrl) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ImageAndTitleWidget(
                image: Assets.imagesVehichelInfo,
                title: "Vehicle  Information",
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: registerCtrl.vehiclenumbercontroller,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(overflow: TextOverflow.ellipsis),
                maxLines: null,
                minLines: 1,
                decoration: CustomDecoration.inputDecoration(
                    borderRadius: 10,
                    bgColor: const Color(0xffF9FAFB),
                    borderColor: const Color(0xffCDCDCD),
                    borderWidth: 1,
                    label: 'Vehicle Number',
                    floating: true,
                    hint: "Enter Vehicle Number",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.grey.shade600),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: secondaryColor)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Upload Document",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => ChooseImageSelectionBottomSheet(
                          onImageSelected: (File selectedFile) {
                            Get.find<RegisterController>()
                                .updateDrivingLicenseImage(selectedFile);
                          },
                        ),
                      );
                    },
                    child: DottedBorder(
                      color: Colors.black,
                      radius: const Radius.circular(20),
                      borderType: BorderType.RRect,
                      strokeWidth: 1,
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        alignment: Alignment.center,
                        child: registerCtrl.selectedDrivingLicense == null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, color: primaryColor),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Upload License",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: primaryColor),
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        getCustomRoute(
                                          child: ShowImage(
                                              img: registerCtrl
                                                  .selectedDrivingLicense!),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        registerCtrl.selectedDrivingLicense!,
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
                                              color: Colors.black
                                                  .withValues(alpha: 0.2),
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
                                    right: 40,
                                    top: 2,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final result = await showDialog<bool>(
                                          context: context,
                                          builder: (_) => const RemoveImageDialog(
                                              title: 'Delivery License '),
                                        );
          
                                        if (result == true) {
                                          registerCtrl.removeFiles(
                                              isDrivingLicense: true);
                                        } else {}
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.2),
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
                    ),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => ChooseImageSelectionBottomSheet(
                          onImageSelected: (File selectedFile) {
                            Get.find<RegisterController>()
                                .updateRcBookImage(selectedFile);
                          },
                        ),
                      );
                    },
                    child: DottedBorder(
                      color: Colors.black,
                      radius: const Radius.circular(20),
                      borderType: BorderType.RRect,
                      strokeWidth: 1,
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        alignment: Alignment.center,
                        child: registerCtrl.selectedRcBook == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, color: primaryColor),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Text(
                                      "Upload RC Book",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: primaryColor),
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        getCustomRoute(
                                          child: ShowImage(
                                              img: registerCtrl
                                                  .selectedRcBook!),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        registerCtrl.selectedRcBook!,
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
                                              color: Colors.black
                                                  .withValues(alpha: 0.2),
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
                                    right: 40,
                                    top: 2,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final result = await showDialog<bool>(
                                          context: context,
                                          builder: (_) => const RemoveImageDialog(
                                              title: 'RC Book '),
                                        );
          
                                        if (result == true) {
                                          registerCtrl.removeFiles(
                                              isRcBook: true);
                                        } else {}
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.2),
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
                    ),
                  ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
