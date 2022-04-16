import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
import 'package:onye_front_ened/pages/appointment/RescheduleAppointmentButton.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';

import '../Widgets/AppointmentCard.dart';
import '../Widgets/Loading.dart';
import 'appointment/state/appointment_cubit.dart';
import 'appointment/state/appointment_cubit.dart';
import 'appointment/state/appointment_cubit.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldText = TextEditingController();

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
                Button(
                    height: 50,
                    width: 170,
                    label: 'Create Appointment',
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/dashboard/appointment/createAppointment'))
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
                controller: fieldText,
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
          ),
          Button(
              height: 50,
              width: 100,
              label: 'Search',
              onPressed: () {
                context.read<AppointmentCubit>().searchAppointments(
                    token: context.read<LoginCubit>().state.homeToken,
                    searchParams:
                        context.read<AppointmentCubit>().state.searchParams);
                fieldText.clear();
              }),
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
        if (state.searchState == REGSEARCHSTATE.notFound) {
          return (const Center(
            child: SizedBox(
                height: 50,
                width: 200,
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('NOT FOUND'),
                ))),
          ));
        }

        if (state.appointmentList.isEmpty) {
          return const Loading();
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width:
                MediaQuery.of(context).size.width < 600 ? double.infinity : 600,
            child: ListView.builder(
                itemCount: state.appointmentList.length,
                itemBuilder: ((context, index) {
                  if (state.appointmentList[index]['type'] == 'appointment') {
                    return AppointmentCard(
                      appointmentId: state.appointmentList[index]['id'],
                      firstName: state.appointmentList[index]['patient']
                          ['firstName'],
                      lastName: state.appointmentList[index]['patient']
                          ['lastName'],
                      type: state.appointmentList[index]['type'],
                      dateTime: state.appointmentList[index]['dateTime'],
                      patientNumber: state.appointmentList[index]['patient']
                          ['patientNumber'],
                      role: context.read<LoginCubit>().state.role,
                      button: RescheduleAppointmentButton(
                          appointment: state.appointmentList[index]),
                    );
                  } else {
                    return const SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                })),
          );
        }
      },
    );
  }
}
