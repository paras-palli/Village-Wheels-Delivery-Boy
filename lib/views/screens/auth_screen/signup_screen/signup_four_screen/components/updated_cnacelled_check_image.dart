import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/views/base/image_picker_sheet.dart';

import '../../components/components/icons_widget.dart';
import '../../components/components/show_image.dart';

class UpdatedCancelledCheckImage extends StatelessWidget {
  const UpdatedCancelledCheckImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (regiCtrl) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (regiCtrl.selecedCancelCheck != null) {
                      Navigator.of(context).push(
                        getCustomRoute(
                          child: ShowImage(img: regiCtrl.selecedCancelCheck!),
                        ),
                      );
                    } else {
                      await getImageBottomSheet(context).then((value) {
                        if (value != null) {
                          regiCtrl.selectFiles(isCancelCheck: true, val: value);
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFB0B8C7),
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF5F5F5),
                    ),
                    child: regiCtrl.selecedCancelCheck != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              regiCtrl.selecedCancelCheck!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt, color: const Color(0xFF233A7D), size: 32),
                              const SizedBox(height: 8),
                              Text(
                                "Add Cancelled Check Image",
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                      color: Color(0xff233A7D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                  ),
                ),
                if (regiCtrl.selecedCancelCheck != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await getImageBottomSheet(context).then((value) {
                              if (value != null) {
                                regiCtrl.selectFiles(isCancelCheck: true, val: value);
                              }
                            });
                          },
                          icon: const IconsWidget(
                            icon: Icons.edit,
                          ),
                        ),
                        if (regiCtrl.selecedCancelCheck != null)
                          IconButton(
                            onPressed: () {
                              regiCtrl.removeFiles(isCancelCheck: true);
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
            ),
          ),
        ],
      );
    });
  }
}
