import 'package:flutter/material.dart';

class MobileDashboardMenu extends StatelessWidget {
  const MobileDashboardMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView(
            scrollDirection: Axis.horizontal,

            shrinkWrap: true,
            // padding:  const EdgeInsets.all(200.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200, //height
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                mainAxisExtent: 150), //width
            children: [
            InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/dashboard/checkin');
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              width: 160,
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
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              width: 160,
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
                  'Patients',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        InkWell(onTap: (() {
           Navigator.pushNamed(context, '/dashboard/appointment');
        }),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              width: 160,
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
                  'Appointments',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              width: 160,
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
                  'Schedule',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
