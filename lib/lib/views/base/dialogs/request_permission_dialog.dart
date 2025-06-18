import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/extensions.dart';
import '../common_button.dart';
import '../custom_image.dart';

class RequestPermissionDialog extends StatelessWidget {
  const RequestPermissionDialog({super.key, required this.permission, this.extraMessage});

  final String permission;
  final String? extraMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF535353), Color(0xFF303030)]
            )
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              path: Assets.imagesAppLogo,
              height: size.height * .07,
              width: size.width * .7,
            ),
            const SizedBox(height: 14.0),
            Text(
              'Requires access to your $permission to perform this action.',
              style: GoogleFonts.montserrat(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            if (extraMessage.isValid)
              Text(
                extraMessage!,
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 14.0),
            Row(
              children: [
                if (Platform.isAndroid)
                  Expanded(
                    child: CustomButton(
                      elevation: 0,
                      color: Colors.black38,
                      type: ButtonType.primary,
                      onTap: () => Navigator.pop(context, false),
                      title: 'Reject',
                    ),
                  ),

                if (Platform.isAndroid)
                  const SizedBox(width: 10),

                Expanded(
                  child: CustomButton(
                    elevation: 0,
                    color: Colors.black38,
                    type: ButtonType.primary,
                    onTap: () => Navigator.pop(context, true),
                    title: 'Continue',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
