import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Components/text_field_container.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';

import 'package:provider/provider.dart';

class RoundedPasswordField extends StatelessWidget {
  final String ? labelText;
  final String ? hintText;
  final ValueChanged<String> ? onChanged;
  const RoundedPasswordField({
    Key ? key,
    this.labelText,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: white,
        style: TextStyle(color: themeProvider.isLightTheme ? white : black,),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: themeProvider.isLightTheme ? white : black,),
          hintText: hintText,
          hintStyle: TextStyle(color: themeProvider.isLightTheme ? white : black,),
          icon: Icon(
            Icons.lock,
            color: themeProvider.isLightTheme ? white : black,
          ),
          // suffixIcon: Icon(
          //   Icons.visibility,
          //   color: themeProvider.isLightTheme ? white : black,
          // ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}