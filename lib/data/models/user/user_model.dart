import 'vehicle_model.dart';

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? vehicleType;
  String? vehicleNumber;
  String? registrationCertificate;
  int? buildYear;
  String? panCard;
  String? drivingLicence;
  String? aadharCardFront;
  String? aadharCardBack;
  String? payeeName;
  String? accountNumber;
  String? ifscCode;
  String? bankName;
  String? bankBranch;
  String? cancelCheck;
  String? onDuty;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? vehicleId;
  int? twoWheelerTruckId;
  String? panCardNumber;
  String? aadharCardNumber;
  String? drivingLicenseNumber;
  String? latitude;
  String? longitude;
  String? lastLocationUpdated;
  Vehicle? vehicle;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.vehicleType,
    this.vehicleNumber,
    this.registrationCertificate,
    this.buildYear,
    this.panCard,
    this.drivingLicence,
    this.aadharCardFront,
    this.aadharCardBack,
    this.payeeName,
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.bankBranch,
    this.cancelCheck,
    this.onDuty,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vehicleId,
    this.twoWheelerTruckId,
    this.panCardNumber,
    this.aadharCardNumber,
    this.drivingLicenseNumber,
    this.latitude,
    this.longitude,
    this.lastLocationUpdated,
    this.vehicle,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
      registrationCertificate: json['registration_certificate'],
      buildYear: json['build_year'],
      panCard: json['pan_card'],
      drivingLicence: json['driving_licence'],
      aadharCardFront: json['aadhar_card_front'],
      aadharCardBack: json['aadhar_card_back'],
      payeeName: json['payee_name'],
      accountNumber: json['account_number'],
      ifscCode: json['ifsc_code'],
      bankName: json['bank_name'],
      bankBranch: json['bank_branch'],
      cancelCheck: json['cancel_check'],
      onDuty: json['on_duty'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      vehicleId: json['vehicle_id'],
      twoWheelerTruckId: json['two_wheeler_truck_id'],
      panCardNumber: json['pan_card_number'],
      aadharCardNumber: json['aadhar_card_number'],
      drivingLicenseNumber: json['driving_license_number'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      lastLocationUpdated: json['last_location_updated'],
      vehicle:
      json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'vehicle_type': vehicleType,
      'vehicle_number': vehicleNumber,
      'registration_certificate': registrationCertificate,
      'build_year': buildYear,
      'pan_card': panCard,
      'driving_licence': drivingLicence,
      'aadhar_card_front': aadharCardFront,
      'aadhar_card_back': aadharCardBack,
      'payee_name': payeeName,
      'account_number': accountNumber,
      'ifsc_code': ifscCode,
      'bank_name': bankName,
      'bank_branch': bankBranch,
      'cancel_check': cancelCheck,
      'on_duty': onDuty,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'vehicle_id': vehicleId,
      'two_wheeler_truck_id': twoWheelerTruckId,
      'pan_card_number': panCardNumber,
      'aadhar_card_number': aadharCardNumber,
      'driving_license_number': drivingLicenseNumber,
      'latitude': latitude,
      'longitude': longitude,
      'last_location_updated': lastLocationUpdated,
    };
  }

  bool get isDuty => onDuty == 'yes';
  bool get isTwoWheelerVehicle => vehicleType == 'motorbike';
  bool get isMiniTempoVehicle => vehicleType == 'mini_tempo';
  bool get isOpenTruck => vehicleType == 'open_truck';
  bool get isBodyPackTruck => vehicleType == 'body_pack_truck';
  bool get isMotorbike => isTwoWheelerVehicle || isMiniTempoVehicle;

  bool get isBankInfoEmpty {
    return payeeName == null &&
        accountNumber == null &&
        ifscCode == null &&
        bankName == null &&
        bankBranch == null &&
        cancelCheck == null;
  }

  bool get isDocumentEmpty {
    return aadharCardNumber == null &&
        panCardNumber == null &&
        drivingLicenseNumber == null;
  }
}
