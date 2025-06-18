import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/lib/services/theme.dart';

class BannerIndicatorWidget extends StatelessWidget {
  const BannerIndicatorWidget({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 10 : 6,
      height: isActive ? 10 : 6,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }
}
