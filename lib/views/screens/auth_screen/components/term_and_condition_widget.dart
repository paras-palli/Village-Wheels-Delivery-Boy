import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/services/enums/settings_enum.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_html_widget.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key, this.isCheckBoxRequired = false});
  final bool isCheckBoxRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // if (isCheckBoxRequired)
        //   GetBuilder<AuthController>(
        //     builder: (auth) {
        //       return Checkbox(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(6),
        //         ),
        //         side: WidgetStateBorderSide.resolveWith(
        //               (states) => BorderSide(
        //             width: 1.0,
        //             color:
        //             auth.acceptTermAndCondition ? primaryColor : Colors.grey,
        //           ),
        //         ),
        //         activeColor: auth.acceptTermAndCondition ? primaryColor : null,
        //         value: auth.acceptTermAndCondition,
        //         onChanged: (val) {
        //           if (val != null) {
        //             auth.updateAcceptTermAndCondition(val);
        //           }
        //         },
        //       );
        //     },
        //   ),
        //

        Expanded(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
              'By providing my phone number , I hereby agree and accept the ',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: 'Terms & conditons ',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: secondaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: secondaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(
                        getCustomRoute(
                          child: const CustomHtmlScreen(
                            title: 'Terms and Conditions',
                            businessSettingName: BusinessSettingName.termsAndCondition,
                          ),
                        ),
                      );
                    },
                ),
                TextSpan(
                  text: '& ',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: 'Privacy policy ',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: secondaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: secondaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(
                        getCustomRoute(
                          child: const CustomHtmlScreen(
                            title: 'Privacy Policy',
                            businessSettingName: BusinessSettingName.privacyPolicy,
                          ),
                        ),
                      );
                    },
                ),
                TextSpan(
                  text: 'in use of this app.',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
