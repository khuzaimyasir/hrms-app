import 'package:flutter/material.dart';
// import 'package:hrms_app/Constants/constants.dart';

// import 'custom_text.dart';

class CustomIcon extends StatelessWidget {
  final IconData? icon;
  final double? size;
  final Color? color;


  CustomIcon({@required this.icon,this.size,this.color} );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon, color: color, size: size,),
        // SizedBox(height: 2,),
        // CustomText(text: name,)
      ],
    );
  }
}
