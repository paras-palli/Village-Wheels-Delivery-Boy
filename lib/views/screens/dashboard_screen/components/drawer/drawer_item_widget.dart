import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    this.iconData,
    this.isLogOut = false,
  });
  final Function()? onTap;
  final String title;
  final String icon;
  final Icon? iconData;
  final bool isLogOut;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              iconData ??
                  SvgPicture.asset(
                    icon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
              const SizedBox(width: 14),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isLogOut ? Colors.red : const Color(0xFF374957),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
