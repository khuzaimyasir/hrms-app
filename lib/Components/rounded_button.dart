import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/Constants/constants.dart';


class RoundedButton extends StatelessWidget {
  final String ? text;
  // final Function press;
  final VoidCallback ? press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.color = green,
    this.textColor = white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // margin: EdgeInsets.symmetric(vertical: size.height*0.05),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
       
         
          onPressed: press,
          child: Text(
            text!,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}