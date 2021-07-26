import 'package:flutter/material.dart';



class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   top: 0,
          //   left: 0,
          //
          //   // child: Image.asset(
          //   //   "assets/images/main_top1.png",
          //   //   width: size.width * 0.35,
          //   // ),
          //
          // ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   // child: Image.asset(
          //   //   "assets/images/login_bottom1.png",
          //   //   width: size.width * 0.4,
          //   // ),
          // ),
          child,
        ],
      ),
    );
  }
}