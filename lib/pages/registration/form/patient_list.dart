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
        height: MediaQuery.of(context).size.height / 1.8,
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
      
    });
  }
}
