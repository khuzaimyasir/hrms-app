// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.message,
    this.apiKey,
    this.fullName,
    this.profilePictureUrl,
    this.designation,
  });

  String? status,message,apiKey,fullName,profilePictureUrl,designation;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["Status"],
    message: json["Message"],
    apiKey: json["APIKey"],
    fullName: json["FullName"],
    profilePictureUrl: json["ProfilePictureUrl"],
    designation: json["Designation"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "APIKey": apiKey,
    "FullName": fullName,
    "ProfilePictureUrl": profilePictureUrl,
    "Designation": designation,
  };
}
