
import 'dart:convert';

IssueReportHistoryModel issueReportHistoryModelFromJson(String str) => IssueReportHistoryModel.fromJson(json.decode(str));

String issueReportHistoryModelToJson(IssueReportHistoryModel data) => json.encode(data.toJson());

class IssueReportHistoryModel {
  bool? status;
  String? message;
  List<ReportList>? reportList;

  IssueReportHistoryModel({
    this.status,
    this.message,
    this.reportList,
  });

  factory IssueReportHistoryModel.fromJson(Map<String, dynamic> json) => IssueReportHistoryModel(
    status: json["status"],
    message: json["message"],
    reportList: json["reportList"] == null ? [] : List<ReportList>.from(json["reportList"]!.map((x) => ReportList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "reportList": reportList == null ? [] : List<dynamic>.from(reportList!.map((x) => x.toJson())),
  };
}

class ReportList {
  int? id;
  int? deliveryId;
  int? driverId;
  int? supportId;
  String? type;
  int? issueCategoryId;
  String? description;
  String? action;
  String? status;
  DateTime? reportedAt;
  DateTime? claimedAt;
  DateTime? resolvedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;
  IssueCategory? issueCategory;
  List<dynamic>? issueMedia;
  Driver? driver;
  Delivery? delivery;

  ReportList({
    this.id,
    this.deliveryId,
    this.driverId,
    this.supportId,
    this.type,
    this.issueCategoryId,
    this.description,
    this.action,
    this.status,
    this.reportedAt,
    this.claimedAt,
    this.resolvedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
    this.issueCategory,
    this.issueMedia,
    this.driver,
    this.delivery,
  });

  factory ReportList.fromJson(Map<String, dynamic> json) => ReportList(
    id: json["id"],
    deliveryId: json["delivery_id"],
    driverId: json["driver_id"],
    supportId: json["support_id"],
    type: json["type"],
    issueCategoryId: json["issue_category_id"],
    description: json["description"],
    action: json["action"],
    status: json["status"],
    reportedAt: json["reported_at"] == null ? null : DateTime.parse(json["reported_at"]),
    claimedAt: json["claimed_at"] == null ? null : DateTime.parse(json["claimed_at"]),
    resolvedAt: json["resolved_at"] == null ? null : DateTime.parse(json["resolved_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
    issueCategory: json["issue_category"] == null ? null : IssueCategory.fromJson(json["issue_category"]),
    issueMedia: json["issue_media"] == null ? [] : List<dynamic>.from(json["issue_media"]!.map((x) => x)),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    delivery: json["delivery"] == null ? null : Delivery.fromJson(json["delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "delivery_id": deliveryId,
    "driver_id": driverId,
    "support_id": supportId,
    "type": type,
    "issue_category_id": issueCategoryId,
    "description": description,
    "action": action,
    "status": status,
    "reported_at": reportedAt?.toIso8601String(),
    "claimed_at": claimedAt?.toIso8601String(),
    "resolved_at": resolvedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
    "issue_category": issueCategory?.toJson(),
    "issue_media": issueMedia == null ? [] : List<dynamic>.from(issueMedia!.map((x) => x)),
    "driver": driver?.toJson(),
    "delivery": delivery?.toJson(),
  };
}

class Delivery {
  int? id;
  int? driverId;
  int? assignedBy;
  String? deliveryCode;
  String? pickupLocation;
  String? dropLocation;
  DateTime? estimatedDeliveryTime;
  String? deliveryType;
  dynamic deliveredTime;
  dynamic delayTime;
  dynamic delayReason;
  DateTime? startTime;
  dynamic endTime;
  String? status;
  String? remarks;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;

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
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    id: json["id"],
    driverId: json["driver_id"],
    assignedBy: json["assigned_by"],
    deliveryCode: json["delivery_code"],
    pickupLocation: json["pickup_location"],
    dropLocation: json["drop_location"],
    estimatedDeliveryTime: json["estimated_delivery_time"] == null ? null : DateTime.parse(json["estimated_delivery_time"]),
    deliveryType: json["delivery_type"],
    deliveredTime: json["delivered_time"],
    delayTime: json["delay_time"],
    delayReason: json["delay_reason"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"],
    status: json["status"],
    remarks: json["remarks"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "assigned_by": assignedBy,
    "delivery_code": deliveryCode,
    "pickup_location": pickupLocation,
    "drop_location": dropLocation,
    "estimated_delivery_time": estimatedDeliveryTime?.toIso8601String(),
    "delivery_type": deliveryType,
    "delivered_time": deliveredTime,
    "delay_time": delayTime,
    "delay_reason": delayReason,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime,
    "status": status,
    "remarks": remarks,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
  };
}

class Driver {
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

  Driver({
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

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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

class IssueCategory {
  int? id;
  String? category;
  String? issue;
  String? complexity;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;

  IssueCategory({
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

  factory IssueCategory.fromJson(Map<String, dynamic> json) => IssueCategory(
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
