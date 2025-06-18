class SettingsModel {
  String? appVersion;
  String? forceUpdate;
  String? maintenanceMode;
  String? appDownload;
  String? iosAppVersion;
  String? iosForceUpdate;
  String? iosMaintenanceMode;
  String? iosAppDownload;
  final bool iosOnProduction;
  String? email;
  String? mobile;
  String? facebook;
  String? instagram;
  String? youtube;
  String? twitter;
  String? privacyPolicy;
  String? termsCondition;
  String? legalPolicies;
  String? aboutUs;
  String? serviceContact;
  String? propertyMinAmount;
  String? propertyMaxAmount;
  String? commissionPercentage;

  SettingsModel({
    this.appVersion,
    this.forceUpdate,
    this.maintenanceMode,
    this.appDownload,
    this.iosAppVersion,
    this.iosForceUpdate,
    this.iosMaintenanceMode,
    this.iosAppDownload,
    this.iosOnProduction = false,
    this.email,
    this.mobile,
    this.facebook,
    this.instagram,
    this.youtube,
    this.twitter,
    this.privacyPolicy,
    this.termsCondition,
    this.legalPolicies,
    this.aboutUs,
    this.serviceContact,
    this.propertyMinAmount,
    this.propertyMaxAmount,
    this.commissionPercentage,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      appVersion: json['app_version'],
      forceUpdate: json['force_update'],
      maintenanceMode: json['maintainance_mode'],
      appDownload: json['app_download'],
      iosAppVersion: json['ios_app_version'],
      iosForceUpdate: json['ios_force_update'],
      iosMaintenanceMode: json['ios_maintainance_mode'],
      iosAppDownload: json['ios_app_download'],
      iosOnProduction: json['ios_on_production'] == 'on',
      email: json['email'],
      mobile: json['mobile'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      youtube: json['youtube'],
      twitter: json['twitter'],
      privacyPolicy: json['privacy_policy'],
      termsCondition: json['terms_condition'],
      legalPolicies: json['legal_policies'],
      aboutUs: json['about_us'],
      serviceContact: json['service_contact'],
      propertyMinAmount: json["property_min_amount"],
      propertyMaxAmount: json["property_max_amount"],
      commissionPercentage: json['commission_percent'],
    );
  }
}
