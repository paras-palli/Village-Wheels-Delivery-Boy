import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/registration_map_controller.dart';
import '../../../../base/common_button.dart';
import 'map_search_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<RegistrationMapController>(
          builder: (controller) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (mapcontrller) =>
                      controller.mapController = mapcontrller,
                  initialCameraPosition: CameraPosition(
                    target: controller.selectedLatLng,
                    zoom: 15,
                  ),
                  onCameraMove: (CameraPosition position) {
                    controller.selectedLatLng = position.target;
                  },
                  onCameraIdle: () {
                    controller
                        .updateAddressFromLatLng(controller.selectedLatLng);
                  },
                ),

                const Center(
                  child: Icon(
                    Icons.location_pin,
                    size: 50,
                    color: Colors.red,
                  ),
                ),

                Positioned(
                  top: 15,
                  left: 20,
                  right: 20,
                  child: CustomButton(
                    color: Colors.grey[100],
                    radius: 10,
                    onTap: () async {
                      controller.listOfLocation = [];
                      controller.citynamecontroller.text = "";
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MapSearchPage()),
                      );
                      if (result != null) {
                        //for google map
                        double lat = result['lat'];
                        double lng = result['lng'];
                        String address = result['address'];
                        controller.selectedLatLng = LatLng(lat, lng);
                        controller.addressText = address;
                        controller.mapController?.animateCamera(
                          CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Search Destination",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),

                if (controller.addressText != null)
                  Positioned(
                    bottom: 70,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 4),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(controller.addressText!),
                    ),
                  ),

                // Confirm Button
                Positioned(
                  bottom: 5,
                  left: 16,
                  right: 16,
                  child: CustomButton(
                    onTap: () {
                      Navigator.pop(
                        context,
                        {
                          'lat': controller.selectedLatLng.latitude,
                          'lng': controller.selectedLatLng.longitude,
                          'address': controller.addressText,
                          'city': controller.city,
                          'state': controller.statename,
                          'pincode': controller.pincode,
                        },
                      );
                    },
                    title: "Confirm Location",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
