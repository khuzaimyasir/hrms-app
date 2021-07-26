// To parse this JSON data, do
//
//     final todayCheckInModel = todayCheckInModelFromJson(jsonString);

import 'dart:convert';

TodayCheckInModel todayCheckInModelFromJson(String str) => TodayCheckInModel.fromJson(json.decode(str));

String todayCheckInModelToJson(TodayCheckInModel data) => json.encode(data.toJson());

class TodayCheckInModel {
  TodayCheckInModel({
    this.status,
    this.message,
    this.date,
    this.checkin,
    this.checkout,
  });

  String ? status;
  String ? message;
  dynamic date;
  dynamic checkin;
  dynamic checkout;

  factory TodayCheckInModel.fromJson(Map<String, dynamic> json) => TodayCheckInModel(
    status: json["Status"],
    message: json["Message"],
    date: json["Date"],
    checkin: json["Checkin"],
    checkout: json["Checkout"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Date": date,
    "Checkin": checkin,
    "Checkout": checkout,
  };
}
