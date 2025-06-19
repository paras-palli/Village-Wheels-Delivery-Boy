import 'dart:async';

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:lottie/lottie.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../../controllers/location_controller.dart';
import '../../../../../generated/assets.dart';
import '../../../../../services/input_decoration.dart';
import '../../../../../services/route_helper.dart';
import '../../../../../services/theme.dart';
import '../../../../base/common_button.dart';
import 'searched_location_screen.dart';

// import 'package:location/location.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({super.key, this.isFromAddress = false});
  final bool isFromAddress;

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      Get.find<LocationController>().fetchCurrentLocationPlace().then((value) {});
    });
  }

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapCon;

  Future<LatLng?> getCenter() async {
    try {
      final GoogleMapController controller = await _controller.future;
      LatLngBounds visibleRegion = await controller.getVisibleRegion();
      LatLng centerLatLng = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
        (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,
      );

      return centerLatLng;
    } catch (e) {
      log(e.toString(), name: 'error');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm location',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
        ),
        body: GetBuilder<LocationController>(
          builder: (location) {
            if (location.latLng == null) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    LottieBuilder.asset(
                      Assets.lottiesLocationFinding,
                      // height: size.height * .4,
                      width: size.width * .8,
                    ),
                    const Spacer(),
                    Text(
                      'Finding your location...',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }
            return SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    mapToolbarEnabled: true,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: location.latLng!, //latlong!,
                      zoom: 14.4746,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (controller) async {
                      mapCon = controller;
                      setState(() {});
                      _controller.complete(controller);
                    },
                    onCameraIdle: () async {
                      LatLng? currentCenter = await getCenter().then((value) {
                        if (value != null) {
                          location.chooseCurrentLatlog(value);
                          log('${location.latLng}');
                          location.getAddressFromLocation(LatLng(value.latitude, value.longitude));
                        }
                        return value;
                      });
                      log('$currentCenter', name: 'Current');
                    },
                  ),
                  const Center(
                    child: Icon(
                      Icons.location_on,
                      size: 35,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final LatLng latLng = await Navigator.of(context).push(getCustomRoute(child: const SearchedLoactionScreen()));
                        location.chooseCurrentLatlog(latLng);
                        location.getAddressFromLocation(LatLng(latLng.latitude, latLng.longitude));
                        mapCon?.animateCamera(
                          CameraUpdate.newLatLngZoom(LatLng(latLng.latitude, latLng.longitude), 15),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          readOnly: true,
                          enabled: false,
                          decoration: CustomDecoration.inputDecoration(
                            bgColor: Colors.white,
                            borderRadius: 6,
                            hint: 'Search for area,street name...',
                            label: 'Search area,street name ...',
                            icon: Icon(
                              Icons.search,
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: LocConfirmBtnText(
                      getCenter: getCenter(),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//get current location
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

class LocConfirmBtnText extends StatelessWidget {
  const LocConfirmBtnText({super.key, required this.getCenter});
  final Future<LatLng?> getCenter;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (location) {
      if (location.latLng == null) {
        return const SizedBox.shrink();
      }
      if (location.isLoading) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          color: Colors.white,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Container(
        color: backgroundLight,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    location.location ?? 'NA',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            CustomButton(
              elevation: 0,
              radius: 6,
              title: 'Confirm Location',
              onTap: () async {
                LatLng? currentCenter = await getCenter;
                log('$currentCenter', name: 'Current');
                if (currentCenter != null) {
                  location.chooseCurrentLatlog(currentCenter);
                  location.getAddressFromLocation(currentCenter);
                  Navigator.pop(navigatorKey.currentContext!, currentCenter);
                } else {
                  Fluttertoast.showToast(msg: "Please select a valid location");
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
