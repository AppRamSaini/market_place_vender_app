
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
  bool? adharVerify;
  bool? panCardVerify;
  bool? gstCertificateVerify;
  String? id;
  String? businessName;
  String? city;
  String? area;
  int? pincode;
  String? category;
  String? subcategory;
  bool? panCard;
  dynamic gstNo;
  String? address;
  double? lat;
  double? long;
  dynamic landmark;
  String? adharFront;
  String? adharBack;
  String? panCardImage;
  String? gstCertificate;
  dynamic shopLicense;
  String? businessLogo;
  DateTime? weeklyOffDay;
  Vendor? vendor;
  String? status;
  String? verifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<BusinessImage>? businessImage;
  String? businessRegister;
  String? gstNumber;
  String? state;

  Data({
    this.openingHours,
    this.adharVerify,
    this.panCardVerify,
    this.gstCertificateVerify,
    this.id,
    this.businessName,
    this.city,
    this.area,
    this.pincode,
    this.category,
    this.subcategory,
    this.panCard,
    this.gstNo,
    this.address,
    this.lat,
    this.long,
    this.landmark,
    this.adharFront,
    this.adharBack,
    this.panCardImage,
    this.gstCertificate,
    this.shopLicense,
    this.businessLogo,
    this.weeklyOffDay,
    this.vendor,
    this.status,
    this.verifyStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.businessImage,
    this.businessRegister,
    this.gstNumber,
    this.state,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    adharVerify: json["adhar_verify"],
    panCardVerify: json["pan_card_verify"],
    gstCertificateVerify: json["gst_certificate_verify"],
    id: json["_id"],
    businessName: json["business_name"],
    city: json["city"],
    area: json["area"],
    pincode: json["pincode"],
    category: json["category"],
    subcategory: json["subcategory"],
    panCard: json["pan_card"],
    gstNo: json["GST_no"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    landmark: json["landmark"],
    adharFront: json["adhar_front"],
    adharBack: json["adhar_back"],
    panCardImage: json["pan_card_image"],
    gstCertificate: json["gst_certificate"],
    shopLicense: json["shop_license"],
    businessLogo: json["business_logo"],
    weeklyOffDay: json["weekly_off_day"] == null ? null : DateTime.parse(json["weekly_off_day"]),
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    status: json["status"],
    verifyStatus: json["Verify_status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    businessImage: json["business_image"] == null ? [] : List<BusinessImage>.from(json["business_image"]!.map((x) => BusinessImage.fromJson(x))),
    businessRegister: json["business_register"],
    gstNumber: json["gst_number"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "opening_hours": openingHours?.toJson(),
    "adhar_verify": adharVerify,
    "pan_card_verify": panCardVerify,
    "gst_certificate_verify": gstCertificateVerify,
    "_id": id,
    "business_name": businessName,
    "city": city,
    "area": area,
    "pincode": pincode,
    "category": category,
    "subcategory": subcategory,
    "pan_card": panCard,
    "GST_no": gstNo,
    "address": address,
    "lat": lat,
    "long": long,
    "landmark": landmark,
    "adhar_front": adharFront,
    "adhar_back": adharBack,
    "pan_card_image": panCardImage,
    "gst_certificate": gstCertificate,
    "shop_license": shopLicense,
    "business_logo": businessLogo,
    "weekly_off_day": weeklyOffDay?.toIso8601String(),
    "vendor": vendor?.toJson(),
    "status": status,
    "Verify_status": verifyStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "business_image": businessImage == null ? [] : List<dynamic>.from(businessImage!.map((x) => x.toJson())),
    "business_register": businessRegister,
    "gst_number": gstNumber,
    "state": state,
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
