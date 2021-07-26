// To parse this JSON data, do
//
//     final leaveQuotaResponseModel = leaveQuotaResponseModelFromJson(jsonString);

import 'dart:convert';

LeaveQuotaResponseModel leaveQuotaResponseModelFromJson(String str) => LeaveQuotaResponseModel.fromJson(json.decode(str));

String leaveQuotaResponseModelToJson(LeaveQuotaResponseModel data) => json.encode(data.toJson());

class LeaveQuotaResponseModel {
  LeaveQuotaResponseModel({
    this.status,
    this.message,
    this.leaveQuota,
  });

  String ? status;
  String ? message;
  LeaveQuota ? leaveQuota;

  factory LeaveQuotaResponseModel.fromJson(Map<String, dynamic> json) => LeaveQuotaResponseModel(
    status: json["Status"],
    message: json["Message"],
    leaveQuota: LeaveQuota.fromJson(json["LeaveQuota"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "LeaveQuota": leaveQuota!.toJson(),
  };
}

class LeaveQuota {
  LeaveQuota({
    this.annualLeaves,
    this.sickLeaves,
    this.casualLeaves,
    this.remainingAnnualLeaves,
    this.remainingCasualLeaves,
    this.remainingSickLeaves,
  });

  int ? annualLeaves;
  int ? sickLeaves;
  int ? casualLeaves;
  int ? remainingAnnualLeaves;
  int ? remainingCasualLeaves;
  int ? remainingSickLeaves;

  factory LeaveQuota.fromJson(Map<String, dynamic> json) => LeaveQuota(
    annualLeaves: json["AnnualLeaves"],
    sickLeaves: json["SickLeaves"],
    casualLeaves: json["CasualLeaves"],
    remainingAnnualLeaves: json["RemainingAnnualLeaves"],
    remainingCasualLeaves: json["RemainingCasualLeaves"],
    remainingSickLeaves: json["RemainingSickLeaves"],
  );

  Map<String, dynamic> toJson() => {
    "AnnualLeaves": annualLeaves,
    "SickLeaves": sickLeaves,
    "CasualLeaves": casualLeaves,
    "RemainingAnnualLeaves": remainingAnnualLeaves,
    "RemainingCasualLeaves": remainingCasualLeaves,
    "RemainingSickLeaves": remainingSickLeaves,
  };
}









class LeaveQuotaModel{
  String ? title;
  List<LeaveQuotaChildModel> ? childList;

  LeaveQuotaModel({this.title, this.childList});
}

class LeaveQuotaChildModel{

  String ? remainingLeavesName,totalLeavesName,availedLeavesName;
  int ? remainingLeaves,totalLeaves,availedLeaves;
  double ? percentageValue;

  LeaveQuotaChildModel({this.remainingLeavesName,this.totalLeavesName,this.availedLeavesName,this.remainingLeaves, this.totalLeaves,
    this.availedLeaves, this.percentageValue});
}
