import 'package:market_place_app/data/models/merchant_business_model.dart';
import 'package:market_place_app/data/models/merchant_business_profile_model.dart';
import 'package:market_place_app/data/models/merchant_category_model.dart';
import 'package:market_place_app/data/models/merchant_sub_category_model.dart';
import 'package:market_place_app/data/models/update_merchant_business_model.dart';
import 'package:market_place_app/data/models/user_otp_modal.dart';
import 'package:market_place_app/utils/exports.dart';

class AuthRepository {
  final api = ApiManager();
  Future<UserModel?> loginUser(
      {required BuildContext context, required String mobileNumber}) async {
    var data = {'phone': mobileNumber};
    final result =
        await api.post(url: ApiEndPoints.sendOtp, data: data, useToken: false);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return UserModel.fromJson(result);
    }
  }

  /// otp verify
  Future<UserOtpModal?> otpVerify(
      {required BuildContext context,
      required String mobile,
      required String roleType,
      required String otp}) async {
    var data = {
      "phone": mobile.toString(),
      "otp": otp.toString(),
      'role': roleType.toString()
    };

    final result = await api.post(url: ApiEndPoints.otpVerify, data: data);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return UserOtpModal.fromJson(result);
    }
  }

  /// merchant registration
  Future merchantRegistration(
      {required BuildContext context,
      required MerchantRegistrationModel merchant}) async {
    var data = {
      "business_name": merchant.businessName,
      "city": merchant.city,
      "area": merchant.landMark,
      "pincode": merchant.pinCode,
      "category": merchant.category,
      "subcategory": merchant.subCategory,
      "name": merchant.name,
      "state": merchant.state,
      "phone": merchant.mobile,
      "role": "vendor",
      "lat": merchant.lat,
      "long": merchant.long,
      "address": merchant.address,
      "email": merchant.email,
      "aadhaar_front": merchant.aadhaarFront,
      "aadhaar_back": merchant.aadhaarBack,
      "pan_card_image": merchant.panImage,
      "gst_certificate": merchant.gstCertificate,
      "gst_number": merchant.gstNumber,
      "business_register": merchant.businessRegistrationNo,
      "business_logo": merchant.businessLogo,
      "weekly_off_day": merchant.weekOffDay,
      "business_image": merchant.businessImages,
      "opening_hours": merchant.openingHours
    };

    print('data--------->>>>>>$data');

    final result =
        await api.post(url: ApiEndPoints.merchantRegistration, data: data);
    print('--------->>>>>>$result');
    if (result is String) {
      return result;
    } else {
      return MerchantBusinessModel.fromJson(result);
    }
  }

  /// update merchant business
  Future<UpdateMerchantBusinessModel?> updateMerchantBusiness(
      {required BuildContext context,
      required MerchantRegistrationModel merchant}) async {
    var data = {
      "business_name": merchant.businessName,
      "city": merchant.city,
      "area": merchant.landMark,
      "pincode": merchant.pinCode,
      "category": merchant.category,
      "subcategory": merchant.subCategory,
      "name": merchant.name,
      "state": merchant.state,
      "country": merchant.country,
      "phone": merchant.mobile,
      "role": "vendor",
      "lat": merchant.lat,
      "long": merchant.long,
      "address": merchant.address,
      "email": merchant.email,
      "aadhaar_front": merchant.aadhaarFront,
      "aadhaar_back": merchant.aadhaarBack,
      "pan_card_image": merchant.panImage,
      "gst_certificate": merchant.gstCertificate,
      "gst_number": merchant.gstNumber,
      "business_register": merchant.businessRegistrationNo,
      "business_logo": merchant.businessLogo,
      "weekly_off_day": merchant.weekOffDay,
      "business_image": merchant.businessImages,
      "opening_hours": merchant.openingHours
    };
    print('JSON===>>>$data');
    final result =
        await api.post(url: ApiEndPoints.updateMerchantBusiness, data: data,context: context);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return UpdateMerchantBusinessModel.fromJson(result);
    }
  }

  /// get business category
  Future fetchMerchantCategory() async {
    final result = await api.get(url: ApiEndPoints.merchantCategory);
    if (result is String) {
      return result;
    } else {
      return MerchantCategoryModel.fromJson(result);
    }
  }

  /// get business sub category
  Future fetchMerchantSubCategory(String categoryId) async {
    final result =
        await api.get(url: "${ApiEndPoints.merchantSubCategory}/$categoryId");
    if (result is String) {
      return result;
    } else {
      return MerchantSubCategoryModel.fromJson(result);
    }
  }

  /// fetch business profile data
  Future fetchBusinessProfile(BuildContext context) async {
    final result =
        await api.get(url: ApiEndPoints.fetchBusinessProfile,context: context);
    if (result is String) {
      return result;
    } else {
      return MerchantBusinessProfileModel.fromJson(result);
    }
  }
}
