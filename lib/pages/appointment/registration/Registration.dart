import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/registration/registration_cubit.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegistrationCubit>().getAppointments();
  }

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
                  "Registration",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context)
                        .pushNamed("/dashboard/registrationForm");
                  }),
                  child: Container(
                    height: 40,
                    width: 160,
                    color: const Color.fromARGB(255, 56, 155, 152),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10),
                      child: Text(
                        'Register Patient',
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
          const SizedBox(height: 30),

          //coming form backend
          registrationBody(),
        ],
      ),
    ));
  }

  Padding registrationBody() {
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
                    const Appointment(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Appointment extends StatelessWidget {
  const Appointment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      print('appointments: ${state.appointmentList}');
      print('appointment size: ${state.appointmentList.length}');
      if (state.appointmentList.isNotEmpty) {
        var appointments = state.appointmentList;
        print('bulding list');
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: appointments.length,
            itemBuilder: (BuildContext context, int index) {
              print('ID: ${appointments[index]}');
              return Container(
                height: 200,
                child: Text('ID: ${state.appointmentList[index]}'),
              );
            });
      }
      return Text('loading');
    });
  }

  /*    if(state.appointmentList.length>0){
          return (
          ListView.builder(
            itemCount:state.appointmentList.length,
            itemBuilder: (context, index){
              return( Container(child: Text(state.appointmentList[index].id))

              )})}}}
            
        
        */

  //    mainAxisAlignment: MainAxisAlignment.start,
  //  crossAxisAlignment: CrossAxisAlignment.start,
  /*   children: [
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
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 56, 155, 152)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ))),
                        onPressed: () {
                          print("reschedule");
                        },
                        child: const Text('Register')),
                  ),
                )
              ], */

  //  ],
  //  );
  // }
  // )
}
