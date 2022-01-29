import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, left: 10, bottom: 20),
            child: Text(
              "Schedule",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 225, 229, 232),
            height: 70,
            width: 370,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: InkWell(
                      onTap: () {
                        print("hi");
                      },
                      child: Container(
                        color: const Color.fromARGB(255, 121, 113, 234),
                        width: 110,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Upcoming",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: InkWell(
                      onTap: () {
                        print("hi");
                      },
                      child: Container(
                        color: const Color.fromARGB(255, 239, 241, 243),
                        width: 110,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Completed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 62, 70),
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: InkWell(
                      onTap: () {
                        print("hi");
                      },
                      child: Container(
                        color: const Color.fromARGB(255, 239, 241, 243),
                        width: 110,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Cancelled",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 62, 70),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          //coming form backend
          Padding(
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
                                shape: BoxShape.circle,)
                                
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Etiosa Obasuyi',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 120,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                                          backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromARGB(255, 206, 218, 217)),

                                          
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            )),
                                            elevation:
                                                MaterialStateProperty.all(0)),
                                        onPressed: () => {print('cancel')},
                                        child: const Text('Cancel', style: TextStyle(color: Colors.black),),
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
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromARGB(
                                                          255, 56, 155, 152)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
