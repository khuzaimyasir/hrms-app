// To parse this JSON data, do
//
//     final myHolidaysResponseModel = myHolidaysResponseModelFromJson(jsonString);

import 'dart:convert';

MyHolidaysResponseModel myHolidaysResponseModelFromJson(String str) => MyHolidaysResponseModel.fromJson(json.decode(str));

String myHolidaysResponseModelToJson(MyHolidaysResponseModel data) => json.encode(data.toJson());

class MyHolidaysResponseModel {
  MyHolidaysResponseModel({
    this.status,
    this.message,
    this.myHolidays,
  });

  String ? status;
  String ? message;
  List<MyHolidayModel> ? myHolidays;

  factory MyHolidaysResponseModel.fromJson(Map<String, dynamic> json) => MyHolidaysResponseModel(
    status: json["Status"],
    message: json["Message"],
    myHolidays: List<MyHolidayModel>.from(json["MyHolidays"].map((x) => MyHolidayModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "MyHolidays": List<dynamic>.from(myHolidays!.map((x) => x.toJson())),
  };
}

class MyHolidayModel {
  MyHolidayModel({
    this.title,
    this.date,
  });

  String? title;
  String?  date;

  factory MyHolidayModel.fromJson(Map<String, dynamic> json) => MyHolidayModel(
    title: json["Title"],
    date: json["Date"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Date": date,
  };
}

class MyHolidayListModel{
  String? title,dayname,day,monthname,year;

  MyHolidayListModel({this.title,this.dayname, this.day, this.monthname, this.year});
}
