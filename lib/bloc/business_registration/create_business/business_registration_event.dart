import 'package:flutter/cupertino.dart';
import 'package:market_place_app/data/models/merchant_business_profile_model.dart';

/// Base Event
abstract class BusinessRegistrationEvent {}

class MerchantRegistrationEvent extends BusinessRegistrationEvent {
  final MerchantRegistrationModel merchant;
  final BuildContext context;

  MerchantRegistrationEvent(this.merchant, this.context);
}

/// Opening Hours Model per day
class OpeningHour {
  late String? open;
  late String? close;
  late bool active;

  OpeningHour({this.open, this.close, this.active = false});

  factory OpeningHour.fromJson(Map<String, dynamic> json) {
    return OpeningHour(
      open: json['open'] as String?,
      close: json['close'] as String?,
      active: json['active'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'open': open,
      'close': close,
      'active': active,
    };
  }
}

// class BusinessImage {
//   final String url;
//   final String filename;
//
//   BusinessImage({required this.url, required this.filename});
//
//   factory BusinessImage.fromJson(Map<String, dynamic> json) {
//     return BusinessImage(
//       url: json['url'] as String,
//       filename: json['filename'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'url': url,
//       'filename': filename,
//     };
//   }
// }

/// Merchant Registration Model
class MerchantRegistrationModel {
  String? name;
  String? mobile;
  String? email;
  String? businessName;
  String? businessRegistrationNo;
  String? gstNumber;
  String? state;
  String? city;
  String? country;
  String? pinCode;
  String? landMark;
  String? category;
  String? subCategory;
  String? lat;
  String? long;
  String? address;
  String? aadhaarFront;
  String? aadhaarBack;
  String? panImage;
  String? gstCertificate;
  String? businessLogo;
  String? weekOffDay;
  List<BusinessImage>? businessImages;
  Map<String, OpeningHour>? openingHours;

  MerchantRegistrationModel({
    this.name,
    this.mobile,
    this.email,
    this.businessName,
    this.businessRegistrationNo,
    this.gstNumber,
    this.state,
    this.country,
    this.city,
    this.pinCode,
    this.landMark,
    this.category,
    this.subCategory,
    this.lat,
    this.long,
    this.address,
    this.aadhaarFront,
    this.aadhaarBack,
    this.panImage,
    this.gstCertificate,
    this.businessLogo,
    this.weekOffDay,
    this.businessImages,
    this.openingHours,
  });

  MerchantRegistrationModel copyWith({
    String? name,
    String? mobile,
    String? email,
    String? businessName,
    String? businessRegistrationNo,
    String? gstNumber,
    String? state,
    String? country,
    String? city,
    String? pinCode,
    String? landMark,
    String? category,
    String? subCategory,
    String? lat,
    String? long,
    String? address,
    String? aadhaarFront,
    String? aadhaarBack,
    String? panImage,
    String? gstCertificate,
    String? businessLogo,
    String? weekOffDay,
    List<BusinessImage>? businessImages,
    Map<String, OpeningHour>? openingHours,
  }) {
    return MerchantRegistrationModel(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      businessName: businessName ?? this.businessName,
      businessRegistrationNo:
      businessRegistrationNo ?? this.businessRegistrationNo,
      gstNumber: gstNumber ?? this.gstNumber,
      state: state ?? this.state,
      city: city ?? this.city,
      country: country ?? this.country,
      pinCode: pinCode ?? this.pinCode,
      landMark: landMark ?? this.landMark,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      address: address ?? this.address,
      aadhaarFront: aadhaarFront ?? this.aadhaarFront,
      aadhaarBack: aadhaarBack ?? this.aadhaarBack,
      panImage: panImage ?? this.panImage,
      gstCertificate: gstCertificate ?? this.gstCertificate,
      businessLogo: businessLogo ?? this.businessLogo,
      weekOffDay: weekOffDay ?? this.weekOffDay,
      businessImages: businessImages ?? this.businessImages,
      openingHours: openingHours ?? this.openingHours,
    );
  }
}
