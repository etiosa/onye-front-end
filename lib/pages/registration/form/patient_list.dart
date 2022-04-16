import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/PatientCard.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';

import '../../appointment/state/appointment_cubit.dart';

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
    return BlocBuilder<RegisterationCubit, RegistrationState>(
        builder: (context, state) {
      if (state.patientList.isEmpty) {
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
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width < 600 ? double.infinity : 600,
        child: ListView.builder(
            // shrinkWrap: true,

            itemCount: state.patientList.length,
            itemBuilder: (BuildContext context, index) {
              return PatientCard(
                  onTap: () {
                    widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    context
                        .read<RegisterationCubit>()
                        .setPatientId(state.patientList[index]['id']);
                    context
                        .read<RegisterationCubit>()
                        .setSelectedMedicalPersonnelId(context.read<LoginCubit>().state.id);
                  },
                  firstName: state.patientList[index]['firstName'],
                  lastName: state.patientList[index]['lastName'],
                  dateOfBirth: state.patientList[index]['dateOfBirth'],
                  patientNumber: state.patientList[index]['patientNumber']);
            }),
      );
      /*  return Expanded(
        dateOfBirth
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
      ); */
    });
  }
}
