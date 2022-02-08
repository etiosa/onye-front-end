import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Schedule",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: (() {
                    print('new appointment');
                  }),
                  child: Container(
                    height: 40,
                    width: 160,
                    color: const Color.fromARGB(255, 56, 155, 152),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Create New Appointment',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    print("hi");
                  },
                  child: Container(
                    color: const Color.fromARGB(255, 56, 155, 152),
                    width: 100,
                    height: 40,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Upcoming",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    print("hi");
                  },
                  child: Container(
                    color: const Color.fromARGB(255, 226, 241, 241),
                    width: 100,
                    height: 40,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Completed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 56, 155, 152),
                        ),
                      ),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    print("hi");
                  },
                  child: Container(
                    color: const Color.fromARGB(255, 226, 241, 241),
                    width: 100,
                    height: 40,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Cancelled",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 56, 155, 152),
                        ),
                      ),
                    ),
                  )),
            ],
          ),

          const SizedBox(height: 30),

          //coming form backend
          scheduleBody(),
        ],
      ),
    ));
  }

  Padding scheduleBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 500,
        height: 250,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 80,
                        width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        )),
                    sheduleContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column sheduleContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Etiosa Obasuyi', //TODO: backend
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Reasons for visit here', //TODO: backend
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          height: 1,
          width: 320,
          child: Container(
            color: Colors.black12,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 50.0),
              child: Text('12/03/2021'),
            ),
            Padding(
              padding: EdgeInsets.only(right: 50.0),
              child: Text('10:30 AM'),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0.0),
              child: Text("Status"),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 222, 52, 73)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                      elevation: MaterialStateProperty.all(0)),
                  onPressed: () => {print('cancel')},
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 56, 155, 152)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: () {
                      print("reschedule");
                    },
                    child: const Text('Reschedule')),
              ),
            )
          ],
        )
      ],
    );
  }
}
