import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:village_wheels/views/base/custom_image.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/signup_four_screen/components/updated_cnacelled_check_image.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/signup_four_screen/signup_page_four.dart';

import '../../../../../controllers/auth_controller/auth_controller.dart';
import '../../../../../controllers/register_controller.dart';

import '../../../../../services/input_decoration.dart';

class SignUpPageFive extends StatelessWidget {
  const SignUpPageFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AuthController>(
            builder: (authCtrl) {
              //  final data = authCtrl.userModel;
              return GetBuilder<RegisterController>(
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageAndTitleWidget(
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
                          borderColor: Color(0xff1E3A8A),
                          borderWidth: 0.5,
                          borderRadius: 8,
                          label: "Bank Name",
                          labelColor: Color(0xffF97316),
                          hint: "Select Your Bank",
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff6B7280),
                                  ),
                        ),
                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return "Bank Name can't be empty!";
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        readOnly: false,
                        controller: controller.payeeName,
                        keyboardType: TextInputType.text,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: "Enter Account Holder's Name",
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff6B7280),
                                  ),
                          label: "Account Holder's Name ",
                          labelColor: Color(0xffF97316),
                        ),
                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return "Account Holder Name can't be empty!";
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 20),
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xff6B7280),
                                    ),
                                labelColor: Color(0xffF97316),
                                borderColor: Color(0xff1E3A8A),
                                borderRadius: 8,
                                borderWidth: 0.5,
                                contentPadding: EdgeInsets.all(15),
                              ),
                              // validator: (val) {
                              //   if (val!.isEmpty) {
                              //     return "IFSC can't be empty!";
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          SizedBox(width: 10),
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
                                      color: Color(0xff6B7280),
                                    ),
                                borderRadius: 8,
                                labelColor: Color(0xffF97316),
                                borderColor: Color(0xff1E3A8A),
                                borderWidth: 0.5,
                                contentPadding: EdgeInsets.all(15),
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
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.accountNumber,
                        readOnly: false,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: 'Enter Account Number',
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff6B7280),
                                  ),
                          label: "Account Number",
                          labelColor: Color(0xffF97316),
                        ),
                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return "Account Number can't be empty!";
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.reEnterAccountNumber,
                        decoration: CustomDecoration.inputDecoration(
                          floating: true,
                          borderColor: Color(0xff1E3A8A),
                          borderRadius: 8,
                          borderWidth: 0.5,
                          hint: 'Re-Enter Account Number',
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff6B7280),
                                  ),
                          label: "Re-Enter Number",
                          labelColor: Color(0xffF97316),
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
                      SizedBox(height: 20),
                      Text(
                        "Upload Cancelled Check Photo",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.deepOrange,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(height: 10),
                      updatedcancelledcheckimage()
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
