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
    this.middleName = '',
    required this.patientNumber,
    this.imageURl = '',
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
            RegisterationButtons(
              type: type,
              role: role,
              addClincialNote: clinicalNote,
              addRegisteration: addRegisteration,
            )
          ])),
    );
  }
}

class RegisterationButtons extends StatelessWidget {
  final String type;
  final String role;
  Function addClincialNote;
  Function addRegisteration;
  RegisterationButtons({
    Key? key,
    required this.type,
    required this.role,
    required this.addClincialNote,
    required this.addRegisteration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (role == 'DOCTOR') {
      return Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RegisterButton(
              addRegisteration: addRegisteration,
              type: type,
            ),
            ClinicalNoteButton(
              addClincialNote: addClincialNote,
              type: type,
              role: role,
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              RegisterButton(
              addRegisteration: addRegisteration,
              type: type,
            ),
          ],
        ),
      );
    }
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required this.type,
    required this.addRegisteration,
  }) : super(key: key);
  final String type;

  final Function addRegisteration;

  @override
  Widget build(BuildContext context) {
    bool isregister = type == 'registration';
    return Button(
        height: 50,
        width: 130,
        setColor: true,
        blackColor: 152,
        greenColor: 155,
        redColor: 56,
        isregsiter: isregister,
        label: "Register",
        onPressed: () {
          var reponse = addRegisteration();
          //print(reponse);
        });
  }
}

class ClinicalNoteButton extends StatelessWidget {
  const ClinicalNoteButton({
    Key? key,
    required this.type,
    required this.role,
    required this.addClincialNote,
  }) : super(key: key);

  final String type;
  final String role;
  final Function addClincialNote;

  @override
  Widget build(BuildContext context) {
    if (role == 'DOCTOR' && type == 'registration') {
      return Button(
          height: 50,
          width: 130,
          label: "Clinical Note",
          setColor: true,
          blackColor: 238,
          greenColor: 0,
          redColor: 98,
          onPressed: () {
            addClincialNote();
          });
    } else {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
