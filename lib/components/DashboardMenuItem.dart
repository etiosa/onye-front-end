import 'package:flutter/material.dart';

class DashboardMenuItem extends StatelessWidget {
  const DashboardMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: (() =>
              {Navigator.of(context).pushNamed("/dashboard/checkin")}),
          child: Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 56, 155, 152),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20),
              child: Text(
                'Registration',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() =>
              {Navigator.of(context).pushNamed("/dashboard/appointment")}),
          child: Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20),
              child: Text('Appointment'),
            ),
          ),
        ),
      ],
    );
  }
}
