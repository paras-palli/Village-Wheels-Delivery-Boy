import 'state_model.dart';

class CityModel {
  int? id;
  String? name;
  int? stateId;
  String? longitude;
  String? latitude;

  CityModel({
    this.id,
    this.name,
    this.stateId,
    this.longitude,
    this.latitude,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        stateId: json['state_id'] as int?,
        longitude: json['longitude'],
        latitude: json['latitude,']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'state_id': stateId,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory CityModel.fromState(StateModel state) {
    return CityModel(
      id: state.id,
      name: state.name,
    );
  }

  @override
  String toString() {
    return name ?? 'NA';
  }
}
