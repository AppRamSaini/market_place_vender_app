
import 'dart:convert';

IssueCategoryModel issueCategoryModelFromJson(String str) => IssueCategoryModel.fromJson(json.decode(str));

String issueCategoryModelToJson(IssueCategoryModel data) => json.encode(data.toJson());

class IssueCategoryModel {
  bool? status;
  String? message;
  List<CategoryData>? data;

  IssueCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory IssueCategoryModel.fromJson(Map<String, dynamic> json) => IssueCategoryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryData {
  int? id;
  String? category;
  String? issue;
  String? complexity;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;

  CategoryData({
    this.id,
    this.category,
    this.issue,
    this.complexity,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    category: json["category"],
    issue: json["issue"],
    complexity: json["complexity"],
    language: json["language"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "issue": issue,
    "complexity": complexity,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
  };
}
