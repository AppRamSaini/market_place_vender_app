
import 'dart:convert';

NotificationTypesModel notificationTypesModelFromJson(String str) => NotificationTypesModel.fromJson(json.decode(str));

String notificationTypesModelToJson(NotificationTypesModel data) => json.encode(data.toJson());

class NotificationTypesModel {
  bool? status;
  String? message;
  List<NotificationType>? data;

  NotificationTypesModel({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationTypesModel.fromJson(Map<String, dynamic> json) => NotificationTypesModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<NotificationType>.from(json["data"]!.map((x) => NotificationType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationType {
  String? id;
  int? userId;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  NotificationType({
    this.id,
    this.userId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory NotificationType.fromJson(Map<String, dynamic> json) => NotificationType(
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
