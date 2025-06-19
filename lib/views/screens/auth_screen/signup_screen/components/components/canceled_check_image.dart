import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_wheels/views/screens/auth_screens/signup_screen/components/components/show_image.dart';

import '../../../../../../controllers/auth_controller/auth_controller.dart';
import '../../../../../../controllers/register_controller.dart';
import '../../../../../../services/route_helper.dart';
import '../../../../../base/custom_image.dart';
import '../../../../../base/image_picker_sheet.dart';
import 'icons_widget.dart';

class CancelCheckImageWidget extends StatelessWidget {
  const CancelCheckImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Cancelled Check',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ),
        GetBuilder<AuthController>(builder: (authCtrl) {
          if (authCtrl.userModel?.cancelCheck != null) {
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
                  path: authCtrl.userModel?.cancelCheck ?? '',
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
                    if (controller.selecedCancelCheck != null) {
                      Navigator.of(context).push(
                        getCustomRoute(
                          child: ShowImage(img: controller.selecedCancelCheck!),
                        ),
                      );
                      return;
                    }
                    await getImageBottomSheet(context).then((value) {
                      if (value != null) {
                        controller.selectFiles(isCancelCheck: true, val: value);
                      }
                    });
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xFFF2F2F2), width: 1),
                    ),
                    child: controller.selecedCancelCheck != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.selecedCancelCheck!,
                              fit: BoxFit.cover,
                            ),
                          )
                        // : userID != null &&
                        //         controller
                        //                 .clientModel?.drugLicenseCertificate !=
                        //             null
                        //     ? ClipRRect(
                        //         borderRadius: BorderRadius.circular(10),
                        //         child: CustomImage(
                        //           viewFullScreen: true,
                        //           path:
                        //               "${controller.clientModel?.drugLicenseCertificate}",
                        //           fit: BoxFit.cover,
                        //         ),
                        //       )
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
                                    child: const Icon(
                                        Icons.add_photo_alternate_outlined)),
                                const SizedBox(height: 10),
                                Text(
                                  'Add Cancelled Check',
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
                          ),
                  ),
                ),
                //
                if (controller.selecedCancelCheck != null)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await getImageBottomSheet(context)
                                    .then((value) {
                                  if (value != null) {
                                    controller.selectFiles(
                                        isCancelCheck: true, val: value);
                                  }
                                });
                              },
                              icon: const IconsWidget(
                                icon: Icons.edit,
                              )),
                          if (controller.selecedCancelCheck != null)
                            IconButton(
                              onPressed: () {
                                controller.removeFiles(isCancelCheck: true);
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
