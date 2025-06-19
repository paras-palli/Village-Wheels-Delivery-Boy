import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/input_decoration.dart';
import 'components/image_title.dart';

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
                        title: "Bank Details",
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: controller.bankName,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: const Color(0xff1E3A8A),
                          borderWidth: 0.5,
                          borderRadius: 15,
                          label: "Bank Name",
                          labelColor: const Color(0xffF97316),
                          hint: "Enter your bank’s name",
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xff6B7280),
                                  ),
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xffF97316),
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
                          hint: "Enter Account Holder’s Name",
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xff6B7280),
                                  ),
                          label: "Account Holder's Name ",
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xffF97316),
                                  ),
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
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xff6B7280),
                                    ),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xffF97316),
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
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xffF97316),
                                    ),
                                borderRadius: 8,
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
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xffF97316),
                                  ),
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
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xffF97316),
                                  ),
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

                      ),
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
