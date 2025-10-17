
import 'dart:convert';

UpdateMerchantBusinessModel updateMerchantBusinessModelFromJson(String str) => UpdateMerchantBusinessModel.fromJson(json.decode(str));

String updateMerchantBusinessModelToJson(UpdateMerchantBusinessModel data) => json.encode(data.toJson());

class UpdateMerchantBusinessModel {
  bool? status;
  String? message;
  Data? data;

  UpdateMerchantBusinessModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateMerchantBusinessModel.fromJson(Map<String, dynamic> json) => UpdateMerchantBusinessModel(
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
  OpeningHours? openingHours;
  dynamic aadhaarFront;
  dynamic aadhaarBack;
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
  Vendor? vendor;
  String? status;
  String? verifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.openingHours,
    this.aadhaarFront,
    this.aadhaarBack,
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
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    aadhaarFront: json["aadhaar_front"],
    aadhaarBack: json["aadhaar_back"],
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
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    status: json["status"],
    verifyStatus: json["Verify_status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "opening_hours": openingHours?.toJson(),
    "aadhaar_front": aadhaarFront,
    "aadhaar_back": aadhaarBack,
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
    "vendor": vendor?.toJson(),
    "status": status,
    "Verify_status": verifyStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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

class Vendor {
  String? id;
  String? name;
  int? phone;
  String? avatar;
  String? status;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Vendor({
    this.id,
    this.name,
    this.phone,
    this.avatar,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    avatar: json["avatar"],
    status: json["status"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "avatar": avatar,
    "status": status,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
