import 'package:flutter/material.dart';
class PatientDetails extends StatelessWidget {
  const PatientDetails({
    this.dateOfBirth,
    required this.patientFullName,
    required this.patientNumber,
    required this.patientId,
    Key? key,
  }) : super(key: key);

  final String patientFullName;
  final String? dateOfBirth;
  final String patientNumber;
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => {
          /*   Navigator.of(context).pushNamed('/dashboard/patient/patientprofile') */
        },
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 1.05,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position
            ), //BoxShadow
          ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        patientFullName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(dateOfBirth ?? '')
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Patient number'),
                      const SizedBox(height: 20),
                      Text(patientNumber)
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
