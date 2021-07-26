import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/RestAPI/rest_api.dart';
import 'package:hrms_app/model/dashboard/leave_quota/leave_quota_response_model.dart';

import 'package:hrms_app/model/dashboard/today_checkin/today_check_in_model.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:hrms_app/pages/ChangeTheme/change_theme.dart';
import 'package:hrms_app/pages/Login/login.dart';
import 'package:hrms_app/pages/My%20Attendance/My%20Attendance.dart';
import 'package:hrms_app/pages/My%20Holidays/my_holidays.dart';
import 'package:hrms_app/pages/My%20Leaves/my_leaves.dart';
import 'package:hrms_app/utils/strings.dart';
import 'package:provider/provider.dart';

bool forFirstTimeFlag = true;

class MenuDashboardPage2 extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage2>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;

  late String apiKey;
  late String checkIn, checkOut;

  late List<LeaveQuotaModel> leaveList;
  late List<LeaveQuotaChildModel> leaveChildList;

  //LeaveQuota leaveQuota;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);

    apiKey = "";
    checkIn = "";
    checkOut = "";

    leaveList = [];
    leaveChildList = [];

    getSecureData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: themeProvider.isLightTheme
          ? lightMenuBackgroundColor
          : darkMenuBackgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context, themeProvider.isLightTheme),
          dashboard(context, themeProvider.isLightTheme),
        ],
      ),
    );
  }

  Widget menu(context, bool isLightTheme) {
    Size size = MediaQuery.of(context).size;

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //for top margin
                  SizedBox(height: size.height * 0.1),

                  //profile image
                  Container(
                    width: 180.0,
                    height: 180.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/profile.jpg",
                        ),
                        // image: new NetworkImage(
                        //     "https://images.pexels.com/photos/4307643/pexels-photo-4307643.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Faizan Shoukat",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: isLightTheme ? white : orange,
                          // fontSize: size.width*0.035,
                          fontSize: sideMenuNameFontSize(size),
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text(
                      "Android Developer",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.grey[350],
                          // fontSize: size.width*0.035,
                          fontSize: sideMenuDesignationFontSize(size),
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  menuHeightSizedBox(size),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isCollapsed)
                          _controller.forward();
                        else
                          _controller.reverse();

                        isCollapsed = !isCollapsed;
                      });
                    },
                    child: menuItem(size, Icons.dashboard, 'Dashboard',
                        textFontSize(size), white, white),
                  ),

                  menuHeightSizedBox(size),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAttendance(
                                  checkIn: checkIn,
                                  checkOut: checkOut,
                                  apiKey: apiKey,
                                )),
                      );
                    },
                    child: menuItem(size, Icons.adjust, 'My Attendance',
                        textFontSize(size), white, white),
                  ),

                  menuHeightSizedBox(size),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyLeaves(
                                  apiKey: apiKey,
                                  leaveQuotaChildList: leaveChildList,
                                )),
                      );
                    },
                    child: menuItem(size, Icons.calendar_today_sharp,
                        'My Leaves', textFontSize(size), white, white),
                  ),

                  menuHeightSizedBox(size),
                  menuItem(size, Icons.adjust, 'My Tasks', textFontSize(size),
                      white, white),

                  menuHeightSizedBox(size),
                  menuItem(size, Icons.dashboard, 'Raise A Request',
                      textFontSize(size), white, white),

                  menuHeightSizedBox(size),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHolidays3(
                                  apiKey: apiKey,
                                )),
                      );
                    },
                    child: menuItem(size, Icons.add_circle, 'My Holidays',
                        textFontSize(size), white, white),
                  ),

                  menuHeightSizedBox(size),
                  menuItem(size, Icons.person_add, 'Refer A Person',
                      textFontSize(size), white, white),

                  menuHeightSizedBox(size),
                  menuItem(size, Icons.person, 'My Profile', textFontSize(size),
                      white, white),

                  menuHeightSizedBox(size),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangeTheme()),
                      );
                    },
                    child: menuItem(size, Icons.settings, 'Setting',
                        textFontSize(size), white, white),
                  ),

                  menuHeightSizedBox(size),
                  GestureDetector(
                    onTap: () {
                      // EasyLoading.show();
                      // deleteUserDetail();
                      //
                      //
                      // Navigator.pop(context);
                      //
                      // EasyLoading.dismiss();
                      //
                      // // Navigator.push(
                      // //   context,
                      // //   MaterialPageRoute(builder: (context) => ChangeTheme()),
                      // // );

                      deleteUserDetail();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Login(),
                        ),
                        (route) => false,
                      );
                    },
                    child: menuItem(size, Icons.logout, 'Log out',
                        textFontSize(size), white, white),
                  ),

                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deleteUserDetail() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    // Delete value
    await storage.delete(key: "Email");
    await storage.delete(key: "Password");
  }

  Widget dashboard(context, bool isLightTheme) {
    Size size = MediaQuery.of(context).size;

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          // borderRadius: BorderRadius.all(Radius.circular(40)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          elevation: 8,
          color:
              isLightTheme ? lightMenuBackgroundColor : darkMenuBackgroundColor,

          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: size.height * 0.07,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                child: Icon(Icons.menu, color: white),
                                onTap: () {
                                  setState(() {
                                    if (isCollapsed)
                                      _controller.forward();
                                    else
                                      _controller.reverse();

                                    isCollapsed = !isCollapsed;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("HRMS Inovedia",
                                  style: TextStyle(
                                      fontSize: toolbarFontSize(size),
                                      color: white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //this is for curved container
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: isLightTheme
                          ? l_dashboard_curved_container
                          : d_dashboard_curved_container,
                    ),

                    width: size.width,
                    // margin: EdgeInsets.fromLTRB(left: 5,top: 130,right: 5,bottom: 0),
                    margin: EdgeInsets.fromLTRB(7, 20, 7, 0),

                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customFixedHeightSizedBox(size),
                          CustomText(
                            text: "Today",
                            size: headingtFontSize(size),
                            weight: FontWeight.bold,
                          ),
                          customFixedHeightSizedBox(size),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //today check in
                                Flexible(
                                    child: checkInOutDesign(
                                        size,
                                        isLightTheme,
                                        "Check In",
                                      
                                        // ignore: unnecessary_null_comparison
                                        checkIn == null || checkIn == ""
                                            ? "N/A"
                                            : checkIn)),
                                Flexible(
                                    child: checkInOutDesign(
                                        size,
                                        isLightTheme,
                                        "Check out",
                                        // ignore: unnecessary_null_comparison
                                        checkOut == null || checkOut == ""
                                            ? "N/A"
                                            : checkOut)),
                              ],
                            ),
                          ),
                          customFixedHeightSizedBox(size),
                          customFixedHeightSizedBox(size),
                          customFixedHeightSizedBox(size),
                          CustomText(
                            text: "Leaves",
                            size: headingtFontSize(size),
                            weight: FontWeight.bold,
                          ),
                          customFixedHeightSizedBox(size),

                          //for leaves detail
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: new ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return new ExpandableClass(
                                  // title: "Title" + leaveQuotaList[index].Message,
                                  // ignore: unnecessary_null_comparison
                                  title: index == null
                                      ? ""
                                      : leaveList[index].title,
                                  // childModel: leaveQuotaList[index].childModel,
                                  // ignore: unnecessary_null_comparison
                                  childModel: index == null
                                      ? []
                                      : leaveList[index].childList,
                                  index: index,
                                  isLightTheme: isLightTheme,
                                );
                              },
                              itemCount: leaveList.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuItem(Size size, IconData icon, String text, double fontSize,
      Color textColor, Color iconColor) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        // SizedBox(width : size.width * 0.03),
        menuWidthSizedBox(size),
        Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
      ],
    );
  }

  void getSecureData() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    // ignore: unnecessary_null_comparison
    if (storage == null) {
    } else {
      String apiKey = (await storage.read(key: apiKeyString))!;

      // ignore: unnecessary_null_comparison
      if (apiKey != null) {
        print("APIKey in DB :" + apiKey);

        setState(() {
          apiKey = apiKey;
        });

        todayCheckInApiCall();
      }
    }
  }

  void todayCheckInApiCall() async {
    try {
      EasyLoading.show();

      RestApi a = new RestApi();
      final TodayCheckInModel checkInModel =
          await a.getTodayCheckInApiCall(apiKey);
      print(checkInModel);

      //EasyLoading.dismiss();

      if (checkInModel.status == "success") {
        setState(() {
          checkIn = checkInModel.checkin;
          checkOut = checkInModel.checkout;
        });

        leaveQuotaApiCall();
      } else if (checkInModel.status == "error") {
        leaveQuotaApiCall();

        EasyLoading.showError(errorMessage, duration: Duration(seconds: 4));
      }
    } catch (e) {
      leaveQuotaApiCall();

      EasyLoading.showError(e.toString());
      print(e);
    }
  }

  void leaveQuotaApiCall() async {
    try {
      EasyLoading.show();

      RestApi a = new RestApi();
      // final LeaveQuotaResponseModel leaveQuotaResponseModel = await a.getLeaveQuotaApiCall(APIKey);

      LeaveQuotaResponseModel leaveQuotaResponseModel =
          await a.getLeaveQuotaApiCall(apiKey);
      print(leaveQuotaResponseModel);

      EasyLoading.dismiss();

      if (leaveQuotaResponseModel.status == "success") {
        setState(() {
          leaveChildList = <LeaveQuotaChildModel>[
            getAnnualLeavesChildModelObject(leaveQuotaResponseModel),
            getSickLeavesChildModelObject(leaveQuotaResponseModel),
            getCasualLeavesChildModelObject(leaveQuotaResponseModel),
          ];

          leaveList = <LeaveQuotaModel>[
            getAnnualLeavesQuotaObject(leaveQuotaResponseModel),
            getSickLeavesQuotaObject(leaveQuotaResponseModel),
            getCasualLeavesQuotaObject(leaveQuotaResponseModel),
          ];
        });
      } else if (leaveQuotaResponseModel.status == "error") {
        EasyLoading.showError(errorMessage, duration: Duration(seconds: 6));
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e);
    }
  }

  LeaveQuotaModel getAnnualLeavesQuotaObject(
      LeaveQuotaResponseModel leaveQuotaResponseModel) {
    LeaveQuotaChildModel annualLeavesChildModel =
        getAnnualLeavesChildModelObject(leaveQuotaResponseModel);

    List<LeaveQuotaChildModel> annualLeavesChildModelList = [
      annualLeavesChildModel
    ];

    LeaveQuotaModel annualLeavesModel = LeaveQuotaModel();

    annualLeavesModel.title = "Annual Leaves";
    annualLeavesModel.childList = annualLeavesChildModelList;

    return annualLeavesModel;
  }

  LeaveQuotaChildModel getAnnualLeavesChildModelObject(
      LeaveQuotaResponseModel? leaveQuotaResponseModel) {
    LeaveQuotaChildModel annualLeavesChildModel = new LeaveQuotaChildModel();

    // int? a=leaveQuotaResponseModel!.leaveQuota!.annualLeaves;
    // int? b=leaveQuotaResponseModel!.leaveQuota!.remainingAnnualLeaves;
    // int? availedLeaves = a! -b!;

    int? availedLeaves = (leaveQuotaResponseModel!.leaveQuota!.annualLeaves!) -
        (leaveQuotaResponseModel.leaveQuota!.remainingAnnualLeaves!);

    double percentageValue =
        (leaveQuotaResponseModel.leaveQuota!.remainingAnnualLeaves!) /
            (leaveQuotaResponseModel.leaveQuota!.annualLeaves!);

    annualLeavesChildModel.totalLeaves =
        leaveQuotaResponseModel.leaveQuota!.annualLeaves!;
    annualLeavesChildModel.remainingLeaves =
        leaveQuotaResponseModel.leaveQuota!.remainingAnnualLeaves!;
    annualLeavesChildModel.availedLeaves = availedLeaves;
    annualLeavesChildModel.percentageValue = percentageValue;

    annualLeavesChildModel.totalLeavesName = "Total Annual Leaves ";
    annualLeavesChildModel.remainingLeavesName = "Remaining Leaves ";
    annualLeavesChildModel.availedLeavesName = "Availed Leaves ";

    return annualLeavesChildModel;
  }

  LeaveQuotaModel getSickLeavesQuotaObject(
      LeaveQuotaResponseModel leaveQuotaResponseModel) {
    LeaveQuotaChildModel annualLeavesChildModel =
        getSickLeavesChildModelObject(leaveQuotaResponseModel);

    List<LeaveQuotaChildModel> annualLeavesChildModelList = [
      annualLeavesChildModel
    ];

    LeaveQuotaModel annualLeavesModel = LeaveQuotaModel();
    annualLeavesModel.title = "Sick Leaves";
    annualLeavesModel.childList = annualLeavesChildModelList;

    return annualLeavesModel;
  }

  LeaveQuotaChildModel getSickLeavesChildModelObject(
      LeaveQuotaResponseModel leaveQuotaResponseModel) {
    LeaveQuotaChildModel annualLeavesChildModel = new LeaveQuotaChildModel();

    int availedLeaves = leaveQuotaResponseModel.leaveQuota!.sickLeaves! -
        leaveQuotaResponseModel.leaveQuota!.remainingSickLeaves!;
    double percentageValue =
        (leaveQuotaResponseModel.leaveQuota!.remainingSickLeaves!) /
            (leaveQuotaResponseModel.leaveQuota!.sickLeaves!);

    annualLeavesChildModel.totalLeaves =
        leaveQuotaResponseModel.leaveQuota!.sickLeaves;
    annualLeavesChildModel.remainingLeaves =
        leaveQuotaResponseModel.leaveQuota!.remainingSickLeaves;
    annualLeavesChildModel.availedLeaves = availedLeaves;
    annualLeavesChildModel.percentageValue = percentageValue;

    annualLeavesChildModel.totalLeavesName = "Total Sick Leaves ";
    annualLeavesChildModel.remainingLeavesName = "Remaining Leaves ";
    annualLeavesChildModel.availedLeavesName = "Availed Leaves ";

    return annualLeavesChildModel;
  }

  LeaveQuotaModel getCasualLeavesQuotaObject(
      LeaveQuotaResponseModel leaveQuotaResponseModel) {
    LeaveQuotaChildModel annualLeavesChildModel =
        getSickLeavesChildModelObject(leaveQuotaResponseModel);
    List<LeaveQuotaChildModel> annualLeavesChildModelList = [
      annualLeavesChildModel
    ];

    LeaveQuotaModel annualLeavesModel = LeaveQuotaModel();
    annualLeavesModel.title = "Casual Leaves";
    annualLeavesModel.childList = annualLeavesChildModelList;

    return annualLeavesModel;
  }

  LeaveQuotaChildModel getCasualLeavesChildModelObject(
      LeaveQuotaResponseModel leaveQuotaResponseModel) {
    LeaveQuotaChildModel annualLeavesChildModel = new LeaveQuotaChildModel();

    int availedLeaves = leaveQuotaResponseModel.leaveQuota!.casualLeaves! -
        leaveQuotaResponseModel.leaveQuota!.remainingCasualLeaves!;
    double percentageValue =
        (leaveQuotaResponseModel.leaveQuota!.remainingCasualLeaves!) /
            (leaveQuotaResponseModel.leaveQuota!.casualLeaves!);

    annualLeavesChildModel.totalLeaves =
        leaveQuotaResponseModel.leaveQuota!.casualLeaves!;
    annualLeavesChildModel.remainingLeaves =
        leaveQuotaResponseModel.leaveQuota!.remainingCasualLeaves!;
    annualLeavesChildModel.availedLeaves = availedLeaves;
    annualLeavesChildModel.percentageValue = percentageValue;

    annualLeavesChildModel.totalLeavesName = "Total Casual Leaves ";
    annualLeavesChildModel.remainingLeavesName = "Remaining Leaves ";
    annualLeavesChildModel.availedLeavesName = "Availed Leaves ";

    return annualLeavesChildModel;
  }
}

class ExpandableClass extends StatefulWidget {
  final String? title;

  //List<LeaveQoutaResponseDataModel> childModel;
  List<LeaveQuotaChildModel>? childModel;
  int? index;
  bool isLightTheme;

  // expandableClass({Key key, this.title, this.childModel, this.childModel2,this.index,this.isLightTheme})
  //     : super(key: key);

  ExpandableClass(
      {Key? key,
      this.title,
      this.childModel,
      this.index,
      required this.isLightTheme})
      : super(key: key);

  @override
  _ExpandableClassState createState() => _ExpandableClassState();
}

class _ExpandableClassState extends State<ExpandableClass> {
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
            // padding: new EdgeInsets.only(left: 10.0, right: 10.0),
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
                          returnFlagForIcon(forFirstTimeFlag, expandFlag,
                                  widget.index!, widget.childModel!.length)
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          // expandFlag
                          //     ? Icons.keyboard_arrow_up
                          //     : Icons.keyboard_arrow_down,
                          color: white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      print('You have got $expandFlag as result');
                      setState(() {
                        if (forFirstTimeFlag == true) {
                          forFirstTimeFlag = false;

                          //expandFlag = !expandFlag;
                        } else {
                          expandFlag = !expandFlag;
                        }
                      });
                    }),
              ],
            ),
          ),
          new ExpandableContainer(
              expanded: returnFlag(forFirstTimeFlag, widget.index!,
                  widget.childModel!.length, expandFlag),
              // expanded: expandFlag,
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
                            circularProgressBar(
                                widget.isLightTheme,
                                widget.childModel![index].percentageValue!,
                                widget.childModel![index].totalLeaves
                                    .toString()),
                            customFixedHeightSizedBox(size),
                            CustomText(
                              // text: "Total Annual Leaves",
                              text: widget.childModel![index].totalLeavesName,
                              size: headingtFontSize(size),
                              color: white,
                            ),
                            customFixedHeightSizedBox(size),
                            customFixedHeightSizedBox(size),
                            leaveRowItem(
                                size,
                                widget.isLightTheme,
                                widget.childModel![index].availedLeavesName!,
                                widget.childModel![index].availedLeaves
                                    .toString()),
                            leaveRowItem(
                                size,
                                widget.isLightTheme,
                                widget.childModel![index].remainingLeavesName!,
                                widget.childModel![index].remainingLeaves
                                    .toString()),
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

const TWO_PI = 3.14 * 2;

Widget circularProgressBar(
    bool isLightTheme, double percentageValue, String totalLeaves) {
  final double size = 55;
  return TweenAnimationBuilder(
      // tween: Tween(begin: 0.0, end: 0.35),
      tween: Tween(begin: 0.0, end: percentageValue),
      duration: Duration(seconds: 2),
      builder: (context, value, child) {
        //int percentage = (value * 100).ceil();
        return Container(
          width: size,
          height: size,
          color: isLightTheme ? lightModeColor : darkModeColor,
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                      startAngle: 0.0,
                      endAngle: TWO_PI,
                      // stops: [value, value],
                      center: Alignment.center,
                      colors: [
                        isLightTheme ? white : orange,
                        Colors.grey.withAlpha(55)
                      ]).createShader(rect);
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLightTheme ? white : Colors.orange[100]),
                ),
              ),
              Center(
                child: Container(
                  width: size - 15,
                  height: size - 15,
                  decoration: BoxDecoration(
                      color: isLightTheme ? lightModeColor : darkModeColor,
                      shape: BoxShape.circle),
                  child: Center(
                    child: CustomText(
                      // text: "$percentage",
                      text: totalLeaves,
                      color: white,
                      size: 17,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}

bool returnFlagForIcon(
    bool forFirstTime, bool expandedFlagBool, int index, int length) {
  bool expandedFlag;
  print("first time flag for Icon" + forFirstTime.toString());
  print("Index :" + index.toString());
  print("expandedFlagBool :" + expandedFlagBool.toString());
  if (forFirstTime == true) {
    if (index == 0) {
      expandedFlag = true;
    } else {
      expandedFlag = false;
    }
  } else {
    expandedFlag = expandedFlagBool;
  }

  // if (length == index) {
  //   forFirstTimeFlag = true;
  //   print("Index == length and flag true");
  // }

  print("flag in function for Icon " + expandedFlag.toString());
  print(
      "..........................................return flag for icon end....................");
  return expandedFlag;
}

bool returnFlag(
    bool forFirstTime, int index, int length, bool expandedFlagBool) {
  bool expandedFlag;
  print("...............first time " + forFirstTime.toString());
  print("Index :" + index.toString());
  print("length :" + length.toString());
  print("expandedFlagBool :" + expandedFlagBool.toString());

  if (forFirstTime == true) {
    if (index == 0) {
      expandedFlag = true;
    } else {
      expandedFlag = false;
    }

    if (length == index) {
      forFirstTimeFlag = true;
    }
  } else {
    expandedFlag = expandedFlagBool;
  }

  print("..............flag in function " + expandedFlag.toString());
  return expandedFlag;
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
      // child: new Container(
      //   child: child,
      //   // decoration: new BoxDecoration(border: new Border.all(width: 20.0, color: Colors.blue)),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15.0),
      //     color: Color(0xff155cb0),
      //   ),
      // ),
    );
  }
}

Widget leaveRowItem(
    Size size, bool isLightTheme, String leavesName, String numberOfLeaves) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Flexible(
          child: ClipOval(
            child: Container(
              color: isLightTheme ? white : orange,
              height: 45.0,
              width: 45.0,
              child: Center(
                  child: CustomText(
                text: numberOfLeaves,
                color: isLightTheme ? black : white,
                size: headingtFontSize(size),
              )

                  // Text(
                  //   AvailedLeaves,
                  //   style: TextStyle(
                  //       color: isLightTheme?black:white, fontSize: HeadingtFontSize(size)),
                  //   textAlign: TextAlign.center,
                  // )

                  ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CustomText(
              // text: "Availed Leaves",
              text: leavesName,
              size: headingtFontSize(size),
              color: white,
            ),
          ),
        ),
      ],
    ),
  );
}

//Dashboard design.....................................................................................................END
