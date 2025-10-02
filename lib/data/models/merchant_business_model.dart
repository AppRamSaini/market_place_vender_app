
import 'dart:convert';

MerchantBusinessModel merchantBusinessModelFromJson(String str) => MerchantBusinessModel.fromJson(json.decode(str));

String merchantBusinessModelToJson(MerchantBusinessModel data) => json.encode(data.toJson());

class MerchantBusinessModel {
  bool? status;
  String? message;
  Data? data;

  MerchantBusinessModel({
    this.status,
    this.message,
    this.data,
  });

  factory MerchantBusinessModel.fromJson(Map<String, dynamic> json) => MerchantBusinessModel(
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
  User? user;
  String? token;
  String? role;

  Data({
    this.user,
    this.token,
    this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "role": role,
  };
}

class User {
  String? businessName;
  String? city;
  String? area;
  int? pincode;
  String? category;
  String? subcategory;
  String? businessRegister;
  dynamic gstNo;
  String? address;
  double? lat;
  double? long;
  dynamic landmark;
  String? adharFront;
  String? adharBack;
  String? panCardImage;
  String? gstCertificate;
  String? gstNumber;
  List<BusinessImage>? businessImage;
  String? businessLogo;
  OpeningHours? openingHours;
  String? weeklyOffDay;
  String? vendor;
  String? status;
  String? verifyStatus;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.businessName,
    this.city,
    this.area,
    this.pincode,
    this.category,
    this.subcategory,
    this.businessRegister,
    this.gstNo,
    this.address,
    this.lat,
    this.long,
    this.landmark,
    this.adharFront,
    this.adharBack,
    this.panCardImage,
    this.gstCertificate,
    this.gstNumber,
    this.businessImage,
    this.businessLogo,
    this.openingHours,
    this.weeklyOffDay,
    this.vendor,
    this.status,
    this.verifyStatus,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    businessName: json["business_name"],
    city: json["city"],
    area: json["area"],
    pincode: json["pincode"],
    category: json["category"],
    subcategory: json["subcategory"],
    businessRegister: json["business_register"],
    gstNo: json["GST_no"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    landmark: json["landmark"],
    adharFront: json["adhar_front"],
    adharBack: json["adhar_back"],
    panCardImage: json["pan_card_image"],
    gstCertificate: json["gst_certificate"],
    gstNumber: json["gst_number"],
    businessImage: json["business_image"] == null ? [] : List<BusinessImage>.from(json["business_image"]!.map((x) => BusinessImage.fromJson(x))),
    businessLogo: json["business_logo"],
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    weeklyOffDay: json["weekly_off_day"],
    vendor: json["vendor"],
    status: json["status"],
    verifyStatus: json["Verify_status"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "business_name": businessName,
    "city": city,
    "area": area,
    "pincode": pincode,
    "category": category,
    "subcategory": subcategory,
    "business_register": businessRegister,
    "GST_no": gstNo,
    "address": address,
    "lat": lat,
    "long": long,
    "landmark": landmark,
    "adhar_front": adharFront,
    "adhar_back": adharBack,
    "pan_card_image": panCardImage,
    "gst_certificate": gstCertificate,
    "gst_number": gstNumber,
    "business_image": businessImage == null ? [] : List<dynamic>.from(businessImage!.map((x) => x.toJson())),
    "business_logo": businessLogo,
    "opening_hours": openingHours?.toJson(),
    "weekly_off_day": weeklyOffDay,
    "vendor": vendor,
    "status": status,
    "Verify_status": verifyStatus,
    "_id": id,
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
