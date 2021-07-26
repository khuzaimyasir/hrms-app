// To parse this JSON data, do
//
//     final myAttendanceResponseModel = myAttendanceResponseModelFromJson(jsonString);

import 'dart:convert';

MyAttendanceResponseModel myAttendanceResponseModelFromJson(String str) => MyAttendanceResponseModel.fromJson(json.decode(str));

String myAttendanceResponseModelToJson(MyAttendanceResponseModel data) => json.encode(data.toJson());

class MyAttendanceResponseModel {
  MyAttendanceResponseModel({
    this.status,
    this.message,
    this.attendence,
  });

  String ? status;
  String ? message;
  List<Attendence> ? attendence;

  factory MyAttendanceResponseModel.fromJson(Map<String, dynamic> json) => MyAttendanceResponseModel(
    status: json["Status"],
    message: json["Message"],
    attendence: List<Attendence>.from(json["Attendence"].map((x) => Attendence.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Attendence": List<dynamic>.from(attendence!.map((x) => x.toJson())),
  };
}

class Attendence {
  Attendence({
    this.userid,
    this.userName,
    this.dayIn,
    this.dayOut,
    this.dateIn,
    this.dateOut,
    this.hour,
    this.checkInTime,
    this.checkOutTime,
    this.shift,
    this.shiftTime,
  });

  String ? userid,userName,dayIn,dayOut;

  DateTime ? dateIn,dateOut;
  String ? hour,checkInTime,checkOutTime;
  bool ? shift;
  String ? shiftTime;

  factory Attendence.fromJson(Map<String, dynamic> json) => Attendence(
    userid: json["userid"],
    userName: json["userName"],
    dayIn: json["DayIn"],
    dayOut: json["DayOut"],
    dateIn: DateTime.parse(json["DateIn"]),
    dateOut: DateTime.parse(json["DateOut"]),
    hour: json["hour"],
    checkInTime: json["CheckInTime"],
    checkOutTime: json["CheckOutTime"],
    shift: json["Shift"],
    shiftTime: json["ShiftTime"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "userName": userName,
    "DayIn": dayIn,
    "DayOut": dayOut,
    "DateIn": dateIn!.toIso8601String(),
    "DateOut": dateOut!.toIso8601String(),
    "hour": hour,
    "CheckInTime": checkInTime,
    "CheckOutTime": checkOutTime,
    "Shift": shift,
    "ShiftTime": shiftTime,
  };
}

class MyAttendanceListModel{
  String ? dayname,day,monthname,year;
  String ? checkInTime,checkOutTime,hour;

  MyAttendanceListModel({ this.dayname, this.day, this.monthname,
    this.year, this.checkInTime, this.checkOutTime, this.hour});
}