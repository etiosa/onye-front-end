import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/appointment/appointment_cubit.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';
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
    if (context.read<LoginCubit>().state.homeToken.isEmpty) {
      //redirect to home
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/login");
      });
    }
    if (context.read<LoginCubit>().state.homeToken.isNotEmpty) {
      context
          .read<RegistrationCubit>()
          .getAppointments(token: context.read<LoginCubit>().state.homeToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20, bottom: 20),
                  child: Text(
                    'CheckIn',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 170,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ElevatedButton(
                        autofocus: true,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 56, 155, 152)),
                        ),
                        child: const Text(
                          'Create Registration',
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              '/dashboard/appointment/createRegistration');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10),
            child: Text("Search",
                style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350, maxHeight: 40),
              child: TextFormField(
                /*   onChanged: (searchParams) => context
                          .read<RegistrationCubit>()
                          .set(searchParams),  */
                obscureText: false,
                autofocus: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 205, 226, 226),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              width: 100,
              margin: const EdgeInsets.only(left: 15),
              constraints: const BoxConstraints(maxWidth: 170),
              child: ElevatedButton(
                autofocus: true,
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 56, 155, 152)),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  context.read<AppointmentCubit>().searchAppointments();
                },
              ),
            ),
          ),
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
        if (state.appointmentList.isEmpty) {
          return Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 1.5,
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 1.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 48,
                                  height: 48,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 1.0),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 10.0,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 10.0,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 10.0,
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
          return Expanded(
            flex: 1,
            child: ListView.builder(
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppointmentConfirmed(
                          appointmentList: state.appointmentList,
                          selectedIndex: index,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      state.appointmentList[index]['patient']
                                          ['firstName'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.appointmentList[index]['patient']
                                        ['lastName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CheckInPatient(
                              appointmentList: state.appointmentList,
                              selectedIndex: index,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  );
                }),
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class AppointmentConfirmed extends StatelessWidget {
  AppointmentConfirmed({
    required this.appointmentList,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);
  List<dynamic> appointmentList;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (appointmentList[selectedIndex]['registrationDateTime'].isNotEmpty) {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else {
      return const Icon(
        Icons.check_circle,
        color: Colors.transparent,
      );
    }
  }
}

class Confirmation extends StatelessWidget {
  Confirmation(
      {Key? key, required this.appointmentList, required this.selectedIndex})
      : super(key: key);
  List<dynamic> appointmentList;
  int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 30,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              appointmentList[selectedIndex]['registrationDateTime'].isEmpty?  
              const Color.fromARGB(255, 56, 155, 152): Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ))),
        onPressed: () => {
                appointmentList[selectedIndex]['registrationDateTime'].isEmpty?
                     showDialogConfirmation(context) :null},
                     
          
        child: const Text('Checkin'),
      ),
    );
  }

  Future<String?> showDialogConfirmation(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Do you want to check this patient in'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class CheckInPatient extends StatelessWidget {
  CheckInPatient(
      {Key? key, required this.appointmentList, required this.selectedIndex})
      : super(key: key);
  List<dynamic> appointmentList;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (appointmentList[selectedIndex]['registrationDateTime'].isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Confirmation(
            appointmentList: appointmentList,
            selectedIndex: selectedIndex,
          ));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 120,
        height: 30,
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 56, 155, 152)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () {
              print("New registration");
            },
            child: const Text('Create new New registeration')),
      ),
    );
  }
}
