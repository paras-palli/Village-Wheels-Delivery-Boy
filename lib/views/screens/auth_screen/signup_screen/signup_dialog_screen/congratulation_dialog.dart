import 'package:flutter/material.dart';
import 'package:village_wheels/services/route_helper.dart';

import 'package:village_wheels/views/base/custom_image.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/signup_dialog_screen/sorry_screen.dart';

class CongratulationsDialog extends StatelessWidget {
  const CongratulationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(height: 80),
                  Positioned(
                    top: -95,
                    child: CustomImage(
                      path: Assets.imagesCongrats,
                      fit: BoxFit.cover,
                      height: 120,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 29),
              Text(
                'CONGRATULATIONS',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Color(0xff28B339),
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your documents have been\nsuccessfully verified.\nWelcome to Village Wheels!\nYou\'re all set to get started!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Color(0xff1E3A8A),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1A3580),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.push(context, getCustomRoute(child: SorryScreen()));
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
