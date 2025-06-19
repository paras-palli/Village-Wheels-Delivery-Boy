import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/auth_controller/auth_controller.dart';
import '../../../../../../controllers/register_controller.dart';
import '../../../../../../services/route_helper.dart';
import '../../../../../base/custom_image.dart';
import '../../../../../base/image_picker_sheet.dart';
import 'icons_widget.dart';
import 'show_image.dart';

class AadharCardimageWidget extends StatelessWidget {
  const AadharCardimageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Aadhaar card',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ),
        GetBuilder<AuthController>(builder: (authCtrl) {
          if (authCtrl.userModel?.aadharCardFront != null) {
            return Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFF2F2F2), width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CustomImage(
                  path: authCtrl.userModel?.aadharCardFront ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          return GetBuilder<RegisterController>(builder: (controller) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (controller.selectedAadhaarCard != null) {
                      Navigator.of(context).push(
                        getCustomRoute(
                          child: ShowImage(img: controller.selectedAadhaarCard!),
                        ),
                      );
                    } else {
                      await getImageBottomSheet(context).then((value) {
                        if (value != null) {
                          controller.selectFiles(isAadharCard: true, val: value);
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFF2F2F2), width: 1),
                    ),
                    child: controller.selectedAadhaarCard != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.selectedAadhaarCard!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.add_photo_alternate_outlined)),
                                const SizedBox(height: 10),
                                Text(
                                  'Add Aadhaar card front image',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                //
                if (controller.selectedAadhaarCard != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await getImageBottomSheet(context).then((value) {
                                if (value != null) {
                                  controller.selectFiles(isAadharCard: true, val: value);
                                }
                              });
                            },
                            icon: const IconsWidget(
                              icon: Icons.edit,
                            )),
                        if (controller.selectedAadhaarCard != null)
                          IconButton(
                            onPressed: () {
                              controller.removeFiles(isAadharCard: true);
                            },
                            icon: const IconsWidget(
                              icon: Icons.delete,
                              color: Colors.red,
                            ),
                          )
                      ],
                    ),
                  ),
              ],
            );
          });
        }),
      ],
    );
  }
}
