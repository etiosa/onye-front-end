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


  Button({
    required this.height,
    required this.width,
    required this.label,
    required this.onPressed,
    this.paddingBottom=0,
    this.paddingLeft=0,
    this.paddingRight=0,
    this.paddingTop=0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(2),
        child: Padding(
          padding:  EdgeInsets.only(bottom: paddingBottom, top: paddingTop,
            left: paddingLeft, right: paddingLeft
          ),
          child: ElevatedButton(
            autofocus: true,
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 56, 155, 152)),
            ),
            child: Text(label),
            onPressed: () {
              //context.read<LoginCubit>().logout();
              onPressed();
            },
          ),
        ),
      ),
    );
  }
}
