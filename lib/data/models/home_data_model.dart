
import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  HomeDataModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? delayedTrips;
  int? sosReports;
  int? assignedDeliveries;
  int? completedDeliveries;
  int? inProcessDeliveries;
  int? runningQueries;
  List<RecentActivity>? recentActivity;

  Data({
    this.delayedTrips,
    this.sosReports,
    this.assignedDeliveries,
    this.completedDeliveries,
    this.inProcessDeliveries,
    this.runningQueries,
    this.recentActivity,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    delayedTrips: json["delayed_trips"],
    sosReports: json["sos_reports"],
    assignedDeliveries: json["assigned_deliveries"],
    completedDeliveries: json["completed_deliveries"],
    inProcessDeliveries: json["in_process_deliveries"],
    runningQueries: json["running_queries"],
    recentActivity: json["recent_activity"] == null ? [] : List<RecentActivity>.from(json["recent_activity"]!.map((x) => RecentActivity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "delayed_trips": delayedTrips,
    "sos_reports": sosReports,
    "assigned_deliveries": assignedDeliveries,
    "completed_deliveries": completedDeliveries,
    "in_process_deliveries": inProcessDeliveries,
    "running_queries": runningQueries,
    "recent_activity": recentActivity == null ? [] : List<dynamic>.from(recentActivity!.map((x) => x.toJson())),
  };
}

class RecentActivity {
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
  List<Delivery>? deliveries;
  List<Issue>? issues;
  UserDetail? userDetail;

  RecentActivity({
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
    this.deliveries,
    this.issues,
    this.userDetail,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) => RecentActivity(
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
    deliveries: json["deliveries"] == null ? [] : List<Delivery>.from(json["deliveries"]!.map((x) => Delivery.fromJson(x))),
    issues: json["issues"] == null ? [] : List<Issue>.from(json["issues"]!.map((x) => Issue.fromJson(x))),
    userDetail: json["user_detail"] == null ? null : UserDetail.fromJson(json["user_detail"]),
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
    "deliveries": deliveries == null ? [] : List<dynamic>.from(deliveries!.map((x) => x.toJson())),
    "issues": issues == null ? [] : List<dynamic>.from(issues!.map((x) => x.toJson())),
    "user_detail": userDetail?.toJson(),
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
  DateTime? deliveredTime;
  dynamic delayTime;
  dynamic delayReason;
  DateTime? startTime;
  DateTime? endTime;
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
    deliveredTime: json["delivered_time"] == null ? null : DateTime.parse(json["delivered_time"]),
    delayTime: json["delay_time"],
    delayReason: json["delay_reason"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
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
    "delivered_time": deliveredTime?.toIso8601String(),
    "delay_time": delayTime,
    "delay_reason": delayReason,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime?.toIso8601String(),
    "status": status,
    "remarks": remarks,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
  };
}

class Issue {
  int? id;
  int? deliveryId;
  int? driverId;
  int? supportId;
  Type? type;
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

  Issue({
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
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
    id: json["id"],
    deliveryId: json["delivery_id"],
    driverId: json["driver_id"],
    supportId: json["support_id"],
    type: typeValues.map[json["type"]]!,
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "delivery_id": deliveryId,
    "driver_id": driverId,
    "support_id": supportId,
    "type": typeValues.reverse[type],
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
  };
}

class IssueCategory {
  int? id;
  String? category;
  String? issue;
  Type? complexity;
  Language? language;
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
    complexity: typeValues.map[json["complexity"]]!,
    language: languageValues.map[json["language"]]!,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "issue": issue,
    "complexity": typeValues.reverse[complexity],
    "language": languageValues.reverse[language],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
  };
}

enum Type {
  BASIC,
  CRITICAL,
  MODERATE,
  NEW
}

final typeValues = EnumValues({
  "basic": Type.BASIC,
  "critical": Type.CRITICAL,
  "moderate": Type.MODERATE,
  "new": Type.NEW
});

enum Language {
  EN,
  HI
}

final languageValues = EnumValues({
  "en": Language.EN,
  "hi": Language.HI
});

class UserDetail {
  int? id;
  int? userId;
  String? address;
  String? drivingLicenseNumber;
  String? drivingLicenseDoc;
  String? vehicleType;
  String? vehicleNumber;
  String? vehiclePhoto;
  String? aadharDoc;
  String? emergencyContact;
  String? profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;
  String? profilePhotoUrl;
  String? drivingLicenseDocUrl;
  String? vehiclePhotoUrl;
  dynamic aadharDocUrl;

  UserDetail({
    this.id,
    this.userId,
    this.address,
    this.drivingLicenseNumber,
    this.drivingLicenseDoc,
    this.vehicleType,
    this.vehicleNumber,
    this.vehiclePhoto,
    this.aadharDoc,
    this.emergencyContact,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
    this.profilePhotoUrl,
    this.drivingLicenseDocUrl,
    this.vehiclePhotoUrl,
    this.aadharDocUrl,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    drivingLicenseNumber: json["driving_license_number"],
    drivingLicenseDoc: json["driving_license_doc"],
    vehicleType: json["vehicle_type"],
    vehicleNumber: json["vehicle_number"],
    vehiclePhoto: json["vehicle_photo"],
    aadharDoc: json["aadhar_doc"],
    emergencyContact: json["emergency_contact"],
    profilePicture: json["profile_picture"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    uuid: json["uuid"],
    profilePhotoUrl: json["profile_photo_url"],
    drivingLicenseDocUrl: json["driving_license_doc_url"],
    vehiclePhotoUrl: json["vehicle_photo_url"],
    aadharDocUrl: json["aadhar_doc_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "driving_license_number": drivingLicenseNumber,
    "driving_license_doc": drivingLicenseDoc,
    "vehicle_type": vehicleType,
    "vehicle_number": vehicleNumber,
    "vehicle_photo": vehiclePhoto,
    "aadhar_doc": aadharDoc,
    "emergency_contact": emergencyContact,
    "profile_picture": profilePicture,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "uuid": uuid,
    "profile_photo_url": profilePhotoUrl,
    "driving_license_doc_url": drivingLicenseDocUrl,
    "vehicle_photo_url": vehiclePhotoUrl,
    "aadhar_doc_url": aadharDocUrl,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
