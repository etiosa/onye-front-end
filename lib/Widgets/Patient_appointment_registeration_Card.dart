import 'package:flutter/material.dart';

class PatientAppointmentRegistrationCard extends StatelessWidget {
  const PatientAppointmentRegistrationCard({
    Key? key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.patientNumber,
    required this.date,
    required this.time,
  }) : super(key: key);

  final String firstName;
  final String middleName;
  final String lastName;
  final String patientNumber;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$firstName $middleName $lastName',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'poppins'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      patientNumber,
                      style: const TextStyle(
                          color: Color.fromARGB(
                            255,
                            129,
                            150,
                            150,
                          ),
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                  backgroundColor: Colors.amberAccent, maxRadius: 40)
            ],
          ),
        ),
        Container(
          color: const Color.fromARGB(255, 67, 184, 184),
          height: 5,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month,
                      color: Color.fromARGB(255, 74, 73, 73)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 15,
                        color: Color.fromARGB(255, 129, 150, 150)),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      color: Color.fromARGB(255, 74, 73, 73)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(time,
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 15,
                          color: Color.fromARGB(255, 129, 150, 150))),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
