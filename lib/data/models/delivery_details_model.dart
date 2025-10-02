// To parse this JSON data, do
//
//     final deliveryDetailsModel = deliveryDetailsModelFromJson(jsonString);

import 'dart:convert';

DeliveryDetailsModel deliveryDetailsModelFromJson(String str) => DeliveryDetailsModel.fromJson(json.decode(str));

String deliveryDetailsModelToJson(DeliveryDetailsModel data) => json.encode(data.toJson());

class DeliveryDetailsModel {
  bool? status;
  int? code;
  String? message;
  Delivery? delivery;

  DeliveryDetailsModel({
    this.status,
    this.code,
    this.message,
    this.delivery,
  });

  factory DeliveryDetailsModel.fromJson(Map<String, dynamic> json) => DeliveryDetailsModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    delivery: json["delivery"] == null ? null : Delivery.fromJson(json["delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "delivery": delivery?.toJson(),
  };
}

class Delivery {
  int? id;
  int? driverId;
  AssignedBy? assignedBy;
  String? deliveryCode;
  String? pickupLocation;
  String? dropLocation;
  DateTime? estimatedDeliveryTime;
  String? deliveryType;
  dynamic deliveredTime;
  dynamic delayTime;
  dynamic delayReason;
  String? startTime;
  String? endTime;
  String? status;
  String? remarks;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;
  AssignedBy? driver;

  Delivery({
    this.id,
    this.driverId,
    this.assignedBy,
    this.deliveryCode,
    this.pickupLocation,
    this.dropLocation,
    this.estimatedDeliveryTime,
    this.deliveryType,
    this.deliveredTime,
    this.delayTime,
    this.delayReason,
    this.startTime,
    this.endTime,
    this.status,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
    this.driver,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    id: json["id"],
    driverId: json["driver_id"],
    assignedBy: json["assigned_by"] == null ? null : AssignedBy.fromJson(json["assigned_by"]),
    deliveryCode: json["delivery_code"],
    pickupLocation: json["pickup_location"],
    dropLocation: json["drop_location"],
    estimatedDeliveryTime: json["estimated_delivery_time"] == null ? null : DateTime.parse(json["estimated_delivery_time"]),
    deliveryType: json["delivery_type"],
    deliveredTime: json["delivered_time"],
    delayTime: json["delay_time"],
    delayReason: json["delay_reason"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    status: json["status"],
    remarks: json["remarks"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
    driver: json["driver"] == null ? null : AssignedBy.fromJson(json["driver"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "assigned_by": assignedBy?.toJson(),
    "delivery_code": deliveryCode,
    "pickup_location": pickupLocation,
    "drop_location": dropLocation,
    "estimated_delivery_time": estimatedDeliveryTime?.toIso8601String(),
    "delivery_type": deliveryType,
    "delivered_time": deliveredTime,
    "delay_time": delayTime,
    "delay_reason": delayReason,
    "start_time": startTime??'',
    "end_time": endTime,
    "status": status,
    "remarks": remarks,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
    "driver": driver?.toJson(),
  };
}

class AssignedBy {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? mobileNumber;
  String? otp;
  DateTime? otpExpiredTime;
  String? role;
  String? roles;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;

  AssignedBy({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobileNumber,
    this.otp,
    this.otpExpiredTime,
    this.role,
    this.roles,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
  });

  factory AssignedBy.fromJson(Map<String, dynamic> json) => AssignedBy(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    mobileNumber: json["mobile_number"],
    otp: json["otp"],
    otpExpiredTime: json["otp_expired_time"] == null ? null : DateTime.parse(json["otp_expired_time"]),
    role: json["role"],
    roles: json["roles"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "mobile_number": mobileNumber,
    "otp": otp,
    "otp_expired_time": otpExpiredTime?.toIso8601String(),
    "role": role,
    "roles": roles,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
  };
}
