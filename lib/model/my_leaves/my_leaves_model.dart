// To parse this JSON data, do
//
//     final myLeavesResponseModel = myLeavesResponseModelFromJson(jsonString);

import 'dart:convert';

MyLeavesResponseModel myLeavesResponseModelFromJson(String str) =>
    MyLeavesResponseModel.fromJson(json.decode(str));

String myLeavesResponseModelToJson(MyLeavesResponseModel data) =>
    json.encode(data.toJson());

class MyLeavesResponseModel {
  MyLeavesResponseModel({
    this.status,
    this.message,
    this.myLeavesChildModel,
  });

  String? status;
  String? message;
  List<MyLeavesChildModel>? myLeavesChildModel;

  factory MyLeavesResponseModel.fromJson(Map<String, dynamic> json) =>
      MyLeavesResponseModel(
        status: json["Status"],
        message: json["Message"],
        myLeavesChildModel: List<MyLeavesChildModel>.from(
            json["MyLeaves"].map((x) => MyLeavesChildModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "MyLeaves":
            List<dynamic>.from(myLeavesChildModel!.map((x) => x.toJson())),
      };
}

class MyLeavesChildModel {
  MyLeavesChildModel({
    this.leaveApplicationId,
    this.leaveApplicationType,
    this.totalLeaves,
    this.remainingLeaves,
    this.leaveApplicationTypeId,
    this.leaveApplicationCategoryId,
    this.leaveApplicationCategory,
    this.appliedDateTime,
    this.fromDate,
    this.toDate,
    this.purpose,
    this.backupUserProfileId,
    this.backupUserProfilePicture,
    this.applicantProfilePicture,
    this.backupUserDesignation,
    this.backupUserName,
    this.leaveApplicationStatus,
    this.leaveApplicationBackupStatus,
    this.applicantUserProfileId,
    this.applicantName,
    this.designation,
    this.department,
    this.city,
    this.country,
    this.address,
    this.phone,
    this.approvedByBackupUser,
    this.backupUserComments,
    this.emergencyContactName,
    this.emergencyPhoneNumber,
  });

  int? leaveApplicationId;
  String? leaveApplicationType;
  int? totalLeaves,remainingLeaves,leaveApplicationTypeId,leaveApplicationCategoryId;
  dynamic leaveApplicationCategory;
  DateTime? appliedDateTime, fromDate,toDate;
  String? purpose;
  int? backupUserProfileId;
  dynamic backupUserProfilePicture,applicantProfilePicture,backupUserDesignation;
  String? backupUserName,leaveApplicationStatus;
  dynamic leaveApplicationBackupStatus;
  int? applicantUserProfileId;
  String? applicantName;
  dynamic designation, department;
  String? city,country,address,phone;
  dynamic approvedByBackupUser, backupUserComments;
  String? emergencyContactName,emergencyPhoneNumber;

  factory MyLeavesChildModel.fromJson(Map<String, dynamic> json) =>
      MyLeavesChildModel(
        leaveApplicationId: json["LeaveApplicationId"],
        leaveApplicationType: json["LeaveApplicationType"],
        totalLeaves: json["TotalLeaves"],
        remainingLeaves: json["RemainingLeaves"],
        leaveApplicationTypeId: json["LeaveApplicationTypeId"],
        leaveApplicationCategoryId: json["LeaveApplicationCategoryId"],
        leaveApplicationCategory: json["LeaveApplicationCategory"],
        appliedDateTime: DateTime.parse(json["AppliedDateTime"]),
        fromDate: DateTime.parse(json["FromDate"]),
        toDate: DateTime.parse(json["ToDate"]),
        purpose: json["Purpose"],
        backupUserProfileId: json["BackupUserProfileId"],
        backupUserProfilePicture: json["BackupUserProfilePicture"],
        applicantProfilePicture: json["ApplicantProfilePicture"],
        backupUserDesignation: json["BackupUserDesignation"],
        backupUserName: json["BackupUserName"],
        leaveApplicationStatus: json["LeaveApplicationStatus"],
        leaveApplicationBackupStatus: json["LeaveApplicationBackupStatus"],
        applicantUserProfileId: json["ApplicantUserProfileId"],
        applicantName: json["ApplicantName"],
        designation: json["Designation"],
        department: json["Department"],
        city: json["City"],
        country: json["Country"],
        address: json["Address"],
        phone: json["Phone"],
        approvedByBackupUser: json["ApprovedByBackupUser"],
        backupUserComments: json["BackupUserComments"],
        emergencyContactName: json["EmergencyContactName"],
        emergencyPhoneNumber: json["EmergencyPhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "LeaveApplicationId": leaveApplicationId,
        "LeaveApplicationType": leaveApplicationType,
        "TotalLeaves": totalLeaves,
        "RemainingLeaves": remainingLeaves,
        "LeaveApplicationTypeId": leaveApplicationTypeId,
        "LeaveApplicationCategoryId": leaveApplicationCategoryId,
        "LeaveApplicationCategory": leaveApplicationCategory,
        "AppliedDateTime": appliedDateTime!.toIso8601String(),
        "FromDate": fromDate!.toIso8601String(),
        "ToDate": toDate!.toIso8601String(),
        "Purpose": purpose,
        "BackupUserProfileId": backupUserProfileId,
        "BackupUserProfilePicture": backupUserProfilePicture,
        "ApplicantProfilePicture": applicantProfilePicture,
        "BackupUserDesignation": backupUserDesignation,
        "BackupUserName": backupUserName,
        "LeaveApplicationStatus": leaveApplicationStatus,
        "LeaveApplicationBackupStatus": leaveApplicationBackupStatus,
        "ApplicantUserProfileId": applicantUserProfileId,
        "ApplicantName": applicantName,
        "Designation": designation,
        "Department": department,
        "City": city,
        "Country": country,
        "Address": address,
        "Phone": phone,
        "ApprovedByBackupUser": approvedByBackupUser,
        "BackupUserComments": backupUserComments,
        "EmergencyContactName": emergencyContactName,
        "EmergencyPhoneNumber": emergencyPhoneNumber,
      };
}
