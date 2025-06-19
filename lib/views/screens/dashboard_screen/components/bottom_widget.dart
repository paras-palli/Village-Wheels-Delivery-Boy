import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

class BottomWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback onTap;
  const BottomWidget({super.key, required this.title, required this.icon, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isActive ? primaryColor : Colors.black54,
                BlendMode.srcIn,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 15,
                color: isActive ? primaryColor : Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}