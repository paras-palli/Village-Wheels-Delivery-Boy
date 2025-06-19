import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/location_controller.dart';
import '../../../../../../services/input_decoration.dart';
import '../../../../../../services/route_helper.dart';
import '../../../../../base/common_button.dart';
import '../../choose_location_screen/choose_location_screen.dart';

class LocationCustomWidget extends StatelessWidget {
  const LocationCustomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationCtrl) {
        return Column(
          children: [
            locationCtrl.location != null
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff1E3A8A), width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            locationCtrl.location ?? '',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        CustomButton(
                          radius: 5,
                          height: 30,
                          elevation: 0,
                          onTap: () {
                            Navigator.of(context).push(getCustomRoute(child: const ChooseLocationScreen()));
                          },
                          child: Text(
                            'Change',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        )
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(getCustomRoute(child: const ChooseLocationScreen()));
                    },
                    child: TextFormField(
                      readOnly: true,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      decoration: CustomDecoration.inputDecoration(
                        floating: true,
                        label: 'Select Map Address',
                        labelColor: Color(0xffF97316),
                        borderColor: Color(0xff1E3A8A),
                        borderWidth: 0.5,
                        borderRadius: 8,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
