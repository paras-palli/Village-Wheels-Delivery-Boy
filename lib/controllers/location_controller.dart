import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LocationController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? location;
  LatLng? latLng;

  void chooseCurrentLatlog(LatLng? pickedLatLag) async {
    latLng = pickedLatLag;
    if (pickedLatLag != null) {
      final SharedPreferences prefs = Get.find<SharedPreferences>();
      await prefs.setDouble('latitude', pickedLatLag.latitude);
      await prefs.setDouble('longitude', pickedLatLag.longitude);
      log('Picked location saved to SharedPreferences: ${pickedLatLag.latitude}, ${pickedLatLag.longitude}',
          name: 'SharedPreferences');
    }
    update();
  }

  void cleanLatLng() async {
    latLng = null;
    location = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('latitude');
    await prefs.remove('longitude');
    await prefs.remove('address');
    log('Location data cleared from SharedPreferences',
        name: 'SharedPreferences');
    update();
  }

  ///
  Future<void> fetchCurrentLocationPlace({bool noAddress = false}) async {
    log('-------------- fetchCurrentLocationPlace CALLED ---------------------');
    _isLoading = true;
    update();

    // Check Location Permission
    await Geolocator.checkPermission().then((value) async {
      if (value != LocationPermission.always &&
          value != LocationPermission.whileInUse) {
        await Geolocator.requestPermission();
      } else if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
      } else {
        return;
      }
    });

    // To Turn On Device Location
    await Geolocator.isLocationServiceEnabled().then((value) async {
      if (!value) {
        await Geolocator.openLocationSettings();
      }
    });

    Position position = await Geolocator.getCurrentPosition();
    latLng = LatLng(position.latitude, position.longitude);
    log((position.latitude).toString(), name: 'Latitude');
    log((position.longitude).toString(), name: 'Longitude');

    // -- Update Location --
    // -- Fetch Address --
    if (!noAddress) {
      await getAddressFromLocation(
          latLng ?? const LatLng(19.198545796504945, 72.95579630029403));
    }

    _isLoading = false;
    update();
  }

  List<Placemark> placeMarkData = [];
  Future<void> getAddressFromLocation(LatLng latLong) async {
    _isLoading = true;
    update();

    if (latLong.latitude == 0.0 && latLong.longitude == 0.0) {
      log("Invalid LatLng (0.0, 0.0) — skipping reverse geocoding",
          name: "Location");
      location = "Unknown location";
      _isLoading = false;
      update();
      return;
    }

    await placemarkFromCoordinates(latLong.latitude, latLong.longitude)
        .then((placeMark) {
      if (placeMark.isNotEmpty) {
        placeMarkData = placeMark;
        log('${placeMark.first.toJson()}', name: "Location");

        List<String?> addressParts = [
          placeMark.first.street,
          placeMark.first.subLocality,
          placeMark.first.administrativeArea,
          placeMark.first.country,
        ].where((part) => part != null && part.isNotEmpty).toList();
        location = addressParts.join(', ');
      }
    });
    _isLoading = false;
    update();
  }

  Timer? timer;
  bool isSearch = false;
  final FocusNode searchFocusNode = FocusNode();
  void dismissKeyboard() {
    if (MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom > 0) {
      FocusScope.of(navigatorKey.currentContext!).unfocus();
    }
  }

  final TextEditingController searchController = TextEditingController();
  List<dynamic> listOfLocations = [];
  Future<void> searchLocation(String query) async {
    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$query&countrycodes=in&format=json&addressdetails=1");
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      isSearch = true;
      update();
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          listOfLocations = json.decode(response.body);
        }
      } catch (e) {
        log('$e');
      }
      isSearch = false;
      update();
    });
    log("-----------it's work-------");
    log('$listOfLocations');
  }

  void clearSearch() {
    searchController.clear();
    listOfLocations = [];
    update();
  }
}
