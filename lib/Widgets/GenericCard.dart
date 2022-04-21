// ignore: file_names
import 'package:flutter/material.dart';

class GenericCard extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  String?middleName;
  final String? patientNumber;
  final String? imageURl;
  Function? onTap;

  GenericCard({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.patientNumber,
    this.imageURl = '',
    this.middleName = '',
    required this.onTap,
    Key? key,
  }) : super(key: key) {
    if (middleName!.isEmpty || middleName == '') {
      middleName = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() {
          onTap!();
        }),
        child: Container(
            height: 178,
            width:
                MediaQuery.of(context).size.width < 600 ? double.infinity : 600,
            color: const Color.fromARGB(255, 236, 246, 246),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$firstName $middleName $lastName',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'poppins'),
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
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        "Date of Birth",
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 15,
                            color: Color.fromARGB(255, 129, 150, 150)),
                      ),
                      Text("Patient Number",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 15,
                              color: Color.fromARGB(255, 129, 150, 150)))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 60.0),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month,
                              color: Color.fromARGB(255, 74, 73, 73)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(dateOfBirth!,
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 74, 73, 73))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Text(patientNumber!,
                          style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 15,
                              color: Color.fromARGB(255, 74, 73, 73))),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
