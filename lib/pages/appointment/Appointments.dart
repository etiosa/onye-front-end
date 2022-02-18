import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';
import 'package:onye_front_ened/features/registration/registration_cubit.dart';

import '../../features/appointment/appointment_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/features/appointment/appointment_cubit.dart';
import 'package:onye_front_ened/features/login_cubit/login_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/features/registration/registration_cubit.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
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
      context.read<AppointmentCubit>().searchAppointments(
          token: context.read<LoginCubit>().state.homeToken);
      /*  context
          .read<RegistrationCubit>()
          .getAppointments(token: context.read<LoginCubit>().state.homeToken); */
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
                    'Appointment',
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
                          'Create Appointment',
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              '/dashboard/appointment/createApppointment');
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
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        print(state);
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
                        /* AppointmentConfirmed(
                          appointmentList: state.appointmentList,
                          selectedIndex: index,
                        ), */
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
                          /*   CheckInPatient(
                              appointmentList: state.appointmentList,
                              selectedIndex: index,
                            ), */
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
                appointmentList[selectedIndex]['registrationDateTime'].isEmpty
                    ? const Color.fromARGB(255, 56, 155, 152)
                    : Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ))),
        onPressed: () => {
          appointmentList[selectedIndex]['registrationDateTime'].isEmpty
              ? showDialogConfirmation(context)
              : null
        },
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


/* 
class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointments> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 241, 243),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                      'Create New Appointment',
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          '/dashboard/appointment/createAppointment');
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Search",
                        style: TextStyle(
                            color: Color.fromARGB(255, 56, 155, 152))),
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(maxWidth: 350, maxHeight: 40),
                    child: TextFormField(
                      onChanged: (searchParams) => context
                          .read<AppointmentCubit>()
                          .setSearchParams(searchParams),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          DatePickerFeild(
                            label: 'From',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DateTimePickerFeild(
                            label: 'From',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          DatePickerFeild(
                            label: 'To',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DateTimePickerFeild(
                            label: 'To',
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  /*   const DatePickerFeild(),
                  const DateTimePickerFeild(), */
                  //  PatientLists(),
                  Container(
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
                        context.read<AppointmentCubit>().searchAppointments(token: context.read<LoginCubit>().state.homeToken);
                      },
                    ),
                  ),
                ],
              ),
            )

            //formSection()
          ],
        ),
      ),
    );
  }
}

Future datePicker(BuildContext context, String label) async {
  var dateFormat = DateFormat('yyyy-MM-dd');

  final initDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 5));

  String formattedDate = dateFormat.format(newDate!);

  // ignore: unnecessary_null_comparison
  if (newDate == null) return;
  switch (label) {
    case 'From':
      print('from');
      context.read<AppointmentCubit>().setStartDate(formattedDate);
      break;
    case 'To':
      print('from');

      context.read<AppointmentCubit>().setEndDate(formattedDate);

      break;
    default:
      break;
  }
  // String formattedDate = dateFormat.format(newDate);
  // String formattedDate = dateFormat.format(newDate);
  // context.read<AppointmentCubit>().setStartDate(formattedDate);
}

Future dateTimePicker(BuildContext context, String label) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;
  String formatTime = newTime.format(context);

  switch (label) {
    case 'From':
      print('from');
      context.read<AppointmentCubit>().setStartTime(formatTime);
      break;
    case 'To':
      print('from');

      context.read<AppointmentCubit>().setEndTime(formatTime);

      break;
    default:
      break;
  }
  print(newTime.format(context));
}

class DateTimePickerFeild extends StatelessWidget {
  const DateTimePickerFeild({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        print(state);
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                dateTimePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 80,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: TimeContent(
                      label: label,
                    )),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class DatePickerFeild extends StatelessWidget {
  const DatePickerFeild({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                datePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 80,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextContent(
                    label: label,
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class TimeContent extends StatelessWidget {
  const TimeContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label == 'From') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(
          context.read<AppointmentCubit>().state.startTime,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    if (label == 'To') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(context.read<AppointmentCubit>().state.endTime,
            style: const TextStyle(fontSize: 12)),
      );
    }
    return const Text('empty');
  }
}

class TextContent extends StatelessWidget {
  const TextContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label == 'From') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(
          context.read<AppointmentCubit>().state.startDate,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    if (label == 'To') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(context.read<AppointmentCubit>().state.endDate,
            style: const TextStyle(fontSize: 12)),
      );
    }
    return const Text('empty');
  }
}

class PatientLists extends StatelessWidget {
  const PatientLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            print(' was click');
            //context.read<AppointmentCubit>().searchAppointments();
          },
          child: (Container(
            child: Text('test'),
          )),
        );
      },
    );

    /*  return Container(
      child: Text('Appointments list'),
      
    ); */
  }
}

class FirstName extends StatelessWidget {
  const FirstName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("First Name"),
        ),
        TextFormField(
          onChanged: (firstname) =>
              context.read<RegistrationCubit>().setFirstName(firstname),
          obscureText: true,
          autofocus: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          validator: (String? value) {
            if (value!.isEmpty || value.length <= 7) {
              return 'Please enter  a validate password';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class LastName extends StatelessWidget {
  const LastName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Last Name"),
        ),
        TextFormField(
          onChanged: (lastname) =>
              context.read<RegistrationCubit>().setLastName(lastname),
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          validator: (String? value) {
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}
//TODO:  Date Picker

class DateOfBirth extends StatelessWidget {
  const DateOfBirth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Date Of Birth"),
        ),
        TextFormField(
          onChanged: (dateofBirth) =>
              context.read<RegistrationCubit>().setFirstName(dateofBirth),
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          validator: (String? value) {
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  your date of birth';
            }
            return null;
          },
        ),
      ],
    );
  }
}

//TODO: Drop down
class Gender extends StatelessWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Gender"),
        ),
        TextFormField(
          onChanged: (gender) =>
              context.read<RegistrationCubit>().setFirstName(gender),
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          validator: (String? value) {
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}

//TODO: Drop down

class Religion extends StatelessWidget {
  const Religion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Religion"),
        ),
        TextFormField(
          onChanged: (religion) =>
              context.read<RegistrationCubit>().setFirstName(religion),
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          validator: (String? value) {
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}

//TODO: Drop down
class EducationLevel extends StatelessWidget {
  const EducationLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text("Education Level"),
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (educationlevel) =>
              context.read<RegistrationCubit>().setFirstName(educationlevel),
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 222),
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          validator: (String? value) {
            if (value!.isEmpty ||
                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}").hasMatch(value)) {
              // print("error");
              return 'Please enter  a validate email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _SubmitButton({required this.formKey}) : super();

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<LoginCubitCubit, LoginCubitState>(
    // builder: (context, state) {
    return Container(
      width: 300,
      height: 60,
      padding: const EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ElevatedButton(
          autofocus: true,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 121, 113, 234)),
          ),
          child: const Text('Conintue'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              //send a request to backend
              // context.read<LoginCubitCubit>().login();
            }
          },
        ),
      ),
    );
    // },
    //);
  }
}

 */