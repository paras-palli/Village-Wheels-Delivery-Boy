import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import '../../../../../generated/assets.dart';
import '../../../../../services/input_decoration.dart';
import '../../../../../services/theme.dart';
import 'components/choose_image_selection_bottom_sheet.dart';
import 'components/image_title.dart';
import 'components/remove_image_dailog.dart';
import 'components/show_image.dart';

class SignupPageThree extends StatefulWidget {
  const SignupPageThree({super.key, this.isFrmProfile = false});
  final bool isFrmProfile;

  @override
  State<SignupPageThree> createState() => _SignupPageThreeState();
}

class _SignupPageThreeState extends State<SignupPageThree> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<RegisterController>(
            builder: (registerCtrl) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ImageAndTitleWidget(
                    image: Assets.imagesKycDetails,
                    title: "KYC Details",
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _pageController.jumpToPage(0);
                            setState(() => _currentPage = 0);
                          },
                          child: Column(
                            children: [
                              Text("Aadhar Card",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Container(
                                height: 2,
                                color: _currentPage == 0
                                    ? primaryColor
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _pageController.jumpToPage(1);
                            setState(() => _currentPage = 1);
                          },
                          child: Column(
                            children: [
                              Text("Pan Card",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Container(
                                height: 2,
                                color: _currentPage == 1
                                    ? primaryColor
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 600,
                    child: PageView.builder(
                      controller: _pageController, // ← Add this
                      itemCount: 2,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        return index == 0
                            ? const AadharCardSection()
                            : const PancardSection();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AadharCardSection extends StatelessWidget {
  const AadharCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (registerCtrl) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(overflow: TextOverflow.ellipsis),
              controller: registerCtrl.aadharCardNumber,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(12)
              ],
              keyboardType: Platform.isIOS
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.number,
              validator: (v) => v!.isEmpty ? "Enter Aadhar Card Number" : null,
              decoration: CustomDecoration.inputDecoration(
                  borderRadius: 10,
                  bgColor: const Color(0xffF9FAFB),
                  borderColor: const Color(0xffCDCDCD),
                  borderWidth: 1,
                  label: 'Aadhar Card',
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
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
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
                              .updateAadhaarCardImage(selectedFile);
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
                      child: registerCtrl.selectedAadhaarCard == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, color: primaryColor),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48.0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "Upload Aadhar Card Frontside ",
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
                                                .selectedAadhaarCard!),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      registerCtrl.selectedAadhaarCard!,
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
                                            color:
                                                Colors.black.withValues(alpha: 0.2),
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
                                            title: 'Aadhar Card Frontside'),
                                      );

                                      if (result == true) {
                                        registerCtrl.removeFiles(
                                            isAadharCard: true);
                                      } else {}
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withValues(alpha: 0.2),
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
                              .updateAadhaarBackCardImage(selectedFile);
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
                      child: registerCtrl.selectedAadhaarBackCard == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, color: primaryColor),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48.0),
                                  child: Text(
                                    "Upload Aadhar Card Backside  ",
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
                                                .selectedAadhaarBackCard!),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      registerCtrl.selectedAadhaarBackCard!,
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
                                            color:
                                                Colors.black.withValues(alpha: 0.2),
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
                                            title: 'Aadhar Card Backside'),
                                      );

                                      if (result == true) {
                                        registerCtrl.removeFiles(
                                            isAadharBackCard: true);
                                      } else {}
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withValues(alpha: 0.2),
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
        );
      },
    );
  }
}

class PancardSection extends StatelessWidget {
  const PancardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (registerCtrl) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(overflow: TextOverflow.ellipsis),
              controller: registerCtrl.panCardNumber,
              validator: (v) => v!.isEmpty ? "Enter Pan Card Number" : null,
              decoration: CustomDecoration.inputDecoration(
                  borderRadius: 10,
                  bgColor: const Color(0xffF9FAFB),
                  borderColor: const Color(0xffCDCDCD),
                  borderWidth: 1,
                  label: 'Pan Card',
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
            GestureDetector(
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
                          .updatePancardImage(selectedFile);
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
                  child: registerCtrl.selectedPancard == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: primaryColor),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 48.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Upload Pan Card  ",
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
                                Navigator.push(
                                    context,
                                    getCustomRoute(
                                        child: ShowImage(
                                      img: registerCtrl.selectedPancard,
                                    )));
                              },
                              child: ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  registerCtrl.selectedPancard!,
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
                                        title: 'Aadhar Pan Card'),
                                  );

                                  if (result == true) {
                                    registerCtrl.removeFiles(isPancard: true);
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
              ),
            ),
          ],
        );
      },
    );
  }
}
