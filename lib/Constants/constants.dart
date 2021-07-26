import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Components/custom_icons.dart';
import 'package:hrms_app/Components/custom_text.dart';

const white = Color(0xFFFFFFFF);
const black = Colors.black;
const grey = Colors.grey;
const green = Color(0xFF6D884A);
const dark_green = Colors.green;
const red = Colors.redAccent;
const orange = Color(0xFFE8A000);
const blue=Color(0xFF006C7C);
const jet_black=Color(0xFF26242a);
const transparent=Colors.transparent;



const lightModeColor= blue;
const darkModeColor= jet_black;




//for container background color
const lightModeBackgroundColor= white;
const darkModeBackgroundColor= darkModeColor;



//for light mode
// const blue=Colors.blue;
const Color lightDashboardBackgroundColor = white;
const Color lightMenuBackgroundColor = blue;

//extra
const Color l_toolbar_bg_color =blue;
// const l_mode_text_white = white;
// const l_mode_text_white = white;
// const l_mode_text_blue = blue;
// const l_mode_text_green = green;

// const l_mode_text_green = green;

//Login
const l_login_version_text_color = black;
const l_container_gradient_1 = lightModeColor;
const l_container_gradient_2 = lightModeColor;

//dashboard
const l_dashboard_curved_container = white;
const l_dashboard_checkin_out_bg = blue;
const l_dashboard_checkin_out_text_color = white;

//attendance
const l_mode_text_focus_color = black;
const l_mode_text_un_focus_color = white;




//for dark mode.........................................................................................................................
// dark color code 0xFF4A4A58
const Color darkDashboardBackgroundColor = darkModeColor;
const Color darkMenuBackgroundColor = darkModeColor;

//extra
const Color d_toolbar_bg_color = darkModeColor;
// const d_mode_text_white = white;
// const d_mode_text_orange =orange;

//login
const d_login_version_text_color = black;

const d_container_gradient_1 = white;
const d_container_gradient_2 = white;


//dashboard
const d_dashboard_curved_container = white;
const d_dashboard_checkin_out_bg = darkModeColor;
const d_dashboard_checkin_out_text_color = white;

//attendance
const d_mode_text_focus_color = orange;
const d_mode_text_un_focus_color = white;











String backButtonImagePath="assets/icons/ic_back_white.png";


//size for different screen's
// const int font_size=MediaQuery.of(context).size;
sideMenuNameFontSize(Size size) {
  double fontSize = size.width * 0.035;
  return fontSize;
}

sideMenuDesignationFontSize(Size size) {
  double fontSize = size.width * 0.020;
  return fontSize;
}

smallTextFontSize(Size size) {
  double fontSize = size.width * 0.027;
  return fontSize;
}

textFontSize(Size size) {
  double fontSize = size.width * 0.033;
  return fontSize;
}

headingtFontSize(Size size) {
  double fontSize = size.width * 0.040;
  return fontSize;
}

toolbarFontSize(Size size) {
  double fontSize = size.width * 0.045;
  return fontSize;
}


dashboardSpaceSizedBox(Size size) {
  return SizedBox(height: size.height * 0.03);
}

menuHeightSizedBox(Size size) {
  return SizedBox(height: size.height * 0.03);
}

menuWidthSizedBox(Size size) {
  return SizedBox(width: size.width * 0.03);
}


//for same sized box
customFixedWidthSizedBox(Size size) {
  return SizedBox(width: size.width * 0.02);
}

customFixedHeightSizedBox(Size size) {
  return SizedBox(height: size.height * 0.01);
}

//for circular progress var
circularProgressBarRadius(Size size) {
  double fontSize = size.width * 0.13;
  return fontSize;
}

Widget customToolBar(Size size,String image,String title,bool isLightTheme) {
  return Container(
    height: size.height * 0.06,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),

      color: isLightTheme ? l_toolbar_bg_color:d_toolbar_bg_color,
    ),

    //color: isLightTheme ? l_toolbar_bg_color:d_toolbar_bg_color,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                // child: Icon(Icons.menu, color: Colors.white),
                child: Container(
                  height: size.height * 0.025,
                  child: Image.asset(image),
                ),
                onTap: () {
                  //return back to the previous activity
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
              child: Text(title,
                  style: TextStyle(
                      fontSize: toolbarFontSize(size),
                      color: white)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget checkInOutDesign(Size size, bool isLightTheme,String checkInText,String checkInValue) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      color: isLightTheme
          ? l_dashboard_checkin_out_bg
          : d_dashboard_checkin_out_bg,
    ),
    height: size.height * 0.13,
    width: size.width * 0.36,
    child: Column(
      children: [
        customFixedHeightSizedBox(size),
        CustomIcon(
          icon: Icons.access_time,
          color: isLightTheme?white:orange,
          size: 30,
        ),
        Divider(
          color: white,
          thickness: 2.0,
        ),
        CustomText(
          text: checkInText,
          size: headingtFontSize(size),
          color: d_dashboard_checkin_out_text_color,
          weight: FontWeight.bold,
        ),
        customFixedHeightSizedBox(size),
        CustomText(
          text: checkInValue,
          size: smallTextFontSize(size),
          color: d_dashboard_checkin_out_text_color,
        )
      ],
    ),
  );
}

