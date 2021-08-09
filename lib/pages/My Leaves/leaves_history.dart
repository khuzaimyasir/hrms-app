import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hrms_app/Components/custom_icons.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/RestAPI/rest_api.dart';
import 'package:hrms_app/model/dashboard/leave_quota/leave_quota_response_model.dart';
import 'package:hrms_app/model/my_attendance/my_attendance_model.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
// import 'package:hrms_app/pages/My%20Attendance/My%20Attendance.dart';
import 'package:hrms_app/utils/strings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LeavesHistory extends StatefulWidget {
  String? apiKey;

  LeavesHistory({this.apiKey});

  @override
  _LeavesHistoryState createState() => _LeavesHistoryState();
}

class _LeavesHistoryState extends State<LeavesHistory> {
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
      String apiKey, String startDate, String endDate) async {
    try {
      EasyLoading.show();

      RestApi a = new RestApi();
      final MyAttendanceResponseModel responseModel =
          (await a.myAttendanceApiCall(startDate, endDate, apiKey))!;
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

  Widget customProgressBar() {
    EasyLoading.show();
    return Container();
  }

}




// ignore: must_be_immutable
class LeaveHistoryExpandableClass extends StatefulWidget {
  final String? title;

  //List<LeaveQoutaResponseDataModel> childModel;
  List<LeaveQuotaChildModel>? childModel;
  int? index;
  bool isLightTheme;

  // expandableClass({Key key, this.title, this.childModel, this.childModel2,this.index,this.isLightTheme})
  //     : super(key: key);

  LeaveHistoryExpandableClass(
      {Key? key, this.title, this.childModel, this.index, required this.isLightTheme})
      : super(key: key);

  @override
  _ExpandableClassState createState() => _ExpandableClassState();
}

class _ExpandableClassState extends State<LeaveHistoryExpandableClass> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 1.0),
      child: new Column(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: widget.isLightTheme ? lightModeColor : darkModeColor,
            ),
            padding:
            new EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomText(
                  text: widget.title,
                  color: white,
                ),
                IconButton(
                    icon: new Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                        color: widget.isLightTheme
                            ? lightModeColor
                            : darkModeColor,
                        shape: BoxShape.circle,
                      ),
                      child: new Center(
                        child: new Icon(
                          // returnFlagForIcon(forFirstTimeFlag, expandFlag,
                          //     widget.index, widget.childModel.length)
                          //     ? Icons.keyboard_arrow_up
                          //     : Icons.keyboard_arrow_down,
                          expandFlag
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      print('You have got $expandFlag as result');
                      // setState(() {
                      // //   if (forFirstTimeFlag == true) {
                      // //     forFirstTimeFlag = false;
                      // //
                      // //     //expandFlag = !expandFlag;
                      // //   } else {
                      // //     expandFlag = !expandFlag;
                      // //   }
                      // // }
                      //
                      // );
                    }),
              ],
            ),
          ),
          new ExpandableContainer(
              // expanded: returnFlag(forFirstTimeFlag, widget.index,
              //     widget.childModel.length, expandFlag),
               expanded: expandFlag,
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    margin: new EdgeInsets.symmetric(vertical: 2.0),
                    height: size.height * 0.32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                      widget.isLightTheme ? lightModeColor : darkModeColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // circularProgressBar(
                            //     widget.isLightTheme,
                            //     widget.childModel[index].PercentageValue,
                            //     widget.childModel[index].TotalLeaves
                            //         .toString()),
                            // CustomFixedHeightSizedBox(size),
                            // CustomText(
                            //   // text: "Total Annual Leaves",
                            //   text: widget.childModel[index].TotalLeavesName,
                            //   size: HeadingtFontSize(size),
                            //   color: white,
                            // ),
                            // CustomFixedHeightSizedBox(size),
                            // CustomFixedHeightSizedBox(size),
                            // leaveRowItem(
                            //     size,
                            //     widget.isLightTheme,
                            //     widget.childModel[index].AvailedLeavesName,
                            //     widget.childModel[index].AvailedLeaves
                            //         .toString()),
                            // leaveRowItem(
                            //     size,
                            //     widget.isLightTheme,
                            //     widget.childModel[index].RemainingLeavesName,
                            //     widget.childModel[index].RemainingLeaves
                            //         .toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.childModel!.length,
              ),
              expandedHeight: size.height * (0.32)),
        ],
      ),
    );
  }
}


class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 0.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print("Flag :" + expanded.toString());
    return new AnimatedContainer(
      duration: new Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: child,
    );
  }
}