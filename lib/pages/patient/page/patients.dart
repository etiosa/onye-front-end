import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/button.dart';
import 'package:onye_front_ened/Widgets/pagination.dart';

import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/session/auth_session.dart';

import '../../../Widgets/generic_card.dart';
import '../../auth/state/login_bloc.dart';
import '../../registration/state/registration_cubit.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({Key? key}) : super(key: key);

  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  AuthSession authsession = AuthSession();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                  height: 50,
                  width: 200,
                  label: 'Create Patient',
                  onPressed: () => {
                    context.read<PatientCubit>().clearState(),
                        Navigator.of(context)
                            .pushNamed('/dashboard/registrationForm')
                      })
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20),
            child: Text("Search"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextFormField(
                  onChanged: (query) =>
                      context.read<PatientCubit>().setSearchQuery(query),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color.fromARGB(255, 205, 226, 226),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  onFieldSubmitted: (query) => {
                    authsession.getHomeToken()!.then((homeToken) {
                      if (homeToken != '') {
                        context.read<PatientCubit>().searchPatients(
                            query: query, token: homeToken, nextPage: 0);
                      }
                    })
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search query cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 80,
                height: 60,
                padding: const EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    autofocus: true,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 56, 155, 152)),
                    ),
                    child: const Text('Search'),
                    onPressed: () async {
                      authsession.getHomeToken()!.then((homeToken) {
                        if (homeToken != '') {
                          context.read<PatientCubit>().searchPatients(
                              query: context.read<PatientCubit>().state.query,
                              nextPage: 0,
                              token: homeToken);
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          const PatientList()
        ],
      ),
    ));
  }
}

//TODO: move this  to a widget foldder
class PatientList extends StatefulWidget {
  const PatientList({
    Key? key,
  }) : super();

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  int? initPageSelected = 0;

//TODO: reaplce the AppointmentCubit with PatientCubit
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(builder: (context, state) {
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

      return Column(
        children: [
          patientLists(state),
          // Pagination(initPageSelected: initPageSelected, searchType: 'Patient')
          Pagination(
            maxPageCounter: context.read<PatientCubit>().state.maxPageNumber,
            typeofSearch: 'patient',
          )
        ],
      );
    });
  }

  Widget patientLists(PatientState state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.7,
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
                  Navigator.pushNamed(
                      context, '/dashboard/patient/patientprofile');
                  context
                      .read<RegisterationCubit>()
                      .setSelectedMedicalPersonnelId(
                          context.read<LoginBloc>().state.id);
                },
                firstName: state.patientsList[index]['firstName'],
                lastName: state.patientsList[index]['lastName'],
                dateOfBirth: state.patientsList[index]['dateOfBirth'],
                patientNumber: state.patientsList[index]['patientNumber']);
          }),
    );
  }
}
