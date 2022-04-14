 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/appointment/state/appointment_cubit.dart';
 
 class PatientList extends StatefulWidget {
  PatientList({
    required this.pageController,
    Key? key,
  }) : super();
  PageController pageController;

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  int selectedIndex = -1;
  String selectedPatientId = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      if (state.patientsList.isEmpty) {
        return (const Center(
          child: SizedBox(
            height: 70,
            width: 180,
            child: Card(
              margin: EdgeInsets.only(top: 10),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('No patient found'),
              ),
            ),
          ),
        ));
      }
      return Expanded(
        flex: 1,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemCount: state.patientsList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedPatientId = state.patientsList[index]['id'];

                    context
                        .read<AppointmentCubit>()
                        .setPatientId(selectedPatientId);
                    selectedIndex = index;
                    widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  });
                },
                child: Container(
                  width: 50,
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? const Color.fromARGB(255, 26, 155, 152)
                        : const Color.fromARGB(255, 248, 254, 254),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  ${state.patientsList[index]['firstName']} ${state.patientsList[index]['middleName'] ?? ''} ${state.patientsList[index]['lastName']}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('patient number'),
                            Text(
                              '  ${state.patientsList[index]['patientNumber']} ',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('phone number'),
                            Text(
                              '  ${state.patientsList[index]['phoneNumber']} ',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
 