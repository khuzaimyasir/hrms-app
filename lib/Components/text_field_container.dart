import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
import 'package:provider/provider.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget ? child;


  const TextFieldContainer({Key ? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Size size=MediaQuery.of(context).size;
    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 10),
    //   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
    //
    //   decoration: BoxDecoration(
    //     color: blue,
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: Container(),
    // );

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: themeProvider.isLightTheme ? [l_container_gradient_1,l_container_gradient_2] : [d_container_gradient_1,d_container_gradient_2],
          ),
        borderRadius: BorderRadius.circular(15),
      ),

      // margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // margin: EdgeInsets.only(left: size.width*0.1,right: size.width*0.1),

      padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.width*0.01),


      width: size.width * 0.8,
      // decoration: BoxDecoration(
      //   color: themeProvider.isLightTheme ? blue : white,
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: child,
    );

  }
}
