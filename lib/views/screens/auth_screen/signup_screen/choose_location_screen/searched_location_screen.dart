import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../controllers/location_controller.dart';
import '../../../../../services/input_decoration.dart';
import '../../../../../services/theme.dart';
import '../../../../base/dialogs/custom_nodata_found.dart';

class SearchedLoactionScreen extends StatelessWidget {
  const SearchedLoactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Address',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: Column(
        children: [
          GetBuilder<LocationController>(initState: (state) {
            Timer.run(() {
              Get.find<LocationController>().clearSearch();
            });
          }, builder: (locationController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: TextFormField(
                focusNode: locationController.searchFocusNode,
                controller: locationController.searchController,
                decoration: CustomDecoration.inputDecoration(
                  borderRadius: 6,
                  hint: 'Search for area,street name...',
                  label: 'Search area,street name',
                  icon: Icon(
                    Icons.search,
                    color: primaryColor,
                    size: 24,
                  ),
                  suffix: locationController.isSearch
                      ? SizedBox(
                          height: 10,
                          width: 10,
                          child: Center(
                            child: Transform.scale(
                              scale: .7,
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        )
                      : locationController.searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                locationController.searchController.clear();
                                Get.find<LocationController>()
                                    .searchLocation('');
                                locationController.dismissKeyboard();
                              },
                              icon: const Icon(Icons.close),
                            )
                          : null,
                ),
                onChanged: (val) {
                  Get.find<LocationController>().searchLocation(val);
                },
              ),
            );
          }),
          Expanded(
            child:
                GetBuilder<LocationController>(builder: (locationController) {
              if (locationController.listOfLocations.isEmpty) {
                return const Center(
                  child: CustomNoDataFoundWidget(
                    text: 'No address found!',
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: locationController.listOfLocations.length,
                      itemBuilder: (context, index) {
                        final location =
                            locationController.listOfLocations[index];
                        log('$location');
                        return ListTile(
                          title: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 24,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  location['display_name'],
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.find<LocationController>().cleanLatLng();
                            final lat = double.parse(location['lat']);
                            final lon = double.parse(location['lon']);
                            final LatLng latLng = LatLng(lat, lon);
                            Navigator.of(context).pop(latLng);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: Colors.grey[200]);
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
