import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Components/rounded_button.dart';
import 'package:hrms_app/Components/rounded_input_field.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/RestAPI/rest_api.dart';
import 'package:hrms_app/model/forgot/forgot_password_response_model.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:hrms_app/pages/ForgotPassword/forgot_password_sent.dart';
import 'package:hrms_app/utils/strings.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {


  late bool _isEmailTextFieldVisible;
  late String _mendatoryText;
  late String _email;

  late bool isValidEmail;

  @override
  void initState() {
    _isEmailTextFieldVisible = false;

    _mendatoryText="";
    _email = "";

    isValidEmail=false;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    bool isLightTheme = themeProvider.isLightTheme;

    return Scaffold(
        backgroundColor: isLightTheme ? lightModeBackgroundColor:darkModeBackgroundColor ,
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
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
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
                      left: size.width * 0.1, right: size.width * 0.1),
                  child: CustomText(
                    text: forgot_password_text,
                    color: red,
                  )),

              customFixedHeightSizedBox(size),
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
                      text: _mendatoryText=="" ? "This field is mandatory." : _mendatoryText,
                      color: red,
                    )),
              ),
              RoundedInputField(
                icon: Icons.email,
                hintText: _email.isEmpty ? "Your Email" : _email,
                onChanged: (value) {
                  print("email :" + value);

                  _email = value;

                  if (value.isEmpty) {
                    setState(() {
                      _isEmailTextFieldVisible = !_isEmailTextFieldVisible;
                      _mendatoryText=mandatory_text;
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

              RoundedButton(
                text: "Submit",
                color: themeProvider.isLightTheme ? green : orange,
                press: () async {



                  if (_email == "") {
                    setState(() {
                      _isEmailTextFieldVisible = true;
                      _mendatoryText=mandatory_text;
                    });
                  }



                  // by using package
                  isValidEmail = EmailValidator.validate(_email);



                  //by using regular expression

                  // // using regular expression
                  // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(_email)) {
                  //   isValidEmail=false;
                  // }else{
                  //   isValidEmail=true;
                  // }





                  //this check is for email

                  if (_email.isNotEmpty) {

                    if(isValidEmail==true){
                      loadData(_email);
                    }else{
                      //enter a valid email
                      setState(() {
                        _isEmailTextFieldVisible = true;
                        _mendatoryText=invalid_email;
                      });
                    }


                  }


                },
              ),
            ],
          ),
        ));
  }


  void loadData(String email) async {
    try {
      EasyLoading.show();

      RestApi a = new RestApi();
      final ForgotPasswordResponseModel forgotPasswordResponseModel = (await a.forgotPasswordApiCall(email))!;
      print(forgotPasswordResponseModel);
      EasyLoading.dismiss();

      if (forgotPasswordResponseModel.status == "success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordSent(email: email,)),
        );
      } else if (forgotPasswordResponseModel.status == "error") {
        EasyLoading.showError(errorMessage,
            duration: Duration(seconds: 4));
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e);
    }
  }
}
