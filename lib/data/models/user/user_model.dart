class UserModel {
  final int? id;
  final String? name;
  final String? image;
  final String? email;
  final String? phone;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? isAgent;
  final int? propertyCount;
  final int? propertiesCount;

  UserModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isAgent,
    this.propertyCount,
    this.propertiesCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      isAgent: json["is_agent"],
      propertyCount: json["property_count"],
      propertiesCount: json["properties_count"],
    );
  } 

  
}
