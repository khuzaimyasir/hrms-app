import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/model/dashboard/leave_quota/leave_quota_response_model.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:provider/provider.dart';

class LeaveQuotaClass extends StatelessWidget {
  final bool? isLightTheme;
  List<LeaveQuotaChildModel>? leaveChildList;

  LeaveQuotaClass({this.isLightTheme,this.leaveChildList});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isLightTheme = themeProvider.isLightTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(left: 5,right: 5,top: 10),
            height: size.height * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isLightTheme ? lightModeColor : darkModeColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customFixedHeightSizedBox(size),
                circularProgressBar(isLightTheme, leaveChildList![0].percentageValue!, leaveChildList![0].totalLeaves.toString()),
                customFixedHeightSizedBox(size),
                CustomText(
                  // text: "Total Casual Leaves",
                  // text: leaveList.isEmpty?" ": leaveList.length>0 ? leaveList[0].childList[0].,
                  text: leaveChildList![0].totalLeavesName,
                  size: headingtFontSize(size),
                  color: white,
                ),
                customFixedHeightSizedBox(size),
                customFixedHeightSizedBox(size),
                leaveRowItem(
                    size, isLightTheme,  leaveChildList![0].availedLeavesName!,leaveChildList![0].availedLeaves.toString()),
                leaveRowItem(
                    size, isLightTheme, leaveChildList![0].remainingLeavesName!,leaveChildList![0].remainingLeaves.toString()),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(left: 5,right: 5,top: 10),
            height: size.height * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isLightTheme ? lightModeColor : darkModeColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customFixedHeightSizedBox(size),
                circularProgressBar(isLightTheme, leaveChildList![1].percentageValue!, leaveChildList![1].totalLeaves.toString()),
                customFixedHeightSizedBox(size),
                CustomText(
                  // text: "Total Casual Leaves",
                  // text: leaveList.isEmpty?" ": leaveList.length>0 ? leaveList[0].childList[0].,
                  text: leaveChildList![1].totalLeavesName,
                  size: headingtFontSize(size),
                  color: white,
                ),
                customFixedHeightSizedBox(size),
                customFixedHeightSizedBox(size),
                leaveRowItem(
                    size, isLightTheme,  leaveChildList![1].availedLeavesName!,leaveChildList![1].availedLeaves.toString()),
                leaveRowItem(
                    size, isLightTheme, leaveChildList![1].remainingLeavesName!,leaveChildList![1].remainingLeaves.toString()),
              ],
            ),
          ),


          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(left: 5,right: 5,top: 10),
            height: size.height * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isLightTheme ? lightModeColor : darkModeColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customFixedHeightSizedBox(size),
                circularProgressBar(isLightTheme, leaveChildList![2].percentageValue!, leaveChildList![2].totalLeaves.toString()),
                customFixedHeightSizedBox(size),
                CustomText(
                  // text: "Total Casual Leaves",
                  // text: leaveList.isEmpty?" ": leaveList.length>0 ? leaveList[0].childList[0].,
                  text: leaveChildList![2].totalLeavesName,
                  size: headingtFontSize(size),
                  color: white,
                ),
                customFixedHeightSizedBox(size),
                customFixedHeightSizedBox(size),
                leaveRowItem(
                    size, isLightTheme,  leaveChildList![2].availedLeavesName!,leaveChildList![2].availedLeaves.toString()),
                leaveRowItem(
                    size, isLightTheme, leaveChildList![2].remainingLeavesName!,leaveChildList![2].remainingLeaves.toString()),
              ],
            ),
          ),



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
