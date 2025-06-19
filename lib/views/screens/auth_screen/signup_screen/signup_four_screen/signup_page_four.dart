import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/services/extra_methods.dart';
import 'package:village_wheels_delivery_boy/services/input_decoration.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';

import 'components/updated_aadhar_card_front.dart';
import 'components/updated_pan_card.dart';

class SignupPageFour extends StatelessWidget {
  SignupPageFour({super.key});

  final List<String> tabs = [
    'Aadhar Card',
    'Pan Card',
    'Business',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authCtrl) {
        return GetBuilder<RegisterController>(
          builder: (regiCtrl) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ImageAndTitleWidget(
                        image: Assets.svgsKyc,
                        title: 'KYC Details',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: List.generate(
                          tabs.length,
                          (i) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => regiCtrl.selectTab(i),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: regiCtrl.selectedTab == i
                                            ? const Color(0xFF233A7D)
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    tabs[i],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: regiCtrl.selectedTab == i
                                              ? const Color(0xff233A7D)
                                              : const Color(0xff6B7280),
                                          fontWeight: regiCtrl.selectedTab == i
                                              ? FontWeight.w500
                                              : FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (_) {
                          switch (regiCtrl.selectedTab) {
                            case 0:
                              return const UpdatedAadharCardFront();
                            case 1:
                              return const UpdatePanCardWidget();
                            case 2:
                              return const SizedBox.shrink();
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 260,
                      ),
                      if (regiCtrl.selectedTab == 2)
                        Center(
                          child: Text(
                            "Upload any one document for Business Proof : ",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: const Color(0xff6B7280),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      if (regiCtrl.selectedTab == 2)
                        Center(
                          child: Text(
                            "GST , registration Certificate , Pan card.",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: const Color(0xff263238),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class UpdatePanCardWidget extends StatelessWidget {
  const UpdatePanCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (regiCtrl) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            readOnly: false,
            controller: regiCtrl.panCardNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12),
            ],
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: "Enter Pan Card Number ",
              labelColor: const Color(0xffF97316),
              borderColor: const Color(0xff1E3A8A),
              borderWidth: 0.5,
              borderRadius: 8,
              hint: "Pan Card",
            ),
            validator: (value) {
              if (value!.isNotEmpty && !ExtraMethods.isValidPAN(value)) {
                return "Invalid Pan Number";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text(
            "Upload Pan Card Photo ",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.deepOrange,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 10),
          const updatedpanwidget()
        ],
      );
    });
  }
}

class ImageAndTitleWidget extends StatelessWidget {
  const ImageAndTitleWidget({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImage(
          path: image,
          height: 150,
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xff1E3A8A),
              ),
        ),
      ],
    );
  }
}
