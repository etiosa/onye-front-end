import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/generic_card.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/pages/doctor/state/doctor_cubit_cubit.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';

import '../pages/appointment/state/appointment_cubit.dart';
import '../pages/patient/state/patient_cubit.dart';

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
    return BlocBuilder<PatientCubit, PatientState>(
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

      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.8,
        width: MediaQuery.of(context).size.width < 600 ? double.infinity : 600,
        child: ListView.builder(
            // shrinkWrap: true,

            itemCount: state.patientsList.length,
            itemBuilder: (BuildContext context, index) {
              return GenericCard(
                  onTap: () {
                    context
                        .read<PatientCubit>()
                        .setPatientId(state.patientsList[index]['id']);
                          widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    context
                        .read<DoctorCubit>()
                        .setSelectedMedicalPersonnelId(
                            context.read<LoginBloc>().state.id);
                  },
                  firstName: state.patientsList[index]['firstName'],
                  lastName: state.patientsList[index]['lastName'],
                  dateOfBirth: state.patientsList[index]['dateOfBirth'],
                  patientNumber: state.patientsList[index]['patientNumber']);
            }),
      );
    });
  }
}
 


