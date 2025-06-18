class BannerModel {
  final int? id;
  final String? type;
  final String? title;
  final String? image;
  final String? url;
  final int? projectId;
  final int? serviceProviderId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;

  BannerModel({
    this.id,
    this.type,
    this.title,
    this.image,
    this.url,
    this.projectId,
    this.serviceProviderId,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      image: json['image'],
      url: json['url'],
      projectId: json['project_id'],
      serviceProviderId: json['service_provider_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'image': image,
      'url': url,
      'project_id': projectId,
      'service_provider_id': serviceProviderId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'status': status,
    };
  }
}
