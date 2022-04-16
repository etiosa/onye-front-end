import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/Widgets/Button.dart';

import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';
import 'package:onye_front_ened/components/util/functions.dart';

import '../../../components/PatientDetails.dart';
import '../../appointment/state/appointment_cubit.dart';
import '../../auth/state/login_cubit.dart';

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
               Button(height: 50, width: 200, label: 'Create Patient', onPressed: ()=>Navigator.of(context)
                          .pushNamed('/dashboard/registrationForm'))
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
                        context
                            .read<AppointmentCubit>()
                            .searchPatients(query: query, token: homeToken);
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
                          //TODO: REMOVE SearchPatientds into cubit
                          context.read<AppointmentCubit>().searchPatients(
                              query: context.read<PatientCubit>().state.query,
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

      return patientLists(state);
    });
  }

  Widget patientLists(AppointmentState state) {
    const int heightOffset = 300;

    return SizedBox(
      height: MediaQuery.of(context).size.height - heightOffset,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemCount: state.patientsList.length,
                itemBuilder: (BuildContext context, index) {
                  return Stack(alignment: Alignment.topRight, children: [
                    PatientDetails(
                      patientId: state.patientsList[index]['id'],
                      patientFullName: Functions.buildFullName(
                        state.patientsList[index]['firstName'],
                        state.patientsList[index]['middleName'],
                        state.patientsList[index]['lastName'],
                      ),
                      dateOfBirth: state.patientsList[index]['dateOfBirth'],
                      patientNumber: state.patientsList[index]['patientNumber'],
                    ),
                  ]);
                }),
          ),
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var index = 0;
                  index < context.read<AppointmentCubit>().state.maxPageNumber;
                  index++)
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        initPageSelected = index;
                      });

                      context.read<AppointmentCubit>().setPatientNextSearchIndex(
                          nextPage: index,
                          token: context.read<LoginCubit>().state.homeToken,
                          searchParams: context
                              .read<AppointmentCubit>()
                              .state
                              .searchParams);
                    },
                    child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: initPageSelected == index
                                ? const Color.fromARGB(255, 56, 155, 152)
                                 :Colors.transparent,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text(
                          "${index + 1}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: initPageSelected == index
                                   ?Colors.white
                                  : const Color.fromARGB(255, 56, 155, 152)),
                        ))),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
