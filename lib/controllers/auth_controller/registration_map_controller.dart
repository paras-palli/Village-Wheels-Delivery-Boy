import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../data/models/response/response_model.dart';
import '../../services/constants.dart';

class RegistrationMapController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  GoogleMapController? mapController;

  LatLng selectedLatLng = LatLng(18.9220, 72.8347);

  Future<void> getCurrentLocation() async {
    log("getCurrentLocation Called");

    try {
      _isLoading = true;
      update();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition();

      LatLng currentLatLng = LatLng(
        position.latitude,
        position.longitude,
      );

      selectedLatLng = currentLatLng;
      log(selectedLatLng.toString(), name: "Inside selectedLatLng");

      await updateAddressFromLatLng(currentLatLng);
      // _isLoading = false;
      // update();
    } catch (e) {
      // _isLoading = false;
      // update();
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT getCurrentLocation()");
    }
    _isLoading = false;
    update();
  }

  String? addressText;
  String? city;
  String? pincode;
  String? statename;
  Future<void> updateAddressFromLatLng(LatLng latLng) async {
    _isLoading = true;
    update();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String newAddress =
            "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        addressText = newAddress;
        city = place.locality;
        pincode = place.postalCode;
        statename = place.administrativeArea;
        _isLoading = false;
        update();
      }
    } catch (e) {
      _isLoading = false;
      update();
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT updateAddressFromLatLng()");
    }
  }

  Future<ResponseModel> fetchPlaceDetailsById(String placeId) async {
    log('fetchPlaceDetailsById CALLED');
    ResponseModel responseModel;

    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AppConstants.googleMapAndroidKey}";
      final response = await http.get(Uri.parse(url));
      log(jsonEncode(response.body), name: "fetchPlaceDetailsById");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['result'];
        final lat = result['geometry']['location']['lat'];
        final lng = result['geometry']['location']['lng'];
        final address = result['formatted_address'];

        var returndata = {
          'lat': lat,
          'lng': lng,
          'address': address,
        };
        responseModel = ResponseModel(true, "SUCCESS", returndata);
      } else {
        responseModel = ResponseModel(false, response.toString(), "UNSUCCESS");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "UNSUCCESS");
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT fetchPlaceDetailsById()");
    }

    return responseModel;
  }

  TextEditingController citynamecontroller = TextEditingController();
  List<dynamic> listOfLocation = [];
  Timer? _timer;
  void placeSuggestionsWithGooge(String input) async {
    if (input.isEmpty) return;
    _isLoading = true;
    update();
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${AppConstants.googleMapAndroidKey}";
      final response = await http.get(Uri.parse(url));
      log(response.body.toString(), name: "placeSuggestionsWithGooge Response");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        listOfLocation = data['predictions'];
        log(listOfLocation.toString(), name: "listOfLocation");
      } else {
        log(response.body.toString(), name: "listOfLocation");
      }
    } catch (e) {
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT placeSuggestionsWithGooge()");
    }
    _isLoading = false;
    update();
  }

  void placeSuggestions(String input) async {
    if (input.isEmpty) return;

    final url =
        "https://nominatim.openstreetmap.org/search?q=$input&countrycodes=in&format=json&addressdetails=1";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      listOfLocation = data;
      log(listOfLocation.toString(), name: "listOfLocation");
      update();
    } else {
      log("HTTP error: ${response.statusCode}", name: "placeSuggestions");
    }
  }

  void onCityNameChanged(String value) {
    if (_timer?.isActive ?? false) _timer!.cancel();

    placeSuggestionsWithGooge(value);
  }

  void disposeSearch() {
    _timer?.cancel();
    citynamecontroller.dispose();
  }
}
