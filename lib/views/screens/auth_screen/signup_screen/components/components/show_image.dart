import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../base/custom_image.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, this.img, this.image});
  final File? img;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: image != null
                ? CustomImage(
                    path: image ?? '',
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    img ?? File(''),
                    fit: BoxFit.cover,
                  ),
          ),
        ));
  }
}
