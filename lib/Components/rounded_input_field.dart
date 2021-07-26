import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Components/text_field_container.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';

import 'package:provider/provider.dart';

class RoundedInputField extends StatelessWidget {
  final String ? labelText;
  final String ? hintText;
  final IconData ? icon;
  final ValueChanged<String> ? onChanged;
  const RoundedInputField({
    Key ? key,
    this.labelText,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: white,
        style: TextStyle(color: themeProvider.isLightTheme ? white : black,),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: themeProvider.isLightTheme ? white : black,
          ),
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(color: themeProvider.isLightTheme ? white : black,),
          hintStyle: TextStyle(color: themeProvider.isLightTheme ? white : black,),
          border: InputBorder.none,
        ),
      ),
    );


  }
}