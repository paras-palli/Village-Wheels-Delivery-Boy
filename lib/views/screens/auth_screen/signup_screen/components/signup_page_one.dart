import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_wheels/controllers/auth_controller.dart';
import 'package:village_wheels/controllers/register_controller.dart';
import 'package:village_wheels/services/input_decoration.dart';
import 'package:village_wheels/views/base/custom_image.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/signup_four_screen/signup_page_four.dart';

class SignupPageOne extends StatelessWidget {
  const SignupPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageAndTitleWidget(
            image: Assets.imagesPersonaldetail,
            title: "Personal Details",
          ),
          const SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: Get.find<RegisterController>().name,
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: 'Full Name',
              labelColor: Color(0xffF97316),
              borderColor: Color(0xff1E3A8A),
              borderWidth: 0.5,
              borderRadius: 8,
              hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Color(0xff6B7280),
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
              contentPadding: EdgeInsets.all(16),
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
          GetBuilder<AuthController>(
            builder: (authCtrl) {
              return TextFormField(
                readOnly: true,
                enabled: false,
                controller: TextEditingController(
                  text: '+91 ${authCtrl.numberController.text}',
                ),
                keyboardType: TextInputType.text,
                decoration: CustomDecoration.inputDecoration(
                  floating: true,
                  label: 'Phone Number',
                  labelColor: Color(0xffF97316),
                  borderColor: Color(0xff1E3A8A),
                  borderWidth: 0.5,
                  borderRadius: 8,
                  icon: Icon(
                    Icons.phone,
                    size: 25,
                    color: Color(0xffA2A2A4),
                  ),
                  hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Color(0xff6B7280),
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                  contentPadding: EdgeInsets.all(16),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: Get.find<RegisterController>().email,
            decoration: CustomDecoration.inputDecoration(
              floating: true,
              label: 'Email Address(Optional)',
              labelColor: Color(0xffF97316),
              borderColor: Color(0xff1E3A8A),
              borderWidth: 0.5,
              borderRadius: 8,
              hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Color(0xff6B7280),
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
              hint: 'Enter Email Address(Optional)',
              contentPadding: EdgeInsets.all(16),
            ),
            // validator: (val) {
            //   if (val!.isNotEmpty && val.isEmail) {
            //     return "Enter valid email";
            //   }
            //   return null;
            // },
          ),
        ],
      ),
    );
  }
}
