
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Patient_appointment_registeration_Card.dart';

import 'Button.dart';

//Wil have the

class RegisterationCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String dateTime;
   String middleName;
  final String patientNumber;
  final String imageURl;
  final String type;
  final String role;
  final String appointmentId;
  final Widget? button;
  Function clinicalNote;
  Function addRegisteration;
  RegisterationCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.dateTime,
     this.middleName='',
    required this.patientNumber,
     this.imageURl='',
    required this.type,
    required this.role,
    required this.appointmentId,
    this.button,
    required this.clinicalNote,
    required this.addRegisteration,
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
RegisterationButtons(type: type, role: role, addClincialNote: clinicalNote)

          ])),
    );
  }
}


class RegisterationButtons extends StatelessWidget {
  final String type;
  final String role;
  Function addClincialNote;
  // Function addRegisteration;
  RegisterationButtons(
      {Key? key,
      required this.type,
      required this.role,
      required this.addClincialNote
      // required this.addRegisteration,
      })
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
                  //print(reponse);
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
