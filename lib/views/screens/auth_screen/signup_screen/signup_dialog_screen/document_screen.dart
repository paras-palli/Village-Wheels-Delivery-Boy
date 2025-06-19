import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import 'congratulation_dialog.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            const CustomImage(
              path: Assets.imagesDocument,
              fit: BoxFit.cover,
              height: 139,
            ),
            const SizedBox(height: 50),
            Text(
              "We're reviewing your documents",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(height: 5),
            Text(
              "You'll be notified once the",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              "verification is complete.",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 400),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const CongratulationsDialog(),
                );
              },
              child: Container(
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Center(
                    child: Text(
                      "Continue",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
