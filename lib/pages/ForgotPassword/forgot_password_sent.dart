import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Components/rounded_button.dart';
// import 'package:hrms_app/Components/rounded_button.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:hrms_app/pages/Login/login.dart';
import 'package:hrms_app/utils/strings.dart';
import 'package:provider/provider.dart';

class ForgotPasswordSent extends StatelessWidget {
  String email;


  ForgotPasswordSent({required this.email});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    bool isLightTheme = themeProvider.isLightTheme;

    return Scaffold(
        backgroundColor: isLightTheme ? lightModeBackgroundColor:darkModeBackgroundColor  ,
        appBar: AppBar(
          primary: true,
          title: customToolBar(size, backButtonImagePath, "Forgot Password",
              isLightTheme ? true : false),
          automaticallyImplyLeading: false,
          // backgroundColor: l_toolbar_bg_color,
          backgroundColor:
              isLightTheme ? l_toolbar_bg_color : d_toolbar_bg_color,
          // status bar color
          // brightness: Brightness.light,
          shadowColor: Colors.transparent,
          titleSpacing: 0.9,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              color: white,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.15, right: size.width * 0.15),
                child: Column(
                  children: [
                    CustomText(
                      text: forgot_password_sent_text,
                      color: red,
                    ),
                    CustomText(
                      // ignore: unnecessary_null_comparison
                      text: email==null ? "" : this.email,
                      color: red,
                    ),
                    customFixedHeightSizedBox(size),
                    CustomText(
                      text: "successfully",
                      color: red,
                    )
                  ],
                )),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            customFixedHeightSizedBox(size),
            RoundedButton(
              text: "Login",
              color: themeProvider.isLightTheme ? green : orange,
              press: ()  {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ));
  }
}
