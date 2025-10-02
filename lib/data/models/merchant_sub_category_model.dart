
import 'dart:convert';

MerchantSubCategoryModel merchantSubCategoryModelFromJson(String str) => MerchantSubCategoryModel.fromJson(json.decode(str));

String merchantSubCategoryModelToJson(MerchantSubCategoryModel data) => json.encode(data.toJson());

class MerchantSubCategoryModel {
  bool? status;
  String? message;
  List<MerchantSubCategoryData>? data;

  MerchantSubCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory MerchantSubCategoryModel.fromJson(Map<String, dynamic> json) => MerchantSubCategoryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<MerchantSubCategoryData>.from(json["data"]!.map((x) => MerchantSubCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MerchantSubCategoryData {
  String? id;
  int? subcategoryId;
  String? name;
  int? categoryId;

  MerchantSubCategoryData({
    this.id,
    this.subcategoryId,
    this.name,
    this.categoryId,
  });

  factory MerchantSubCategoryData.fromJson(Map<String, dynamic> json) => MerchantSubCategoryData(
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
