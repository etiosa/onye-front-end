import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../components/util/Modal.dart';
import '../pages/appointment/state/appointment_cubit.dart';
import '../pages/appointments.dart';
import '../pages/auth/state/login_bloc.dart';
import 'Button.dart';
import 'Patient_appointment_registeration_Card.dart';

//Wil have the

class AppointmentCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String dateTime;
  final String middleName;
  final String patientNumber;
  final String imageURl;
  final String type;
  final String role;
  final String appointmentId;
  final Widget button;
  const AppointmentCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.dateTime,
    this.middleName = '',
    required this.patientNumber,
    this.imageURl = '',
    required this.type,
    required this.role,
    required this.appointmentId,
    required this.button,
  }) : super(key: key);

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
          child: Column(children: [
            PatientAppointmentRegistrationCard(
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                patientNumber: patientNumber,
                date: date,
                time: time),
            AppointmentButtons(
              appointmentId: appointmentId,
              button: button,
            )
          ])),
    );
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
              //TODO: update here blocListner
              Modal(
                  context: context,
                  modalType: 'Unkown',
                  inclueAction: true,
                  actionButtons: TextButton(
                      onPressed: () {
                        //TODO:  move this it's own method
                        var response = context
                            .read<AppointmentCubit>()
                            .cancelAppointment(
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
                                          builder: ((context) =>
                                              const Appointments())),
                                      ModalRoute.withName('/dashboard'))
                                }
                              else if (value != null && value.statusCode == 400)
                                {
                                  /*  Messages.showMessage(
                            const Icon(
                              IconData(0xe237, fontFamily: 'MaterialIcons'),
                              color: Colors.red,
                            ),
                            'Could not cancel appointment'), */
                                }
                            });
                        Navigator.pop(context, false);
                      },
                      child: const Text("Cancel Appointment")),
                  modalBody:
                      const Text('Do you want to cancel the appointment?'),
                  progressDetails: 'Do you want to cancel the appointment?');
            },
          ),
          // button
          button
        ],
      ),
    );
  }
}
