import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hrms_app/Components/custom_icons.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/RestAPI/rest_api.dart';
import 'package:hrms_app/model/my_attendance/my_attendance_model.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
// import 'package:hrms_app/pages/My%20Attendance/My%20Attendance.dart';
import 'package:hrms_app/utils/strings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AttendanceHistory2 extends StatefulWidget {
  String? apiKey;

  AttendanceHistory2({this.apiKey});

  @override
  _AttendanceHistoryState createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory2> {
  var pickedDate;
  var pickedTime;

  var fromDate = 'From Date', toDate = "To Date";
  late Size size;
  late bool isLightTheme;

  List<MyAttendanceListModel> attendanceNewList = [];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    isLightTheme = themeProvider.isLightTheme;
    size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: white,
        // body: _buildBody(context, widget.APIKey),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              customFixedHeightSizedBox(size),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton.extended(
                      heroTag: null,
                      foregroundColor: black,
                      backgroundColor: isLightTheme ? green : orange,
                      onPressed: () {
                        // DatePicker.showDatePicker(context,
                        //     showTitleActions: true,
                        //     minTime: DateTime(1900, 1, 1),
                        //     maxTime: DateTime(2026, 12, 31), onChanged: (date) {
                        //   print('change $date');
                        //   setState(() {
                        //     pickedDate = "${date.day}";
                        //     fromDate = "${date.day}";
                        //   });
                        // }, onConfirm: (date) {
                        //   print('confirm $date');
                        //   setState(() {
                        //     pickedDate =
                        //         "Picked Date is : ${date.day}/${date.month}/${date.year}";
                        //
                        //     fromDate = "${date.day}/${date.month}/${date.year}";
                        //   });
                        // }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      // label: Text("From Date"),
                      label: Text(fromDate),
                      icon: Icon(Icons.date_range),
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      foregroundColor: black,
                      backgroundColor: isLightTheme ? green : orange,
                      onPressed: () {
                        // DatePicker.showDatePicker(context,
                        //     showTitleActions: true,
                        //     minTime: DateTime(2018, 3, 5),
                        //     maxTime: DateTime(2026, 6, 7), onChanged: (date) {
                        //   print('change $date');
                        //   setState(() {
                        //     pickedDate = "${date.day}";
                        //     toDate = "${date.day}";
                        //   });
                        // }, onConfirm: (date) {
                        //   print('confirm $date');
                        //   setState(() {
                        //     pickedDate =
                        //         "Picked Date is : ${date.day}/${date.month}/${date.year}";
                        //
                        //     toDate = "${date.day}/${date.month}/${date.year}";
                        //   });
                        // }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      // label: Text("To Date"),
                      label: Text(toDate),
                      icon: Icon(Icons.date_range),
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      // foregroundColor: Colors.orange,
                      backgroundColor: isLightTheme ? green : orange,
                      onPressed: () {
                        print("Filter button pressed");

                        // EasyLoading.show();
                        // _buildBody(context, widget.APIKey, fromDate, toDate);

                        attendanceHistoryApiCall(
                            widget.apiKey!, fromDate, toDate);
                      },
                      // label: Text("To Date"),
                      label: Text("Filter"),
                    ),
                  ],
                ),
              ),
              customFixedHeightSizedBox(size),
              customFixedHeightSizedBox(size),

              attendanceNewList.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: CustomText(text: "No Record Found"))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 2, left: 10.0, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: size.height * 0.13,
                                  // width: size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                        topRight: Radius.circular(4),
                                      ),
                                    color: isLightTheme? lightModeColor: darkModeColor,),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: attendanceNewList[index].dayname,
                                        color: white,
                                      ),
                                      customFixedHeightSizedBox(size),
                                      CustomText(
                                        text: attendanceNewList[index].day,
                                        color: isLightTheme ? l_mode_text_focus_color:d_mode_text_focus_color,
                                        size: 18,
                                        weight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        text:
                                            attendanceNewList[index].monthname,
                                        color: white,
                                        size: 14,
                                      ),
                                      CustomText(
                                        text: attendanceNewList[index].year,
                                        color: white,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: size.height * 0.13,
                                  // width: size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topLeft: Radius.circular(4),
                                      ),
                                    color: isLightTheme? lightModeColor: darkModeColor,),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: CustomText(
                                        //       text: "on Time",
                                        //       color: green,
                                        //     )),

                                        //CustomFixedHeightSizedBox(size),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: "Checked In:",
                                                color: isLightTheme ? l_mode_text_un_focus_color:d_mode_text_un_focus_color,
                                                size: 16,
                                              ),
                                              CustomText(
                                                text: attendanceNewList[index]
                                                    .checkInTime,
                                                color: isLightTheme ? l_mode_text_focus_color:d_mode_text_focus_color,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //CustomFixedHeightSizedBox(size),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: "Checked Out:",
                                                color: isLightTheme ? l_mode_text_un_focus_color:d_mode_text_un_focus_color,
                                                size: 16,
                                              ),
                                              CustomText(
                                                text: attendanceNewList[index]
                                                    .checkOutTime,
                                                color: isLightTheme ? l_mode_text_focus_color:d_mode_text_focus_color,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //CustomFixedHeightSizedBox(size),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: "Total Hours:",
                                                color: isLightTheme ? l_mode_text_un_focus_color:d_mode_text_un_focus_color,
                                                size: 16,
                                              ),
                                              CustomText(
                                                text: attendanceNewList[index]
                                                    .hour,
                                                color: isLightTheme ? l_mode_text_focus_color:d_mode_text_focus_color,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: attendanceNewList.length,
                    ),

            ],
          ),
        ));
  }



  void attendanceHistoryApiCall(
      String apikey, String startdate, String enddate) async {
    try {
      EasyLoading.show();

      RestApi a = new RestApi();
      final MyAttendanceResponseModel responseModel =
          (await a.myAttendanceApiCall(startdate, enddate, apikey))!;
      print(responseModel);

      EasyLoading.dismiss();

      if (responseModel.status == "success") {
        final List<Attendence> attendanceList = responseModel.attendence!;

        List<MyAttendanceListModel> attendanceListUpdated = [];

        for (int i = 0; i < attendanceList.length; i++) {
          String dayName = DateFormat('EEEE').format(attendanceList[i].dateIn!);
          String day = DateFormat('dd').format(attendanceList[i].dateIn!);
          String monthName =
              DateFormat('MMMM').format(attendanceList[i].dateIn!);
          String year = DateFormat('yyyy').format(attendanceList[i].dateIn!);

          String checkIn = DateFormat.jm().format(
              DateFormat("hh:mm:ss").parse(attendanceList[i].checkInTime!));
          String checkOut = DateFormat.jm().format(
              DateFormat("hh:mm:ss").parse(attendanceList[i].checkOutTime!));
          // String total_hours=DateFormat.jm().format(DateFormat("hh:mm").parse(attendanceList[i].hour));
          String totalHours = attendanceList[i].hour!;

          attendanceListUpdated.add(new MyAttendanceListModel(
              dayname: dayName,
              day: day,
              monthname: monthName,
              year: year,
              checkInTime: checkIn,
              checkOutTime: checkOut,
              hour: totalHours));
        }

        setState(() {
          attendanceNewList = attendanceListUpdated;
        });
      } else if (responseModel.status == "error") {
        EasyLoading.showError(errorMessage, duration: Duration(seconds: 4));
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e);
    }
  }

  // Widget CustomProgressBar() {
  //   EasyLoading.show();
  //   //return Container();
  // }

}
