
import 'dart:convert';

FetchOffersListModel fetchOffersListModelFromJson(String str) => FetchOffersListModel.fromJson(json.decode(str));

String fetchOffersListModelToJson(FetchOffersListModel data) => json.encode(data.toJson());

class FetchOffersListModel {
  bool? status;
  String? message;
  List<OffersList>? data;

  FetchOffersListModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchOffersListModel.fromJson(Map<String, dynamic> json) => FetchOffersListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<OffersList>.from(json["data"]!.map((x) => OffersList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OffersList {
  String? id;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  OffersList({
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
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OffersList.fromJson(Map<String, dynamic> json) => OffersList(
    id: json["_id"],
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
    "vendor": vendor,
    "amount": amount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
