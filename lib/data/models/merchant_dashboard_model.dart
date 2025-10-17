
import 'dart:convert';

import 'package:market_place_app/data/models/fetchoffers_model.dart';

MerchantDashboardModel merchantDashboardModelFromJson(String str) => MerchantDashboardModel.fromJson(json.decode(str));

String merchantDashboardModelToJson(MerchantDashboardModel data) => json.encode(data.toJson());

class MerchantDashboardModel {
  bool? status;
  String? message;
  Data? data;

  MerchantDashboardModel({
    this.status,
    this.message,
    this.data,
  });

  factory MerchantDashboardModel.fromJson(Map<String, dynamic> json) => MerchantDashboardModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Stats? stats;
  List<OffersList>? offers;
  Vendors? vendors;

  Data({
    this.stats,
    this.offers,
    this.vendors,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    offers: json["offers"] == null ? [] : List<OffersList>.from(json["offers"]!.map((x) => OffersList.fromJson(x))),
    vendors: json["vendors"] == null ? null : Vendors.fromJson(json["vendors"]),
  );

  Map<String, dynamic> toJson() => {
    "stats": stats?.toJson(),
    "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
    "vendors": vendors?.toJson(),
  };
}

// class Offer {
//   String? id;
//   String? vendor;
//   Flat? flat;
//   dynamic percentage;
//   String? type;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   Offer({
//     this.id,
//     this.vendor,
//     this.flat,
//     this.percentage,
//     this.type,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory Offer.fromJson(Map<String, dynamic> json) => Offer(
//     id: json["_id"],
//     vendor: json["vendor"],
//     flat: json["flat"] == null ? null : Flat.fromJson(json["flat"]),
//     percentage: json["percentage"],
//     type: json["type"],
//     status: json["status"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "vendor": vendor,
//     "flat": flat?.toJson(),
//     "percentage": percentage,
//     "type": type,
//     "status": status,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }

class Flat {
  String? id;
  String? title;
  String? description;
  int? discountPercentage;
  int? maxDiscountCap;
  int? minBillAmount;
  DateTime? expiryDate;
  String? offerImage;
  int? amount;
  bool? isExpired;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Flat({
    this.id,
    this.title,
    this.description,
    this.discountPercentage,
    this.maxDiscountCap,
    this.minBillAmount,
    this.expiryDate,
    this.offerImage,
    this.amount,
    this.isExpired,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Flat.fromJson(Map<String, dynamic> json) => Flat(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    discountPercentage: json["discountPercentage"],
    maxDiscountCap: json["maxDiscountCap"],
    minBillAmount: json["minBillAmount"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    offerImage: json["offer_image"],
    amount: json["amount"],
    isExpired: json["isExpired"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "discountPercentage": discountPercentage,
    "maxDiscountCap": maxDiscountCap,
    "minBillAmount": minBillAmount,
    "expiryDate": expiryDate?.toIso8601String(),
    "offer_image": offerImage,
    "amount": amount,
    "isExpired": isExpired,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Stats {
  int? totalSales;
  int? redeemedOfferes;
  int? pendingOffers;
  int? totalCustomers;

  Stats({
    this.totalSales,
    this.redeemedOfferes,
    this.pendingOffers,
    this.totalCustomers,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    totalSales: json["total_sales"],
    redeemedOfferes: json["redeemed_offeres"],
    pendingOffers: json["pending_offers"],
    totalCustomers: json["total_customers"],
  );

  Map<String, dynamic> toJson() => {
    "total_sales": totalSales,
    "redeemed_offeres": redeemedOfferes,
    "pending_offers": pendingOffers,
    "total_customers": totalCustomers,
  };
}

class Vendors {
  OpeningHours? openingHours;
  String? aadhaarVerify;
  String? country;
  String? id;
  String? state;
  String? businessName;
  String? city;
  String? area;
  int? pincode;
  String? category;
  String? subcategory;
  String? businessRegister;
  String? address;
  double? lat;
  double? long;
  String? adharFront;
  String? adharBack;
  bool? adharVerify;
  String? panCardImage;
  String? panCardVerify;
  String? gstCertificate;
  String? gstCertificateVerify;
  String? gstNumber;
  List<BusinessImage>? businessImage;
  String? businessLogo;
  DateTime? weeklyOffDay;
  String? vendor;
  String? status;
  String? verifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? aadhaarBack;
  String? aadhaarFront;

  Vendors({
    this.openingHours,
    this.aadhaarVerify,
    this.country,
    this.id,
    this.state,
    this.businessName,
    this.city,
    this.area,
    this.pincode,
    this.category,
    this.subcategory,
    this.businessRegister,
    this.address,
    this.lat,
    this.long,
    this.adharFront,
    this.adharBack,
    this.adharVerify,
    this.panCardImage,
    this.panCardVerify,
    this.gstCertificate,
    this.gstCertificateVerify,
    this.gstNumber,
    this.businessImage,
    this.businessLogo,
    this.weeklyOffDay,
    this.vendor,
    this.status,
    this.verifyStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.aadhaarBack,
    this.aadhaarFront,
  });

  factory Vendors.fromJson(Map<String, dynamic> json) => Vendors(
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    aadhaarVerify: json["aadhaar_verify"],
    country: json["country"],
    id: json["_id"],
    state: json["state"],
    businessName: json["business_name"],
    city: json["city"],
    area: json["area"],
    pincode: json["pincode"],
    category: json["category"],
    subcategory: json["subcategory"],
    businessRegister: json["business_register"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    adharFront: json["adhar_front"],
    adharBack: json["adhar_back"],
    adharVerify: json["adhar_verify"],
    panCardImage: json["pan_card_image"],
    panCardVerify: json["pan_card_verify"],
    gstCertificate: json["gst_certificate"],
    gstCertificateVerify: json["gst_certificate_verify"],
    gstNumber: json["gst_number"],
    businessImage: json["business_image"] == null ? [] : List<BusinessImage>.from(json["business_image"]!.map((x) => BusinessImage.fromJson(x))),
    businessLogo: json["business_logo"],
    weeklyOffDay: json["weekly_off_day"] == null ? null : DateTime.parse(json["weekly_off_day"]),
    vendor: json["vendor"],
    status: json["status"],
    verifyStatus: json["Verify_status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    aadhaarBack: json["aadhaar_back"],
    aadhaarFront: json["aadhaar_front"],
  );

  Map<String, dynamic> toJson() => {
    "opening_hours": openingHours?.toJson(),
    "aadhaar_verify": aadhaarVerify,
    "country": country,
    "_id": id,
    "state": state,
    "business_name": businessName,
    "city": city,
    "area": area,
    "pincode": pincode,
    "category": category,
    "subcategory": subcategory,
    "business_register": businessRegister,
    "address": address,
    "lat": lat,
    "long": long,
    "adhar_front": adharFront,
    "adhar_back": adharBack,
    "adhar_verify": adharVerify,
    "pan_card_image": panCardImage,
    "pan_card_verify": panCardVerify,
    "gst_certificate": gstCertificate,
    "gst_certificate_verify": gstCertificateVerify,
    "gst_number": gstNumber,
    "business_image": businessImage == null ? [] : List<dynamic>.from(businessImage!.map((x) => x.toJson())),
    "business_logo": businessLogo,
    "weekly_off_day": weeklyOffDay?.toIso8601String(),
    "vendor": vendor,
    "status": status,
    "Verify_status": verifyStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "aadhaar_back": aadhaarBack,
    "aadhaar_front": aadhaarFront,
  };
}

class BusinessImage {
  String? url;
  String? filename;

  BusinessImage({
    this.url,
    this.filename,
  });

  factory BusinessImage.fromJson(Map<String, dynamic> json) => BusinessImage(
    url: json["url"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "filename": filename,
  };
}

class OpeningHours {
  Fri? mon;
  Fri? tue;
  Fri? wed;
  Fri? thu;
  Fri? fri;
  Fri? sat;
  Fri? sun;

  OpeningHours({
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    mon: json["Mon"] == null ? null : Fri.fromJson(json["Mon"]),
    tue: json["Tue"] == null ? null : Fri.fromJson(json["Tue"]),
    wed: json["Wed"] == null ? null : Fri.fromJson(json["Wed"]),
    thu: json["Thu"] == null ? null : Fri.fromJson(json["Thu"]),
    fri: json["Fri"] == null ? null : Fri.fromJson(json["Fri"]),
    sat: json["Sat"] == null ? null : Fri.fromJson(json["Sat"]),
    sun: json["Sun"] == null ? null : Fri.fromJson(json["Sun"]),
  );

  Map<String, dynamic> toJson() => {
    "Mon": mon?.toJson(),
    "Tue": tue?.toJson(),
    "Wed": wed?.toJson(),
    "Thu": thu?.toJson(),
    "Fri": fri?.toJson(),
    "Sat": sat?.toJson(),
    "Sun": sun?.toJson(),
  };
}

class Fri {
  String? open;
  String? close;
  bool? active;

  Fri({
    this.open,
    this.close,
    this.active,
  });

  factory Fri.fromJson(Map<String, dynamic> json) => Fri(
    open: json["open"],
    close: json["close"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "open": open,
    "close": close,
    "active": active,
  };
}
