import 'package:flutter/material.dart';

import '../../services/theme.dart';

class PosterIndicator extends StatelessWidget {
  const PosterIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(color: isActive ? primaryColor : Colors.white, shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          blurRadius: 4,
          offset: const Offset(0, 4),
          color: Colors.black.withOpacity(0.30),
        ),
      ]),
    );
  }
}
