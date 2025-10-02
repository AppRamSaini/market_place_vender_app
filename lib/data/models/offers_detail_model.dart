
import 'dart:convert';

OffersDetailModel offersDetailModelFromJson(String str) => OffersDetailModel.fromJson(json.decode(str));

String offersDetailModelToJson(OffersDetailModel data) => json.encode(data.toJson());

class OffersDetailModel {
  bool? status;
  String? message;
  Data? data;

  OffersDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory OffersDetailModel.fromJson(Map<String, dynamic> json) => OffersDetailModel(
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
  Record? record;
  int? redeem;
  int? purchase;
  int? pending;

  Data({
    this.record,
    this.redeem,
    this.purchase,
    this.pending,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    record: json["record"] == null ? null : Record.fromJson(json["record"]),
    redeem: json["redeem"],
    purchase: json["purchase"],
    pending: json["pending"],
  );

  Map<String, dynamic> toJson() => {
    "record": record?.toJson(),
    "redeem": redeem,
    "purchase": purchase,
    "pending": pending,
  };
}

class Record {
  String? id;
  String? title;
  String? description;
  int? discountPercentage;
  int? maxDiscountCap;
  int? minBillAmount;
  DateTime? expiryDate;
  String? offerImage;
  String? status;
  Vendor? vendor;
  int? amount;
  bool? isExpire;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Record({
    this.id,
    this.title,
    this.description,
    this.discountPercentage,
    this.maxDiscountCap,
    this.minBillAmount,
    this.expiryDate,
    this.offerImage,
    this.status,
    this.vendor,
    this.amount,
    this.isExpire,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    discountPercentage: json["discountPercentage"],
    maxDiscountCap: json["maxDiscountCap"],
    minBillAmount: json["minBillAmount"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    offerImage: json["offer_image"],
    status: json["status"],
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    amount: json["amount"],
    isExpire: json["IsExpire"],
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
    "status": status,
    "vendor": vendor?.toJson(),
    "amount": amount,
    "IsExpire": isExpire,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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
