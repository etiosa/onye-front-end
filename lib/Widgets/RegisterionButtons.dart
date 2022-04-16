
import 'package:flutter/material.dart';

import 'Button.dart';
class RegisterationButtons extends StatelessWidget {
  final String type;
  final String role;
  final Function addClincialNote;
  // Function addRegisteration;
  const RegisterationButtons(
      {Key? key,
      required this.type,
      required this.role,
      required this.addClincialNote
      // required this.addRegisteration,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (role == 'DOCTOR') {
      return Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Button(
                height: 50,
                width: 130,
                setColor: true,
                blackColor: 152,
                greenColor: 155,
                redColor: 56,
                label: "Register",
                onPressed: () {
                  // var reponse = addRegisteration();
                  //print(reponse);
                }),
            Button(
                height: 50,
                width: 130,
                label: "Clinical Note",
                setColor: true,
                blackColor: 238,
                greenColor: 0,
                redColor: 98,
                onPressed: () {
                  addClincialNote();
                })
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Button(
                height: 50,
                width: 130,
                setColor: true,
                blackColor: 152,
                greenColor: 155,
                redColor: 56,
                label: "Register",
                onPressed: () {}),
          ],
        ),
      );
    }
  }
}
