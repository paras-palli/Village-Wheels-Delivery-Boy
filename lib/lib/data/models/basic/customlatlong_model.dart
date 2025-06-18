import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' as sdk;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;

class CustomLatLng {
  final double latitude;
  final double longitude;

  CustomLatLng({required this.latitude, required this.longitude});

  factory CustomLatLng.fromPosition(Position position) => CustomLatLng(latitude: position.latitude, longitude: position.longitude);
  factory CustomLatLng.fromLatLng(sdk.LatLng position) => CustomLatLng(latitude: position.lat, longitude: position.lng);
  factory CustomLatLng.fromMapLatLng(map.LatLng position) => CustomLatLng(latitude: position.latitude, longitude: position.longitude);

  sdk.LatLng toLatLng() => sdk.LatLng(lat: latitude, lng: longitude);
}
