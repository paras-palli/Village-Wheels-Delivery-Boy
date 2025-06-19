import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_wheels_delivery_boy/controllers/auth_controller/auth_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/basic_controller.dart';
import 'package:village_wheels_delivery_boy/controllers/location_controller.dart';
import 'package:village_wheels_delivery_boy/data/models/basic/state_model.dart';
import 'package:village_wheels_delivery_boy/data/models/response/response_model.dart';
import 'package:village_wheels_delivery_boy/data/models/user/user_model.dart';
import 'package:village_wheels_delivery_boy/data/repositories/register_repo.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/extensions.dart';

class Bussiness {
  String? key;
  String? name;
  String? image;
  bool isSellected;
  bool isGrey;
  Bussiness(
      {this.name,
        this.image,
        this.key,
        this.isSellected = false,
        this.isGrey = false});
}

List<Bussiness> bussinessList = [
  Bussiness(
    key: 'grocery',
    name: 'Groceries',
    image: Assets.imagesGrocery,
  ),
  Bussiness(
    key: 'fresh_mart',
    name: 'Fresh Mart',
    image: Assets.imagesFreshmart,
  ),
  Bussiness(
    key: 'medicine',
    name: 'Medicines',
    image: Assets.imagesMedicine,
  ),
  Bussiness(
    key: 'restaurant',
    name: 'Restaurant',
    image: Assets.imagesRestront,
  ),
];

class RegisterController extends GetxController implements GetxService {
  final RegisterRepo registerRepo;
  RegisterController({required this.registerRepo});
  //
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //-------------------Signup page------------------------
  //----signup page 01------
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  //----signup page 03------
  TextEditingController streetOne = TextEditingController();
  TextEditingController streetTwo = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  //----signup page 04-------
  File? selectedPancard;
  File? selectedDrivingLicense;
  File? selectedAadhaarCard;
  File? selectedAadhaarBackCard;
  //---signup page 05------
  TextEditingController payeeName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController reEnterAccountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  File? selecedCancelCheck;
  TextEditingController aadharCardNumber = TextEditingController();
  TextEditingController panCardNumber = TextEditingController();

  // -------- Prefill Data ---------
  void prefillProfileData() {
    final UserModel? userModel = Get.find<AuthController>().userModel;
    //-----Sign page one----------
    name.text = userModel?.name ?? 'NA';
    phone.text = userModel?.phone ?? '';
    email.text = userModel?.email ?? '';

    //---signup 4
    aadharCardNumber.text = userModel?.aadharCardNumber ?? '';
    panCardNumber.text = userModel?.panCardNumber ?? '';

    //---signup 5
    payeeName.text = userModel?.payeeName ?? "";
    accountNumber.text = userModel?.accountNumber ?? "";
    ifscCode.text = userModel?.ifscCode ?? "";
    bankName.text = userModel?.bankName ?? "";
    branchName.text = userModel?.bankBranch ?? "";
    update();
  }

  //-------address:-------
  //
  void initAddress() {
    final locationCtrl = Get.find<LocationController>();
    pincode.text = locationCtrl.placeMarkData.first.postalCode ?? '';
    state.text = locationCtrl.placeMarkData.first.administrativeArea ?? '';
    city.text = locationCtrl.placeMarkData.first.subLocality ?? '';
    update();
  }

  //------------register data-----------
  Map<String, dynamic> registerData() {
    Map<String, dynamic> data = {};

    final BasicController basicController = Get.find<BasicController>();
    final LocationController locationCtrl = Get.find<LocationController>();

    // Find state ID from state name
    final stateModel = basicController.states.firstWhere((s) => s.name?.toLowerCase().trim() == state.text.toLowerCase().trim(),
      orElse: () => StateModel(id: 0),
    );

    if (stateModel.id == 0) {
      log('State not found: ${state.text}', name: 'StateLookup');
      log('Available states: ${basicController.states.map((s) => s.name).join(', ')}',
          name: 'StateLookup');
      throw Exception('Invalid state selected: ${state.text}');
    }

    data = {
      'name': name.text,
      'email': email.text,
      'phone': phone.text,
      'store_name': name.text,
      'banner_image': getMultipartFile(selectedAadhaarCard),
      'aadhar_card_front': getMultipartFile(selectedAadhaarCard),
      'cancel_check_image': getMultipartFile(selecedCancelCheck),
      'aadhar_card_back': getMultipartFile(selectedAadhaarBackCard),
      'pan_card_image': getMultipartFile(selectedPancard),
      'business_registration_certificate': getMultipartFile(selectedPancard),
      'payee_name': payeeName.text,
      'account_number': accountNumber.text,
      'ifsc_code': ifscCode.text,
      'bank_name': bankName.text,
      'bank_branch': branchName.text,
      'aadhar_card_number': aadharCardNumber.text,
      'pan_card_number': panCardNumber.text,
      'address_line_one': streetOne.text,
      'address_line_two': streetTwo.text,
      'state_id': stateModel.id,
      'city': city.text,
      'pincode': pincode.text,
      'latitude': locationCtrl.latLng?.latitude.toString() ?? '',
      'longitude': locationCtrl.latLng?.longitude.toString() ?? '',
      'map_location':
      '${locationCtrl.latLng?.latitude},${locationCtrl.latLng?.longitude}',
    };
    for (int i = 0; i < selectedBussiness.length; i++) {
      data.addAll({'vertical_type[$i]': selectedBussiness[i]});
    }
    return data;
  }

  Future<ResponseModel> registerUser() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Response response = await registerRepo.register(data: registerData());
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, '${response.body['message']}', response.body);
        Get.snackbar(
          'Success',
          'Registration completed successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++ ${e.toString()} ++++++++++++++++++++', name: "ERROR AT registerUser()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //------selecte file--------
  void selectFiles({
    bool isDrivingLicense = false,
    bool isAadharCard = false,
    bool isAadharBackCard = false,
    bool isPancard = false,
    bool isCancelCheck = false,
    File? val,
  }) {
    if (isDrivingLicense) {
      selectedDrivingLicense = val;
    } else if (isAadharCard) {
      selectedAadhaarCard = val;
    } else if (isPancard) {
      selectedPancard = val;
    } else if (isCancelCheck) {
      selecedCancelCheck = val;
    } else if (isAadharBackCard) {
      selectedAadhaarBackCard = val;
    }
    update();
  }

  //
  void removeFiles({
    bool isDrivingLicense = false,
    bool isAadharCard = false,
    bool isAadharBackCard = false,
    bool isPancard = false,
    bool isCancelCheck = false,
  }) {
    if (isDrivingLicense) {
      selectedDrivingLicense = null;
    } else if (isAadharCard) {
      selectedAadhaarCard = null;
    } else if (isPancard) {
      selectedPancard = null;
    } else if (isCancelCheck) {
      selecedCancelCheck = null;
    } else if (isAadharBackCard) {
      selectedAadhaarBackCard = null;
    }

    update();
  }

  void cleanAllField() {
    name.clear();
    email.clear();
    address.clear();
    //
    // selectedBussiness = null;
    //
    streetOne.clear();
    streetTwo.clear();
    pincode.clear();
    state.clear();
    city.clear();

    //----signup page 04-------
    aadharCardNumber.clear();
    panCardNumber.clear();
    selectedPancard = null;
    selectedAadhaarCard = null;
    selectedAadhaarBackCard = null;
    Get.find<LocationController>().location = null;
    //---signup page 05------
    payeeName.clear();
    accountNumber.clear();
    reEnterAccountNumber.clear();
    ifscCode.clear();
    bankName.clear();
    branchName.clear();
    selecedCancelCheck = null;
    loadSignUpData();
    update();
  }

  //---------validate image-------\\
  bool isPanValid = false;
  bool isAadharCardFrontValid = false;
  bool isAadharCardBackValid = false;
  bool isRegistrationCertificateValid = false;
  bool isDrivingLicenseValid = false;

  void validateDocuments({isPan = false}) {
    if (isPan) {}
    update();
  }
  //get multipart file function------

  MultipartFile? getMultipartFile(File? file) {
    if (file == null) return null;
    return MultipartFile(file, filename: file.path.fileName);
  }

  Map<String, dynamic> updateProfileData() {
    final locationCtrl = Get.find<LocationController>();
    Map<String, dynamic> data = {};
    data = {
      'name': name.text,
      'email': email.text,
      'phone': phone.text,
      'store_name': name.text,
      'banner_image': getMultipartFile(selectedAadhaarCard),
      'aadhar_card_front': getMultipartFile(selectedAadhaarCard),
      'cancel_check': getMultipartFile(selecedCancelCheck),
      'aadhar_card_back': getMultipartFile(selectedAadhaarBackCard),
      'pan_card': getMultipartFile(selectedPancard),
      'business_registration_certificate': getMultipartFile(selectedPancard),
      'payee_name': payeeName.text,
      'account_number': accountNumber.text,
      'ifsc_code': ifscCode.text,
      'bank_name': bankName.text,
      'bank_branch': branchName.text,
      'aadhar_card_number': aadharCardNumber.text,
      'pan_card_number': panCardNumber.text,
      'address_line_one': streetOne.text,
      'address_line_two': streetTwo.text,
      'state_id': state.text,
      'city': city.text,
      'pincode': pincode.text,
      'latitude': locationCtrl.latLng?.latitude.toString() ?? '',
      'longitude': locationCtrl.latLng?.longitude.toString() ?? '',
      'map_location':
      '${locationCtrl.latLng?.latitude},${locationCtrl.latLng?.longitude}',
    };
    return data;
  }

  Future<ResponseModel> updateProfile() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Response response =
      await registerRepo.updateProfile(data: updateProfileData());

      if (response.statusCode == 200 && response.body['success']) {
        responseModel =
            ResponseModel(true, '${response.body['message']}', response.body);
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT updateProfile()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //-----------------------bussiness data--------------------------
  List<String> selectedBussiness = [];
  void selectBussinessFromBussinessList() {
    selectedBussiness.clear();
    for (var element in bussinessList) {
      if (element.isSellected) {
        if (!selectedBussiness.contains(element.key)) {
          selectedBussiness.add(element.key ?? '');
        }
      }
    }
    update();
  }

  void selectBussiness(Bussiness bussiness) {
    bool isGroceryOrFresh =
        bussiness.key == 'grocery' || bussiness.key == 'fresh_mart';
    for (var element in bussinessList) {
      if (isGroceryOrFresh) {
        if (element.key == bussiness.key) {
          if (element.isSellected) {
            element.isSellected = false;
          } else {
            element.isSellected = true;
          }
        } else if (element.key == 'grocery' || element.key == 'fresh_mart') {
        } else {
          element.isSellected = false;
          element.isGrey = true;
        }

        if (element.key == 'grocery' || element.key == 'fresh_mart') {
          element.isGrey = false;
        }
      } else {
        if (element.isSellected) {
          element.isSellected = false;
          element.isGrey = true;
        } else {
          element.isSellected = (element.key == bussiness.key);
          element.isGrey = (element.key != bussiness.key);
        }
      }
    }
    update();
  }

  //------------store signup data------------(Future use in signup)--
  Future<void> saveSignupData({
    required int index,
  }) async {
    final locationCtrl = Get.find<LocationController>();
    final prefs = await SharedPreferences.getInstance();
    log('Starting saveSignupData for index: $index', name: 'SharedPreferences');
    //
    if (index == 1) {
      await prefs.setString('name', name.text);
      await prefs.setString('email', email.text);
      log('Saved basic info - name: ${name.text}, email: ${email.text}',
          name: 'SharedPreferences');
    } else if (index == 2) {
      // await prefs.setString('bussiness', selectedBussiness?.key ?? '');
    } else if (index == 3) {
      await prefs.setDouble('lat', locationCtrl.latLng?.latitude ?? 0);
      await prefs.setDouble('long', locationCtrl.latLng?.longitude ?? 0);
      await prefs.setString('address_one', streetOne.text);
      await prefs.setString('address_two', streetTwo.text);
      log('Saved location data - lat: ${locationCtrl.latLng?.latitude}, long: ${locationCtrl.latLng?.longitude}',
          name: 'SharedPreferences');
    } else if (index == 4) {
      // Convert images to base64 strings
      if (selectedPancard != null) {
        final panBytes = await selectedPancard!.readAsBytes();
        final panBase64 = base64Encode(panBytes);
        await prefs.setString('pan_image', panBase64);
        log('Saved PAN card image - size: ${panBytes.length} bytes',
            name: 'SharedPreferences');
      }

      if (selectedAadhaarCard != null) {
        final aadhaarFrontBytes = await selectedAadhaarCard!.readAsBytes();
        final aadhaarFrontBase64 = base64Encode(aadhaarFrontBytes);
        await prefs.setString('aadhaar_front_image', aadhaarFrontBase64);
        log('Saved Aadhar front image - size: ${aadhaarFrontBytes.length} bytes',
            name: 'SharedPreferences');
      }

      if (selectedAadhaarBackCard != null) {
        final aadhaarBackBytes = await selectedAadhaarBackCard!.readAsBytes();
        final aadhaarBackBase64 = base64Encode(aadhaarBackBytes);
        await prefs.setString('aadhaar_back_image', aadhaarBackBase64);
        log('Saved Aadhar back image - size: ${aadhaarBackBytes.length} bytes',
            name: 'SharedPreferences');
      }

      if (selecedCancelCheck != null) {
        final cancelCheckBytes = await selecedCancelCheck!.readAsBytes();
        final cancelCheckBase64 = base64Encode(cancelCheckBytes);
        await prefs.setString('cancel_check_image', cancelCheckBase64);
        log('Saved cancel check image - size: ${cancelCheckBytes.length} bytes',
            name: 'SharedPreferences');
      }

      await prefs.setString('aadhar_card', aadharCardNumber.text);
      await prefs.setString('pan_card', panCardNumber.text);
      await prefs.setString('payee_name', payeeName.text);
      await prefs.setString('account_number', accountNumber.text);
      await prefs.setString('ifsc_code', ifscCode.text);
      await prefs.setString('bank_name', bankName.text);
      await prefs.setString('branch_name', branchName.text);
      log('Saved KYC details - Aadhar: ${aadharCardNumber.text}, PAN: ${panCardNumber.text}',
          name: 'SharedPreferences');
    }
    log('Completed saveSignupData for index: $index',
        name: 'SharedPreferences');
  }

  Future<void> loadSignUpData() async {
    final prefs = await SharedPreferences.getInstance();
    log('Starting loadSignUpData', name: 'SharedPreferences');

    // Load states if not already loaded
    final BasicController locationCtrl = Get.find<BasicController>();
    if (locationCtrl.states.isEmpty) await locationCtrl.fetchStates();

    //---one
    name.text = prefs.getString('name') ?? '';
    email.text = prefs.getString('email') ?? '';
    log('Loaded basic info - name: ${name.text}, email: ${email.text}',
        name: 'SharedPreferences');

    //two
    final bussinessKey = prefs.getString('bussiness') ?? '';
    for (var element in bussinessList) {
      if (element.key == bussinessKey) {
        // selectBussiness(element);
      }
    }

    //--three
    final lat = prefs.getDouble('lat') ?? 0;
    final long = prefs.getDouble('long') ?? 0;
    Get.find<LocationController>().getAddressFromLocation(LatLng(lat, long));
    streetOne.text = prefs.getString('address_one') ?? '';
    streetTwo.text = prefs.getString('address_two') ?? '';
    log('Loaded location data - lat: $lat, long: $long',
        name: 'SharedPreferences');

    //----four
    // Load images from base64 strings
    final panBase64 = prefs.getString('pan_image');
    final aadhaarFrontBase64 = prefs.getString('aadhaar_front_image');
    final aadhaarBackBase64 = prefs.getString('aadhaar_back_image');
    final cancelCheckBase64 = prefs.getString('cancel_check_image');

    if (panBase64 != null) {
      final panBytes = base64Decode(panBase64);
      final tempDir = await getTemporaryDirectory();
      final panFile = File('${tempDir.path}/pan.png');
      await panFile.writeAsBytes(panBytes);
      selectedPancard = panFile;
      log('Loaded PAN card image - size: ${panBytes.length} bytes',
          name: 'SharedPreferences');
    }

    if (aadhaarFrontBase64 != null) {
      final aadhaarFrontBytes = base64Decode(aadhaarFrontBase64);
      final tempDir = await getTemporaryDirectory();
      final aadhaarFrontFile = File('${tempDir.path}/aadhaar_front.png');
      await aadhaarFrontFile.writeAsBytes(aadhaarFrontBytes);
      selectedAadhaarCard = aadhaarFrontFile;
      log('Loaded Aadhar front image - size: ${aadhaarFrontBytes.length} bytes',
          name: 'SharedPreferences');
    }

    if (aadhaarBackBase64 != null) {
      final aadhaarBackBytes = base64Decode(aadhaarBackBase64);
      final tempDir = await getTemporaryDirectory();
      final aadhaarBackFile = File('${tempDir.path}/aadhaar_back.png');
      await aadhaarBackFile.writeAsBytes(aadhaarBackBytes);
      selectedAadhaarBackCard = aadhaarBackFile;
      log('Loaded Aadhar back image - size: ${aadhaarBackBytes.length} bytes',
          name: 'SharedPreferences');
    }

    if (cancelCheckBase64 != null) {
      final cancelCheckBytes = base64Decode(cancelCheckBase64);
      final tempDir = await getTemporaryDirectory();
      final cancelCheckFile = File('${tempDir.path}/cancel_check.png');
      await cancelCheckFile.writeAsBytes(cancelCheckBytes);
      selecedCancelCheck = cancelCheckFile;
      log('Loaded cancel check image - size: ${cancelCheckBytes.length} bytes',
          name: 'SharedPreferences');
    }

    aadharCardNumber.text = prefs.getString('aadhar_card') ?? '';
    panCardNumber.text = prefs.getString('pan_card') ?? '';
    payeeName.text = prefs.getString('payee_name') ?? '';
    accountNumber.text = prefs.getString('account_number') ?? '';
    ifscCode.text = prefs.getString('ifsc_code') ?? '';
    bankName.text = prefs.getString('bank_name') ?? '';
    branchName.text = prefs.getString('branch_name') ?? '';
    log('Loaded KYC details - Aadhar: ${aadharCardNumber.text}, PAN: ${panCardNumber.text}',
        name: 'SharedPreferences');

    log('Completed loadSignUpData', name: 'SharedPreferences');
  }

  Future<void> clearSignupData() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove text fields
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('bussiness');
    await prefs.remove('lat');
    await prefs.remove('long');
    await prefs.remove('address_one');
    await prefs.remove('address_two');
    await prefs.remove('aadhar_card');
    await prefs.remove('pan_card');
    await prefs.remove('payee_name');
    await prefs.remove('account_number');
    await prefs.remove('ifsc_code');
    await prefs.remove('bank_name');
    await prefs.remove('branch_name');

    // Remove image paths
    final paths = [
      prefs.getString('pan_image'),
      prefs.getString('aadhaar_front_image'),
      prefs.getString('aadhaar_back_image'),
      prefs.getString('cancel_check_image'),
    ];

    for (final path in paths) {
      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }

    await prefs.remove('pan_image');
    await prefs.remove('aadhaar_front_image');
    await prefs.remove('aadhaar_back_image');
    await prefs.remove('cancel_check_image');
  }
  //-----------kyc tab ---------------

  int selectedTab = 0;

  void selectTab(int index) {
    selectedTab = index;
    update();
  }
}
