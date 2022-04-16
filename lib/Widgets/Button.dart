import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/auth/state/login_cubit.dart';

class Button extends StatelessWidget {
  String label;
  Function onPressed;
  double height;
  double width;
  double paddingLeft;
  double paddingRight;
  double paddingTop;
  double paddingBottom;
  int redColor;
  int greenColor;
  int blackColor;
  bool setColor;
  
  /* int r,
  int g,
  int b */

  Button({
    required this.height,
    required this.width,
    required this.label,
    required this.onPressed,
    this.paddingBottom = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.redColor = 56,
    this.greenColor = 155,
    this.blackColor = 152,
    this.setColor = false,
    Key? key,
  }) : super(key: key) {
    if (setColor) {
      redColor = redColor;
      blackColor = blackColor;
      greenColor = greenColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(2),
        child: Padding(
          padding: EdgeInsets.only(
              bottom: paddingBottom,
              top: paddingTop,
              left: paddingLeft,
              right: paddingLeft),
          child: ElevatedButton(
            autofocus: true,
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                   Color.fromARGB(255, redColor ,greenColor, blackColor)),
            ),
            child: Text(label),
            onPressed: () {
              onPressed();
            },
          ),
        ),
      ),
    );
  }
}
