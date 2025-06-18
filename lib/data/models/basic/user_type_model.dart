class UserTypeModel {
  final int? id;
  final String? title;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;

  UserTypeModel({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory UserTypeModel.fromJson(Map<String, dynamic> json) {
    return UserTypeModel(
      id: json['id'],
      title: json['title'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'status': status,
    };
  }
}
