import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:provider/provider.dart';

class TodayAttendance extends StatelessWidget {
   String? checkIn, checkOut;

   TodayAttendance({this.checkIn, this.checkOut});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isLightTheme = themeProvider.isLightTheme;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: Column(children: [
          
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //today check in
                Flexible(child: checkInOutDesign(size, isLightTheme,"Check In",(checkIn==null || checkIn=="" ? "N/A":checkIn)!)),
                Flexible(child: checkInOutDesign(size, isLightTheme,"Check In",(checkOut==null || checkOut=="" ? "N/A":checkOut)!)),
              ],
            ),
          ),
          
          Container(
            margin: EdgeInsets.all(40),
            child: Divider(height: 5,
            color: isLightTheme?green:orange,),
          ),
          
          
        ]),
      ),
    );
  }
}
