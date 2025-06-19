class BusinessSetting {
  int? id;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  BusinessSetting({
    this.id,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory BusinessSetting.fromJson(Map<String, dynamic> json) => BusinessSetting(
    id: json["id"],
    key: json["key"],
    value: json["value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}