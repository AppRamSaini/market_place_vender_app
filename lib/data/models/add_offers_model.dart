
import 'dart:convert';

SubmitOffersModel submitOffersModelFromJson(String str) => SubmitOffersModel.fromJson(json.decode(str));

String submitOffersModelToJson(SubmitOffersModel data) => json.encode(data.toJson());

class SubmitOffersModel {
  bool? status;
  String? message;
  Data? data;

  SubmitOffersModel({
    this.status,
    this.message,
    this.data,
  });

  factory SubmitOffersModel.fromJson(Map<String, dynamic> json) => SubmitOffersModel(
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
  String? title;
  String? description;
  int? discountPercentage;
  int? maxDiscountCap;
  int? minBillAmount;
  DateTime? expiryDate;
  String? offerImage;
  String? status;
  String? vendor;
  int? amount;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
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
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    description: json["description"],
    discountPercentage: json["discountPercentage"],
    maxDiscountCap: json["maxDiscountCap"],
    minBillAmount: json["minBillAmount"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    offerImage: json["offer_image"],
    status: json["status"],
    vendor: json["vendor"],
    amount: json["amount"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "discountPercentage": discountPercentage,
    "maxDiscountCap": maxDiscountCap,
    "minBillAmount": minBillAmount,
    "expiryDate": expiryDate?.toIso8601String(),
    "offer_image": offerImage,
    "status": status,
    "vendor": vendor,
    "amount": amount,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
