import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/Widgets/button.dart';

import '../pages/appointment/state/appointment_cubit.dart';
import '../pages/appointments.dart';
import '../pages/auth/state/login_bloc.dart';
import 'patient_appointment_registeration_card.dart';

// ignore: must_be_immutable
class PatientRegistrationAppointmentCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String dateTime;
  late String middleName;
  final String patientNumber;
  final String imageURl;
  final String type;
  final String role;
  final String appointmentId;
  final Widget? button;
  final Function? clinicalNote;
  final Function? addRegisteration;

  PatientRegistrationAppointmentCard({
    required this.firstName,
    required this.lastName,
    required this.dateTime,
    required this.type,
    required this.role,
    this.middleName = '',
    this.imageURl = '',
    this.appointmentId = '',
    this.addRegisteration,
    required this.patientNumber,
    this.clinicalNote,
    this.button,
    Key? key,
  }) : super(key: key) {
    if (middleName.isEmpty || middleName == '') {
      middleName = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var dateTimeFormate = dateFormat.format(DateTime.parse(dateTime));
    var time = dateTimeFormate.split(' ')[1];
    time = time + ' ' + dateTimeFormate.split(' ')[2];
    var date = dateTimeFormate.split(' ')[0];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 250,
          width:
              MediaQuery.of(context).size.width < 600 ? double.infinity : 600,
          color: const Color.fromARGB(255, 236, 246, 246),
          child: Stack(children: [
            PatientAppointmentRegistrationCard(
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                patientNumber: patientNumber,
                date: date,
                time: time),
          ])),
    );
  }
}

class CallToActions extends StatelessWidget {
  final String role;
  final String type;
  final String appointmentId;
  final Widget? button;
  final Function addClincialNote;
  //Function addRegisteration;

  const CallToActions({
    required this.role,
    required this.type,
    required this.appointmentId,
    required this.addClincialNote,
    // required this.addRegisteration,
    this.button,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == 'registration') {
      return RegisterationButtons(
        type: type,
        role: role,
        // addRegisteration: addRegisteration,
        addClincialNote: addClincialNote,
      );
    } else if (type == 'appointment') {
      return AppointmentButtons(
        appointmentId: appointmentId,
        button: button!,
      );
      /*    return AppointmentButtons(
        appointmentId: appointmentId,
      ); */
    } else {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}

class RegisterationButtons extends StatelessWidget {
  final String type;
  final String role;
  final Function addClincialNote;
  // Function addRegisteration;
  const RegisterationButtons(
      {Key? key,
      required this.type,
      required this.role,
      required this.addClincialNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (role == 'DOCTOR') {
      return Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Button(
                height: 50,
                width: 130,
                setColor: true,
                blackColor: 152,
                greenColor: 155,
                redColor: 56,
                label: "Register",
                onPressed: () {
                  // var reponse = addRegisteration();
                }),
            Button(
                height: 50,
                width: 130,
                label: "Clinical Note",
                setColor: true,
                blackColor: 238,
                greenColor: 0,
                redColor: 98,
                onPressed: () {
                  addClincialNote();
                })
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Button(
                height: 50,
                width: 130,
                setColor: true,
                blackColor: 152,
                greenColor: 155,
                redColor: 56,
                label: "Register",
                onPressed: () {}),
          ],
        ),
      );
    }
  }
}

class AppointmentButtons extends StatelessWidget {
  final String appointmentId;
  final Widget button;

  const AppointmentButtons(
      {Key? key, required this.appointmentId, required this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Button(
            height: 50,
            width: 130,
            setColor: true,
            blackColor: 73,
            greenColor: 52,
            redColor: 222,
            label: "Cancel",
            onPressed: () {
              var response = context.read<AppointmentCubit>().cancelAppointment(
                    id: appointmentId,
                    token: context.read<LoginBloc>().state.homeToken,
                  );

              response.then((value) => {
                    if (value != null && value.statusCode == 200)
                      {
                        /*    Messages.showMessage(
                            const Icon(
                              IconData(0xf635, fontFamily: 'MaterialIcons'),
                              color: Colors.green,
                            ),
                            'Appointment cancelled'), */
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => const Appointments())),
                            ModalRoute.withName('/dashboard'))
                      }
                    else if (value != null && value.statusCode == 400)
                      {
                        /*    Messages.showMessage(
                            const Icon(
                              IconData(0xe237, fontFamily: 'MaterialIcons'),
                              color: Colors.red,
                            ),
                            'Could not cancel appointment'), */
                      }
                  });
            },
          ),
          button
        ],
      ),
    );
  }
}

//if is regiter do something