import 'dart:convert';

import 'package:hrms_app/model/dashboard/leave_quota/leave_quota_response_model.dart';
import 'package:hrms_app/model/dashboard/today_checkin/today_check_in_model.dart';
import 'package:hrms_app/model/forgot/forgot_password_response_model.dart';
import 'package:hrms_app/model/my_attendance/my_attendance_model.dart';
import 'package:hrms_app/model/my_holidays/my_holidays_response_model.dart';
import 'package:hrms_app/model/my_leaves/my_leaves_model.dart';
import 'package:hrms_app/model/sigin/login_response_model.dart';
import 'package:http/http.dart' as http;

import '../model/forgot/forgot_password_response_model.dart';
import '../model/sigin/login_response_model.dart';

class RestApi {
  var baseUrl = "http://cnb.inovedia.com/api/";

  var loginUrl = "Account/Login";
  var forgotPasswordUrl = "Account/ForgotPassword";

  //Dashboard
  var todayCheckInUrl = "Attendence/TodayCheckinLogs";
  var leaveQuotaUrl="Leave/LeaveQuota";

  //My Attendance
  var attendanceHistoryUrl="Attendence/MyAttendence";

  //My Holidays
  var myHolidayUrl = "Account/MyHolidays";

  Future<LoginResponseModel?> loginApiCall(String user, String password) async {
    final String apiUrl = baseUrl + loginUrl;
    var url=Uri.parse(apiUrl);
    // Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};

    print("API Function below url" );


    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"Username": user, "Password": password});

    print("body :${body.toString()}" );
    print("Below body");
    // final response = await http.post(apiUrl,
    //     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    //     body: {"Username": Username, "Password": Password});


    // var client = http.Client();
    // try {
    //   var response = await client.post(Uri.parse(apiUrl),
    //       headers: headers,
    //       body: body);
    //
    //   print("response :" + response.body.toString());
    //
    // } finally {
    //   client.close();
    //   print("finally");
    // }


    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
    print("response :" + response.body.toString());
    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("returning :" + responseString);
      return loginResponseModelFromJson(responseString);
    } else {
      print("returning null");
      return null;
    }
  }

  Future<ForgotPasswordResponseModel?> forgotPasswordApiCall(
      String email) async {
    final String apiUrl = baseUrl + forgotPasswordUrl;

    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"Email": email});

    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("returning :" + responseString);
      return forgotPasswordModelFromJson(responseString);
    } else {
      print("returning null");
      return null;
    }
  }

  // var baseurl = "http://androidtutorial.blueappsoftware.com//";
  // var apifolder = "webapi/";
  //
  // Future<get_prod> getProdCall() async {
  //   var url = baseurl+ apifolder+"get_jsondata.php";
  //   final body ={ 'language': 'default', 'securecode': '123'};
  //   final bodyjson = json.encode(body);
  //   // pass headers parameters if any
  //   final response  = await http.post( url,
  //       headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8' },
  //       body: bodyjson );
  //   print(" url call from "+ url);
  //   if (response.statusCode == 200) {
  //     print('url hit successful'+response.body);
  //     String  data = response.body;
  //     print(' prod name - '+ jsonDecode(data)['Information'][0]['name']);
  //     return get_prod.fromJson( json.decode(response.body) );
  //   } else {
  //     print('failed to get data');
  //     throw Exception('Failed to get data');
  //   }
  // }

  Future<MyHolidaysResponseModel> getMyHolidaysApiCall(String apiKey) async {
    print("API Key :" + apiKey);
    var url = baseUrl + myHolidayUrl;

    //Map<String,String> headers = {'Content-Type':'application/json','APIKey':'36d7cb4a-1438-4777-9b07-5dbbdc97baaf'};
    // final response=await http.get(url,
    // headers:{ 'Content-type': 'application/json','APIKey':'36d7cb4a-1438-4777-9b07-5dbbdc97baaf'});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'APIKey': apiKey
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    print(" url call from " + url);
    print(" code " + response.statusCode.toString());
    print(" body" + response.body.toString());

    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;
      // print(' prod name - '+ jsonDecode(data)['Information'][0]['name']);
      return MyHolidaysResponseModel.fromJson(json.decode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  Future<TodayCheckInModel> getTodayCheckInApiCall(String apiKey) async {
    print("API Key :" + apiKey);
    var url = baseUrl + todayCheckInUrl;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'APIKey': apiKey
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    print(" url call from " + url);
    print(" code " + response.statusCode.toString());
    print(" body" + response.body.toString());

    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;

      return TodayCheckInModel.fromJson(json.decode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }

  Future<LeaveQuotaResponseModel> getLeaveQuotaApiCall(String apiKey) async {
    print("API Key :" + apiKey);
    var url = baseUrl + leaveQuotaUrl;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'APIKey': apiKey
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    print(" url call from " + url);
    print(" code " + response.statusCode.toString());
    print(" body" + response.body.toString());

    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;

      return LeaveQuotaResponseModel.fromJson(json.decode(response.body));
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }


  //My Attendance
  Future<MyAttendanceResponseModel?> myAttendanceApiCall(String startDate, String endDate,String apiKey) async {
    final String apiUrl = baseUrl + attendanceHistoryUrl;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'APIKey': apiKey
    };

    final body = jsonEncode({"StartDate": startDate, "EndDate": endDate});

    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("returning :" + responseString);
      return myAttendanceResponseModelFromJson(responseString);
    } else {
      print("returning null");
      return null;
    }
  }


  //My Leaves
  Future<MyLeavesResponseModel?> myLeavesApiCall(String apiKey) async {
    final String apiUrl = baseUrl + attendanceHistoryUrl;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'APIKey': apiKey
    };

    final response = await http.post(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("returning :" + responseString);
      return myLeavesResponseModelFromJson(responseString);
    } else {
      print("returning null");
      return null;
    }
  }

}
