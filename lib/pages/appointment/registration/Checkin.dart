import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/features/registration/registration_cubit.dart';

class Checkin extends StatefulWidget {
  const Checkin({Key? key}) : super(key: key);

  @override
  State<Checkin> createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegistrationCubit>().getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          registrationBody(),
        ],
      ),
    );
  }

  Widget registrationBody() {
    return (const Appointment());
  }
}

class Appointment extends StatefulWidget {
  const Appointment({
    Key? key,
  }) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var dateFormat = DateFormat('MM/dd/yyyy hh:mm a');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        print(state.appointmentList.length);
        if (state.appointmentList.isEmpty) {
          return Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 1.2,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 48,
                                  height: 48,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )))
              ]));
        } else {

          return 

                ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemCount: state.appointmentList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    width: 200,
                    decoration: BoxDecoration(
                       color: const Color.fromARGB(255, 248, 254, 254),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.appointmentList[index]
                                    ['firstName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),
                              ),
                              Text(state.appointmentList[index]
                                  ['lastName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                            
                          ),
                         ),
                      const Padding(
                        padding: EdgeInsets.only(left:15.0, top:10),
                        child: Text('Registration date', style: TextStyle(fontSize: 12),),
                      ),
                      
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 120,
                            height: 30,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 56, 155, 152)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ))),
                                onPressed: () {
                                  print("reschedule");
                                },
                                child: const Text('Checkin')),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }) 
              ;
        }
      },
    );
  }
}



/* 
   var date = dateFormat
           .format(DateTime.parse(state.appointmentList[0]['latestRegistration'])); 
   ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemCount: state.appointmentList.length,
              itemBuilder: (BuildContext context, int index) {
                var date= dateFormat.format(DateTime.parse(
                    state.appointmentList[index]['appointmentDateTime']));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    width: 300,
                    color: Colors.accents[5],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.appointmentList[index]
                                    ['patient']['firstName']),
                              ),
                              Text(state.appointmentList[index]['patient']
                                  ['lastName']),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                              state.appointmentList[index]['reasonForVisit']),
                        ),
                        Text(state.appointmentList[index]['typeOfVisit']),
                        //appointmentDateTime
                        Text(date),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 120,
                            height: 30,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 56, 155, 152)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ))),
                                onPressed: () {
                                  print("reschedule");
                                },
                                child: const Text('Checkin')),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }) 
              ;

*/