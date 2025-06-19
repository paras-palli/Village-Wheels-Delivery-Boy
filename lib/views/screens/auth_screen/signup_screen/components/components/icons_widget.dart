import 'package:flutter/material.dart';

class IconsWidget extends StatelessWidget {
  const IconsWidget({
    super.key,
    required this.icon,
    this.color,
  });
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Card(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: color,
          size: 16,
        ),
      ),
    );
  }
}
