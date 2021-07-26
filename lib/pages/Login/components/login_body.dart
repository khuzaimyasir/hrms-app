import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Components/rounded_button.dart';
import 'package:hrms_app/Components/rounded_input_field.dart';
import 'package:hrms_app/Components/rounded_password_field.dart';

import 'login_background.dart';


class LoginBody extends StatelessWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _rememberMeFlag=false;

    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "LOGIN",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: size.height * 0.03),
            Container(
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Image.asset(
                "assets/images/inovedia_logo.png",
                height: size.height * 0.35,
              ),
            ),
            // SizedBox(height: size.height * 0.01),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),

            SizedBox(height: size.height * 0.01),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            SizedBox(height: size.height * 0.01),

            Container(
              margin: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    // onChanged: (value){
                    //   // setState((){
                    //   //   _rememberMeFlag=!_rememberMeFlag;
                    //   // });
                    // },

                    onChanged: (value){},
                    value: _rememberMeFlag,
                    activeColor: const Color(0xff00bbff),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                  ),
                  Text("Remember Me")
                ],

              ),
            ),



            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "LOGIN",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }


}
