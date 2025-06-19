import 'package:flutter/material.dart';

import '../../../../../base/custom_image.dart';

class ImageAndTitleWidget extends StatelessWidget {
  const ImageAndTitleWidget({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImage(
          path: image,
          height: 150,
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: const Color(0xff1E3A8A),
          ),
        ),
      ],
    );
  }
}
