import 'package:flutter/material.dart';

class DashboardMenuItem extends StatelessWidget {
  const DashboardMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
     SizedBox(
          height: 350,
          child: Padding(
          
            padding: const EdgeInsets.all(100.0),
           
              child: GridView(
                
                shrinkWrap: true,
                // padding:  const EdgeInsets.all(200.0),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 150),
                children: [
                  Container(
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
                  Container(
                    color: Colors.brown,
                  ),
                  Container(
                    color: Colors.blueAccent,
                  ),
                  Container(
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          );
  

    /* Row(
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
    ); */
  }
}
