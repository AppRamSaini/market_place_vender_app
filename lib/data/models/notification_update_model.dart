
import 'dart:convert';

NotificationUpdateModel notificationUpdateModelFromJson(String str) => NotificationUpdateModel.fromJson(json.decode(str));

String notificationUpdateModelToJson(NotificationUpdateModel data) => json.encode(data.toJson());

class NotificationUpdateModel {
  bool? status;
  String? message;
  Data? data;

  NotificationUpdateModel({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationUpdateModel.fromJson(Map<String, dynamic> json) => NotificationUpdateModel(
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
  int? userId;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.userId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
