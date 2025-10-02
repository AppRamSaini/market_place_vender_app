
import 'dart:convert';

SosHistoryModel sosHistoryModelFromJson(String str) => SosHistoryModel.fromJson(json.decode(str));

String sosHistoryModelToJson(SosHistoryModel data) => json.encode(data.toJson());

class SosHistoryModel {
  bool? status;
  String? message;
  List<Alert>? alerts;
  String? type;

  SosHistoryModel({
    this.status,
    this.message,
    this.alerts,
    this.type,
  });

  factory SosHistoryModel.fromJson(Map<String, dynamic> json) => SosHistoryModel(
    status: json["status"],
    message: json["message"],
    alerts: json["alerts"] == null ? [] : List<Alert>.from(json["alerts"]!.map((x) => Alert.fromJson(x))),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "alerts": alerts == null ? [] : List<dynamic>.from(alerts!.map((x) => x.toJson())),
    "type": type,
  };
}

class Alert {
  int? id;
  int? driverId;
  int? deliveryId;
  String? reason;
  String? notes;
  String? location;
  String? latitude;
  String? longitude;
  int? acknowledged;
  int? acknowledgedBy;
  DateTime? alertedAt;
  DateTime? acknowledgedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;
  List<Log>? sosLog;
  Log? latestLog;

  Alert({
    this.id,
    this.driverId,
    this.deliveryId,
    this.reason,
    this.notes,
    this.location,
    this.latitude,
    this.longitude,
    this.acknowledged,
    this.acknowledgedBy,
    this.alertedAt,
    this.acknowledgedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
    this.sosLog,
    this.latestLog,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    id: json["id"],
    driverId: json["driver_id"],
    deliveryId: json["delivery_id"],
    reason: json["reason"],
    notes: json["notes"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    acknowledged: json["acknowledged"],
    acknowledgedBy: json["acknowledged_by"],
    alertedAt: json["alerted_at"] == null ? null : DateTime.parse(json["alerted_at"]),
    acknowledgedAt: json["acknowledged_at"] == null ? null : DateTime.parse(json["acknowledged_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
    sosLog: json["sos_log"] == null ? [] : List<Log>.from(json["sos_log"]!.map((x) => Log.fromJson(x))),
    latestLog: json["latest_log"] == null ? null : Log.fromJson(json["latest_log"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "delivery_id": deliveryId,
    "reason": reason,
    "notes": notes,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "acknowledged": acknowledged,
    "acknowledged_by": acknowledgedBy,
    "alerted_at": alertedAt?.toIso8601String(),
    "acknowledged_at": acknowledgedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
    "sos_log": sosLog == null ? [] : List<dynamic>.from(sosLog!.map((x) => x.toJson())),
    "latest_log": latestLog?.toJson(),
  };
}

class Log {
  int? id;
  int? sosAlertId;
  dynamic userId;
  String? action;
  dynamic remarks;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;

  Log({
    this.id,
    this.sosAlertId,
    this.userId,
    this.action,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    id: json["id"],
    sosAlertId: json["sos_alert_id"],
    userId: json["user_id"],
    action: json["action"],
    remarks: json["remarks"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sos_alert_id": sosAlertId,
    "user_id": userId,
    "action": action,
    "remarks": remarks,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
  };
}
