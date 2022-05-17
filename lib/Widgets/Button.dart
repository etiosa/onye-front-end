import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/auth/state/login_bloc.dart';

class Button extends StatefulWidget {
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
  bool isregsiter;
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
    this.isregsiter = false,
    Key? key,
  }) : super(key: key) {
    if (setColor) {
      redColor = redColor;
      blackColor = blackColor;
      greenColor = greenColor;
    }
  }

  @override
  State<Button> createState() => _ButtonState();

  bool isregister = false;
}

class _ButtonState extends State<Button> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("called");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(2),
        child: Padding(
          padding: EdgeInsets.only(
              bottom: widget.paddingBottom,
              top: widget.paddingTop,
              left: widget.paddingLeft,
              right: widget.paddingLeft),
          child: ElevatedButton(
              autofocus: true,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    widget.isregsiter == true
                        ? Colors.grey[700]
                        : Color.fromARGB(255, widget.redColor,
                            widget.greenColor, widget.blackColor)),
              ),
              child: Text(widget.label),
              onPressed:
                  widget.isregsiter == true ? null : () => widget.onPressed()),
        ),
      ),
    );
  }
}
