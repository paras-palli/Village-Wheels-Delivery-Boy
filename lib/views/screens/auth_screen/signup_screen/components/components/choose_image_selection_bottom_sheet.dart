import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

class ChooseImageSelectionBottomSheet extends StatefulWidget {
  final Function(File) onImageSelected;

  const ChooseImageSelectionBottomSheet(
      {super.key, required this.onImageSelected});

  @override
  State<ChooseImageSelectionBottomSheet> createState() =>
      _ChooseImageSelectionBottomSheetState();
}

class _ChooseImageSelectionBottomSheetState
    extends State<ChooseImageSelectionBottomSheet> {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source, BuildContext context) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 75);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      widget.onImageSelected(image);
      if (!context.mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Camera Option
          Expanded(
            child: InkWell(
              onTap: () => pickImage(ImageSource.camera, context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt, size: 25, color: primaryColor),
                  const SizedBox(height: 10),
                  Text(
                    "Camera",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600, color: primaryColor),
                  ),
                ],
              ),
            ),
          ),

          // Vertical Divider
          Container(
            width: 1,
            height: 60,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),

          Expanded(
            child: InkWell(
              onTap: () => pickImage(ImageSource.gallery, context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.photo_library, size: 25, color: primaryColor),
                  const SizedBox(height: 10),
                  Text("Gallery",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600, color: primaryColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
