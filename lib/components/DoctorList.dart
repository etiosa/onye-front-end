import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/Pagination.dart';
import 'package:onye_front_ened/Widgets/PatientCard.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';

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
      return Column(
        children: [
          DoctorLists(
            widget: widget,
            state: state,
          ),
           Pagination(
            initPageSelected: 0,
            searchType: 'Patient',
          ) 
        ],
      );

    });
  }
}

class DoctorLists extends StatelessWidget {
  DoctorLists({Key? key, required this.widget, required this.state})
      : super(key: key);

  var state;
  final DoctorList widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.8,
      width: MediaQuery.of(context).size.width < 600 ? double.infinity : 600,
      child: ListView.builder(
          // shrinkWrap: true,

          itemCount: state.doctorsList.length,
          itemBuilder: (BuildContext context, index) {
            print(index);
            return PatientCard(
                onTap: () {
                  context
                      .read<AppointmentCubit>()
                      .setPatientId(state.patientsList[index]['id']);
                  widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                  context
                      .read<AppointmentCubit>()
                      .setSelectedMedicalPersonnelId(
                          context.read<LoginCubit>().state.id);
                },
                firstName: state.doctorsList[index]['firstName'],
                lastName: state.doctorsList[index]['lastName'],
                dateOfBirth: state.doctorsList[index]['specialty'],
                patientNumber: state.doctorsList[index]['personnelNumber']);
          }),
    );
  }
}
