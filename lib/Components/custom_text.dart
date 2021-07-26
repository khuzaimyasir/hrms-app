import 'package:flutter/material.dart';
import 'package:hrms_app/Constants/constants.dart';

class CustomText extends StatelessWidget{
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;


   CustomText({@required this.text, this.size, this.color, this.weight, string });

  @override
  Widget build(BuildContext context) {
    return Text(text!,style: TextStyle(fontSize: size ?? 16, color: color ?? black, fontWeight: weight ?? FontWeight.normal));
  }
}