import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/register_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/basic_controller.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';
import '../../../../../controllers/location_controller.dart';
import '../../../../../services/input_decoration.dart';
import '../../../../../services/route_helper.dart';
import '../choose_location_screen/choose_location_screen.dart';
import '../map_pages/map_page.dart';
import '../map_pages/select_state_dailog.dart';
import 'components/image_title.dart';

class SignUpPageTwo extends StatefulWidget {
  const SignUpPageTwo({super.key, this.isFrmProfile = false});
  final bool isFrmProfile;

  @override
  State<SignUpPageTwo> createState() => _SignUpPageTwoState();
}

class _SignUpPageTwoState extends State<SignUpPageTwo> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      final controller = Get.find<LocationController>();
      if (controller.location != null) return;
      Navigator.of(context)
          .push(getCustomRoute(child: const ChooseLocationScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<RegisterController>(
            builder: (registerCtrl) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ImageAndTitleWidget(
                    image: Assets.imagesAddressDetials,
                    title: "Address Details",
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: registerCtrl.mapAddress,
                    readOnly: true,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        overflow: TextOverflow.ellipsis, color: Colors.black),
                    maxLines: 2,
                    minLines: 1,
                    validator: (v) => v!.isEmpty ? "Select Map Location" : null,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MapPage()),
                      );
                      if (result != null) {
                        registerCtrl.mapAddress.text = result['address'] ?? '';
                        registerCtrl.latitude = result['lat']?.toString();
                        registerCtrl.longitude = result['lng']?.toString();
                        registerCtrl.statename = result['state']?.toString();
                        final match = Get.find<BasicController>()
                            .states
                            .firstWhereOrNull(
                                (s) => s.name == registerCtrl.statename);
                        if (match != null) {
                          registerCtrl.stateid = match.id.toString();
                        }
                        log(registerCtrl.stateid ?? '', name: "StateId");
                        log(registerCtrl.statename ?? '', name: "StateName");
                        registerCtrl.city.text =
                            result['city']?.toString() ?? '';
                        registerCtrl.pincode.text =
                            result['pincode']?.toString() ?? '';
                      }
                    },
                    decoration: CustomDecoration.inputDecoration(
                      borderRadius: 10,
                      bgColor: const Color(0xffF9FAFB),
                      borderColor: const Color(0xffCDCDCD),
                      borderWidth: 1,
                      suffix: Icon(
                        Icons.location_on,
                        color: primaryColor,
                      ),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: secondaryColor),
                      label: "Select Map Location",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                    maxLines: null,
                    minLines: 1,
                    controller: registerCtrl.streetOne,
                    validator: (v) =>
                        v!.isEmpty ? "Enter Address Line 1" : null,
                    decoration: CustomDecoration.inputDecoration(
                        borderRadius: 10,
                        bgColor: const Color(0xffF9FAFB),
                        borderColor: const Color(0xffCDCDCD),
                        borderWidth: 1,
                        label: 'Address Line 1',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: secondaryColor)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: registerCtrl.streetTwo,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                    maxLines: null,
                    minLines: 1,
                    decoration: CustomDecoration.inputDecoration(
                        borderRadius: 10,
                        bgColor: const Color(0xffF9FAFB),
                        borderColor: const Color(0xffCDCDCD),
                        borderWidth: 1,
                        label: 'Address Line 2(Optional)',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: secondaryColor)),
                  ),
                  const SizedBox(height: 10),
                  // State dropdown
                  FormField(
                    validator: (_) => (registerCtrl.statename == null ||
                            registerCtrl.statename!.isEmpty)
                        ? "Select State"
                        : null,
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              showDialog(
                                context: context,
                                builder: (_) => SelectStateDialogue(
                                  allStates: Get.find<BasicController>().states,
                                  onStateSelected: (s) {
                                    registerCtrl.statename = s.name;
                                    registerCtrl.stateid = s.id.toString();
                                    field.didChange(s.name);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xffF9FAFB),
                                border: Border.all(
                                    color: field.hasError
                                        ? Colors.red
                                        : const Color(0xffCDCDCD)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    registerCtrl.statename ?? "Select State",
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: registerCtrl.statename == null
                                            ? secondaryColor
                                            : Colors.black
                                    )
                                  ),
                                  Icon(Icons.arrow_drop_down,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 12),
                              child: Text(field.errorText!,
                                  style: const TextStyle(color: Colors.red)),
                            )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(overflow: TextOverflow.ellipsis),
                          maxLines: null,
                          minLines: 1,
                          controller: registerCtrl.city,
                          validator: (v) =>
                              v!.isEmpty ? "Enter City Name" : null,
                          decoration: CustomDecoration.inputDecoration(
                              borderRadius: 10,
                              bgColor: const Color(0xffF9FAFB),
                              borderColor: const Color(0xffCDCDCD),
                              borderWidth: 1,
                              label: "City Name",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: secondaryColor)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: registerCtrl.pincode,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(overflow: TextOverflow.ellipsis),
                          maxLines: null,
                          minLines: 1,
                          validator: (v) => v!.isEmpty ? "Enter Pincode" : null,
                          keyboardType: Platform.isIOS
                              ? const TextInputType.numberWithOptions(decimal: true)
                              : TextInputType.number,
                          decoration: CustomDecoration.inputDecoration(
                              borderRadius: 10,
                              bgColor: const Color(0xffF9FAFB),
                              borderColor: const Color(0xffCDCDCD),
                              borderWidth: 1,
                              label: 'Pincode',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: secondaryColor)),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BussinessItemWidget extends StatelessWidget {
  const BussinessItemWidget({
    super.key,
    required this.bussiness,
  });

  final Bussiness bussiness;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.selectBussiness(bussiness);
          controller.selectBussinessFromBussinessList();
          log("${controller.selectedBussiness}");
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.3,
                    color: bussiness.isSellected ? primaryColor : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: .3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  CustomImage(
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                    path: bussiness.image ?? '',
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bussiness.name ?? '',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(right: 0),
              decoration: BoxDecoration(
                color: !bussiness.isGrey
                    ? Colors.transparent
                    : Colors.grey.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      );
    });
  }
}
