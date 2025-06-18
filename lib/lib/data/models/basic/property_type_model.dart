class PropertyTypeModel {
  final int? id;
  final String? type;
  final String? subType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;

  PropertyTypeModel({
    this.id,
    this.type,
    this.subType,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) {
    return PropertyTypeModel(
      id: json['id'],
      type: json['type'],
      subType: json['sub_type'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      status: json['status'],
    );
  }
}
