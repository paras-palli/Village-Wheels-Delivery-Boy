import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/input_decoration.dart';

import '../signup_four_screen/components/updated_cnacelled_check_image.dart';
import '../signup_four_screen/signup_page_four.dart';

class SignUpPageFive extends StatelessWidget {
  const SignUpPageFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AuthController>(
            builder: (authCtrl) {
              return GetBuilder<RegisterController>(
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ImageAndTitleWidget(
                        image: Assets.imagesBank,
                        title: "Bank Details (Optional)",
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        readOnly: false,
                        controller: controller.bankName,
                        keyboardType: TextInputType.text,
                        decoration: CustomDecoration.inputDecoration(
                          suffix: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              Assets.svgsDropdown,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          floating: true,
                          borderColor: const Color(0xff1E3A8A),
                          borderWidth: 0.5,
                          borderRadius: 8,
                          label: "Bank Name",
                          labelColor: const Color(0xffF97316),
                          hint: "Select Your Bank",
                          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff6B7280),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        readOnly: false,
                        controller: controller.payeeName,
                        keyboardType: TextInputType.text,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: const Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: "Enter Account Holder's Name",
                          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff6B7280),
                          ),
                          label: "Account Holder's Name ",
                          labelColor: const Color(0xffF97316),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: false,
                              controller: controller.ifscCode,
                              keyboardType: TextInputType.number,
                              decoration: CustomDecoration.inputDecoration(
                                floating: true,
                                label: 'IFSC Code',
                                hint: "Enter IFSC Code",
                                hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xff6B7280),
                                ),
                                labelColor: const Color(0xffF97316),
                                borderColor: const Color(0xff1E3A8A),
                                borderRadius: 8,
                                borderWidth: 0.5,
                                contentPadding: const EdgeInsets.all(15),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: controller.branchName,
                              readOnly: false,
                              enabled: true,
                              keyboardType: TextInputType.text,
                              decoration: CustomDecoration.inputDecoration(
                                floating: true,
                                label: 'Branch',
                                hint: "Ener Branch",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xff6B7280),
                                    ),
                                borderRadius: 8,
                                labelColor: const Color(0xffF97316),
                                borderColor: const Color(0xff1E3A8A),
                                borderWidth: 0.5,
                                contentPadding: const EdgeInsets.all(15),
                              ),
                              // validator: (val) {
                              //   if (val!.isEmpty) {
                              //     return "Branch can't be empty!";
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.accountNumber,
                        readOnly: false,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: const Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: 'Enter Account Number',
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xff6B7280),
                                  ),
                          label: "Account Number",
                          labelColor: const Color(0xffF97316),
                        ),
                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return "Account Number can't be empty!";
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.reEnterAccountNumber,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: const Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: 'Re-Enter Account Number',
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xff6B7280),
                                  ),
                          label: "Re-Enter Number",
                          labelColor: const Color(0xffF97316),
                        ),
                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return "Account Number can't be empty!";
                        //   }
                        //   if (val != controller.accountNumber.text) {
                        //     return "Account numbers do not match!";
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Upload Cancelled Check Photo",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.deepOrange,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 10),
                      const UpdatedCancelledCheckImage()
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
