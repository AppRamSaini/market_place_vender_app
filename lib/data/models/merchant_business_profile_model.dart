import 'dart:convert';

MerchantBusinessProfileModel merchantBusinessProfileModelFromJson(String str) => MerchantBusinessProfileModel.fromJson(json.decode(str));

String merchantBusinessProfileModelToJson(MerchantBusinessProfileModel data) => json.encode(data.toJson());

class MerchantBusinessProfileModel {
  bool? status;
  String? message;
  Data? data;

  MerchantBusinessProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory MerchantBusinessProfileModel.fromJson(Map<String, dynamic> json) => MerchantBusinessProfileModel(
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
  String? id;
  Document? document;
  BusinessDetails? businessDetails;
  Timing? timing;
  Vendor? vendor;
  String? status;
  String? verifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  Percentages? percentages;

  Data({
    this.id,
    this.document,
    this.businessDetails,
    this.timing,
    this.vendor,
    this.status,
    this.verifyStatus,
    this.createdAt,
    this.updatedAt,
    this.percentages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    document: json["document"] == null ? null : Document.fromJson(json["document"]),
    businessDetails: json["business_details"] == null ? null : BusinessDetails.fromJson(json["business_details"]),
    timing: json["timing"] == null ? null : Timing.fromJson(json["timing"]),
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    status: json["status"],
    verifyStatus: json["Verify_status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    percentages: json["percentages"] == null ? null : Percentages.fromJson(json["percentages"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "document": document?.toJson(),
    "business_details": businessDetails?.toJson(),
    "timing": timing?.toJson(),
    "vendor": vendor?.toJson(),
    "status": status,
    "Verify_status": verifyStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "percentages": percentages?.toJson(),
  };
}

class BusinessDetails {
  String? businessName;
  Category? category;
  Subcategory? subcategory;
  String? businessRegister;
  String? gstNumber;
  String? address;
  String? city;
  String? area;
  int? pincode;
  double? lat;
  double? long;
  List<BusinessImage>? businessImage;
  String? state;
  String? email;
  String? country;

  BusinessDetails({
    this.businessName,
    this.category,
    this.subcategory,
    this.businessRegister,
    this.gstNumber,
    this.address,
    this.city,
    this.area,
    this.pincode,
    this.lat,
    this.long,
    this.businessImage,
    this.state,
    this.email,
    this.country,
  });

  factory BusinessDetails.fromJson(Map<String, dynamic> json) => BusinessDetails(
    businessName: json["business_name"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : Subcategory.fromJson(json["subcategory"]),
    businessRegister: json["business_register"],
    gstNumber: json["gst_number"],
    address: json["address"],
    city: json["city"],
    area: json["area"],
    pincode: json["pincode"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    businessImage: json["business_image"] == null ? [] : List<BusinessImage>.from(json["business_image"]!.map((x) => BusinessImage.fromJson(x))),
    state: json["state"],
    email: json["email"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "business_name": businessName,
    "category": category?.toJson(),
    "subcategory": subcategory?.toJson(),
    "business_register": businessRegister,
    "gst_number": gstNumber,
    "address": address,
    "city": city,
    "area": area,
    "pincode": pincode,
    "lat": lat,
    "long": long,
    "business_image": businessImage == null ? [] : List<dynamic>.from(businessImage!.map((x) => x.toJson())),
    "state": state,
    "email": email,
    "country": country,
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

class Category {
  String? id;
  String? name;
  int? categoryId;

  Category({
    this.id,
    this.name,
    this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    categoryId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "id": categoryId,
  };
}

class Subcategory {
  String? id;
  int? subcategoryId;
  String? name;
  int? categoryId;

  Subcategory({
    this.id,
    this.subcategoryId,
    this.name,
    this.categoryId,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["_id"],
    subcategoryId: json["subcategory_id"],
    name: json["name"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subcategory_id": subcategoryId,
    "name": name,
    "category_id": categoryId,
  };
}

class Document {
  String? businessLogo;
  String? aadhaarFront;
  String? aadhaarBack;
  String? panCardImage;
  String? gstCertificate;
  String? aadhaarVerify;
  String? panCardVerify;
  String? gstCertificateVerify;

  Document({
    this.businessLogo,
    this.aadhaarFront,
    this.aadhaarBack,
    this.panCardImage,
    this.gstCertificate,
    this.aadhaarVerify,
    this.panCardVerify,
    this.gstCertificateVerify,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    businessLogo: json["business_logo"],
    aadhaarFront: json["aadhaar_front"],
    aadhaarBack: json["aadhaar_back"],
    panCardImage: json["pan_card_image"],
    gstCertificate: json["gst_certificate"],
    aadhaarVerify: json["aadhaar_verify"],
    panCardVerify: json["pan_card_verify"],
    gstCertificateVerify: json["gst_certificate_verify"],
  );

  Map<String, dynamic> toJson() => {
    "business_logo": businessLogo,
    "aadhaar_front": aadhaarFront,
    "aadhaar_back": aadhaarBack,
    "pan_card_image": panCardImage,
    "gst_certificate": gstCertificate,
    "aadhaar_verify": aadhaarVerify,
    "pan_card_verify": panCardVerify,
    "gst_certificate_verify": gstCertificateVerify,
  };
}

class Percentages {
  int? document;
  int? businessDetails;
  int? timing;
  int? vendorSales;

  Percentages({
    this.document,
    this.businessDetails,
    this.timing,
    this.vendorSales,
  });

  factory Percentages.fromJson(Map<String, dynamic> json) => Percentages(
    document: json["document"],
    businessDetails: json["business_details"],
    timing: json["timing"],
    vendorSales: json["vendor_sales"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
    "business_details": businessDetails,
    "timing": timing,
    "vendor_sales": vendorSales,
  };
}

class Timing {
  OpeningHours? openingHours;
  DateTime? weeklyOffDay;

  Timing({
    this.openingHours,
    this.weeklyOffDay,
  });

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    weeklyOffDay: json["weekly_off_day"] == null ? null : DateTime.parse(json["weekly_off_day"]),
  );

  Map<String, dynamic> toJson() => {
    "opening_hours": openingHours?.toJson(),
    "weekly_off_day": weeklyOffDay?.toIso8601String(),
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
  String? email;

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
    this.email,
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
    email: json["email"],
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
    "email": email,
  };
}
