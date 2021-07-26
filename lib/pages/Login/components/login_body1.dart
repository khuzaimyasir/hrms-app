import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Components/rounded_button.dart';
import 'package:hrms_app/Components/rounded_input_field.dart';
import 'package:hrms_app/Components/rounded_password_field.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/model/sigin/login_response_model.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';

import 'package:hrms_app/pages/Dashboard/dashboard2.dart';
import 'package:hrms_app/pages/ForgotPassword/forgot_password.dart';
// import 'package:hrms_app/utils/secure_storage.dart';
import 'package:hrms_app/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/RestAPI/rest_api.dart';

// import 'login_background.dart';

class LoginBody1 extends StatefulWidget {
  @override
  _LoginBody1State createState() => _LoginBody1State();
}

class _LoginBody1State extends State<LoginBody1> {
  late bool _rememberMeFlag;

  late bool _isEmailTextFieldVisible;
  late bool _isPasswordTextFieldVisible;

  late String _email, _password;

  // String _emailSaved, _passwordSaved;

  @override
  void initState() {
    _rememberMeFlag = true;

    _isEmailTextFieldVisible = false;
    _isPasswordTextFieldVisible = false;


    _email = "";
    _password = "";

    // _emailSaved = "";
    // _passwordSaved = "";

    getSecureData();
    // print("After email :"+_emailSaved);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          clipBehavior: Clip.none, 
          // // overflow: Overflow.visible, now changed to clipbehaviour
          fit: StackFit.passthrough,
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),

                      customFixedHeightSizedBox(size),

                      //inovedia logo
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.1, 0, size.width * 0.1, 0),
                        child: Image.asset(
                          themeProvider.isLightTheme
                              ? "assets/images/inovedia_logo.png"
                              : "assets/images/inovedialogo_white.png",
                          height: size.height * 0.28,
                        ),
                      ),

                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),

                      //this email field is mandatory
                      Visibility(
                        visible: _isEmailTextFieldVisible,
                        child: Container(
                            margin: EdgeInsets.only(right: size.width * 0.11),
                            alignment: Alignment.topRight,
                            child: CustomText(
                              text: "This field is mandatory.",
                              color: red,
                            )),
                      ),

                      RoundedInputField(
                        hintText: _email.isEmpty ? "Your Email" : _email,
                        onChanged: (value) {
                          print("email :" + value);

                          _email = value;

                          if (value.isEmpty) {
                            setState(() {
                              _isEmailTextFieldVisible =
                                  !_isEmailTextFieldVisible;
                            });
                          } else if (_isEmailTextFieldVisible == true) {
                            setState(() {
                              _isEmailTextFieldVisible = false;
                            });
                          }
                        },
                      ),

                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),

                      Visibility(
                        visible: _isPasswordTextFieldVisible,
                        child: Container(
                            margin: EdgeInsets.only(right: size.width * 0.11),
                            alignment: Alignment.topRight,
                            child: CustomText(
                              text: "This field is mandatory.",
                              color: red,
                            )),
                      ),
                      RoundedPasswordField(
                        hintText: _password.isEmpty ? "Password" : _password,
                        onChanged: (value) {
                          _password = value;

                          if (value.isEmpty) {
                            setState(() {
                              _isPasswordTextFieldVisible =
                                  !_isPasswordTextFieldVisible;
                            });
                          } else if (_isPasswordTextFieldVisible == true) {
                            setState(() {
                              _isPasswordTextFieldVisible = false;
                            });
                          }
                        },
                      ),
                      customFixedHeightSizedBox(size),

                      //this is for check box
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.1, 0, size.width * 0.1, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // ),

                                Checkbox(
                                  value: _rememberMeFlag,
                                  onChanged: (value) {
                                    print("on changed ");

                                    if (value == true) {
                                      print("value true");
                                    } else if (value == false) {
                                      print("value false");
                                    }

                                    setState(() {
                                      _rememberMeFlag = !_rememberMeFlag;
                                    });
                                  },
                                  activeColor: themeProvider.isLightTheme
                                      ? lightModeColor
                                      : orange,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  checkColor: white,
                                  hoverColor: white,
                                  focusColor: black,
                                ),
                                Text("Remember Me")
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPassword()),
                                  );
                                },
                                child: Text("Forgot Password?")),
                          ],
                        ),
                      ),

                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),

                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),

                      customFixedHeightSizedBox(size),
                      customFixedHeightSizedBox(size),

                      RoundedButton(
                        text: "LOGIN",
                        color: themeProvider.isLightTheme ? green : orange,
                        press: () async {
                          RestApi a = new RestApi();

                          //this check is for email
                          if (_email == "") {
                            setState(() {
                              _isEmailTextFieldVisible = true;
                            });
                          }

                          //this check is for password
                          if (_password == "") {
                            setState(() {
                              _isPasswordTextFieldVisible = true;
                            });
                          }

                          if (_email.isNotEmpty && _password.isNotEmpty) {
                            loadData(_email, _password);

                            // EasyLoading.show();
                            // return FutureBuilder<LoginResponseModel>(
                            //   future: a.loginApiCall(_email, _password),
                            //   builder: (context, snapshot) {
                            //
                            //     print("builder");
                            //
                            //     EasyLoading.dismiss();
                            //
                            //
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.done) {
                            //
                            //       print("builder Done");
                            //
                            //
                            //       if (snapshot.data == null) {
                            //         print("Error");
                            //         print("Status :" + snapshot.data.status);
                            //       } else {
                            //         print("Name :" + snapshot.data.status);
                            //       }
                            //
                            //     }
                            //
                            //     return Container();
                            //   },
                            // );

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => MenuDashboardPage()),
                            // );

                          }
                        },
                      ),
                    ],
                  ),

                  //bottom version
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: themeProvider.isLightTheme
                                  ? [
                                      l_container_gradient_1,
                                      l_container_gradient_2
                                    ]
                                  : [
                                      d_container_gradient_1,
                                      d_container_gradient_2
                                    ])),
                      width: size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      //color: themeProvider.isLightTheme ? l_login_version_bg_color : b_login_version_bg_color,
                      child: Text(
                        "HRMS App Version 1.0",
                        style: TextStyle(
                            color: themeProvider.isLightTheme
                                ? l_login_version_text_color
                                : d_login_version_text_color),
                      )),
                ],
              ),
            ),

            //this is for circular progress bar at center
            Center(
              child: Visibility(
                  visible: false,
                  //child: showAlertDialog(context)),

                  child: Container(
                    color: red,
                    padding: EdgeInsets.all(20),
                    height: size.height * 0.15,
                    width: size.width * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        CustomText(text: "loading")
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void loadData(String email, String password) async {
    try {
      EasyLoading.show();

      RestApi a = new RestApi();
      final LoginResponseModel user = (await a.loginApiCall(email, password))!;
      print(user);
      EasyLoading.dismiss();

      if (user.status == "success") {
        setSecureData(email, password, user.apiKey!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuDashboardPage2()),
        );
      } else if (user.status == "error") {
        EasyLoading.showError(errorMessage, duration: Duration(seconds: 4));
      }
    } catch (e) {
      print("catching error :" + e.toString());
      EasyLoading.showError(e.toString());
      print(e);
    }
  }

  void setSecureData(String email, String password, String apiKey) async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    await storage.write(key: emailString, value: email);
    await storage.write(key: passwordString, value: password);
    await storage.write(key: apiKeyString, value: apiKey);
  }

  void getSecureData() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    // ignore: unnecessary_null_comparison
    if (storage == null) {
    } else {
      String email = (await storage.read(key: emailString))!;
      String password = (await storage.read(key: passwordString))!;

      if (email != null && password != null) {
        print("Email in DB :" + email);
        print("Password in DB :" + password);

        setState(() {
          _email = email;
          _password = password;
        });

        loadData(email, email);
      }
    }
  }
}
