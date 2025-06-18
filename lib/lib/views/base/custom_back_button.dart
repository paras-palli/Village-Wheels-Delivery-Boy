import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
  final IconData? icon;
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.color, this.iconColor, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: CircleAvatar(
        backgroundColor: color ?? Colors.white24,
        radius: 20,
        child: Icon(
          icon ?? Icons.arrow_back,
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}
