import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/appointment/state/appointment_cubit.dart';


 class DoctorList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  DoctorList({
    required this.pageController,
    Key? key,
  }) : super();
  PageController pageController;

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  int selectedIndex = -1;
  String selectedPatientId = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      if (state.doctorsList.isEmpty) {
        return (const Center(
          child: SizedBox(
            height: 70,
            width: 180,
            child: Card(
              margin: EdgeInsets.only(top: 10),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('No Doctor found'),
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
            itemCount: state.doctorsList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedPatientId = state.doctorsList[index]['id'];

                    context
                        .read<AppointmentCubit>()
                        .setSelectedMedicalPersonnelId(selectedPatientId);
                    selectedIndex = index;
                    widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
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
                          '  ${state.doctorsList[index]['firstName']} ${state.doctorsList[index]['middleName'] ?? ''} ${state.doctorsList[index]['lastName']}',
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
                            const Text('personnel number'),
                            Text(
                              '  ${state.doctorsList[index]['personnelNumber']} ',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('phone number'),
                            Text(
                              '  ${state.doctorsList[index]['phoneNumber']} ',
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
 