

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:hrms_app/pages/My%20Attendance/AttendanceHistory2.dart';
import 'package:hrms_app/pages/My%20Attendance/TodayAttendance.dart';

class MyAttendance extends StatefulWidget {
  final String? checkIn,checkOut;
  final String? apiKey;


  MyAttendance({this.checkIn, this.checkOut,this.apiKey});

  @override
  MyAttendanceState createState() => MyAttendanceState();
}

class MyAttendanceState extends State<MyAttendance>
    with SingleTickerProviderStateMixin {
//  List<Tab> tabs;

   List<Tab> tabs = <Tab>[
    new Tab(text: "Today"),
    new Tab(text: "History"),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Size size = MediaQuery.of(context).size;
    bool isLightTheme=themeProvider.isLightTheme;

    return new Scaffold(
      backgroundColor: white,
      appBar:  AppBar(

        primary: true,
        title:Text("My Attendance"),
        // title: customToolBar(size, backButtonImagePath, "My Attendance", isLightTheme ? true:false),
        // automaticallyImplyLeading: false,
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor:isLightTheme?black:grey,
          labelColor: white,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.only(left: 45,right: 45),
          indicator: new BubbleTabIndicator(
              indicatorHeight: 45.0,
              padding: EdgeInsets.only(left: 25,right: 25),
              indicatorColor: isLightTheme?green:orange,
              tabBarIndicatorSize: TabBarIndicatorSize.label,

              indicatorRadius: 120
          ),
          tabs: tabs,
          controller: _tabController,
        ),
        // backgroundColor: l_toolbar_bg_color,
        backgroundColor: isLightTheme? l_toolbar_bg_color: d_toolbar_bg_color, // status bar color
        // brightness: Brightness.light,
        shadowColor: Colors.transparent,
        titleSpacing: 0.9,
      ),
      body: new TabBarView(
        controller: _tabController,
        children: [
          TodayAttendance(checkIn: widget.checkIn,checkOut: widget.checkOut,),
          AttendanceHistory2(apiKey: widget.apiKey,),
        ],

      ),
    );
  }
}
