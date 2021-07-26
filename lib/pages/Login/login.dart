import 'package:flutter/material.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'components/login_body1.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isLightTheme ? white : darkModeColor,
      body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: LoginBody1()),
    );

  }
}
