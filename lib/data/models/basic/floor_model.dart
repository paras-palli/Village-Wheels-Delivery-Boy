// To parse this JSON data, do
//
//     final floorModel = floorModelFromJson(jsonString);

import 'dart:convert';

List<FloorModel> floorModelFromJson(String str) => List<FloorModel>.from(json.decode(str).map((x) => FloorModel.fromJson(x)));

String floorModelToJson(List<FloorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FloorModel {
  int? id;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  FloorModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) => FloorModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
