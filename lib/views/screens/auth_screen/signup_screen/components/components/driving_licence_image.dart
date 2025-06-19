import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import 'package:village_wheels_delivery_boy/views/base/image_picker_sheet.dart';

import 'icons_widget.dart';
import 'show_image.dart';

class DrivingLicenceImageWidget extends StatelessWidget {
  const DrivingLicenceImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Driving Licence',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ),
        GetBuilder<AuthController>(builder: (authCtrl) {
          if (authCtrl.userModel?.drivingLicence != null) {
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
                  path: authCtrl.userModel?.drivingLicence ?? '',
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
                    if (controller.selectedDrivingLicense != null) {
                      Navigator.of(context).push(getCustomRoute(child: ShowImage(img: controller.selectedDrivingLicense!)));
                      return;
                    }

                    await getImageBottomSheet(context).then((value) {
                      if (value != null) {
                        controller.selectFiles(isDrivingLicense: true, val: value);
                      }
                    });
                  },
                  child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: const Color(0xFFF2F2F2), width: 1),
                      ),
                      child: Builder(builder: (_) {
                        if (controller.selectedDrivingLicense != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.selectedDrivingLicense!,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return Center(
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
                                  child: const Icon(
                                      Icons.add_photo_alternate_outlined)),
                              const SizedBox(height: 10),
                              Text(
                                'Add Driving Licence',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                              )
                            ],
                          ),
                        );
                      })),
                ),
                if (controller.selectedDrivingLicense != null)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await getImageBottomSheet(context).then((value) {
                                if (value != null) {
                                  controller.selectFiles(isDrivingLicense: true, val: value);
                                }
                              });
                            },
                            icon: const IconsWidget(icon: Icons.edit),
                          ),
                          if (controller.selectedDrivingLicense != null)
                            IconButton(
                              onPressed: () {
                                controller.removeFiles(isDrivingLicense: true);
                              },
                              icon: const IconsWidget(
                                icon: Icons.delete,
                                color: Colors.red,
                              ),
                            )
                        ],
                      )),
              ],
            );
          });
        }),
      ],
    );
  }
}
