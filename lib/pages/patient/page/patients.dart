import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';

import '../../appointment/state/appointment_cubit.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 30),
                  height: 50,
                  width: 200,
                  color: const Color.fromARGB(255, 56, 155, 152),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 56, 155, 152)),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/dashboard/registrationForm');
                      },
                      child: const Text('Create Patient')),
                )
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
      ),
    ));
  }
}



class PatientDetails extends StatelessWidget {
  const PatientDetails({
    required this.dateofBirth,
    required this.patientFullName,
    required this.patientNumber,
    required this.patientId,
    Key? key,
  }) : super(key: key);

  final String patientFullName;
  final String dateofBirth;
  final String patientNumber;
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ()=> {
              Navigator.of(context).pushNamed('/dashboard/patient/patientprofile')
        },
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 1.05,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes positi
            ), //BoxShadow
          ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        patientFullName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(dateofBirth)
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Patient number'),
                      const SizedBox(height: 20),
                      Text(patientNumber)
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class PatientInformation extends StatelessWidget {
  const PatientInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
        
          children: [
              const Text('Paitent Information'),
           const  Divider(color: Colors.amber, thickness: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  Text('Patient First Name'),
                    Text('Patient First Name')
              ],),
            Row(
              
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  Text('Etiosa '),
                    Text('Obasuyi')
              ],),
               
          ],
        ),
      ),
    );
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

      return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemCount: state.patientsList.length,
          itemBuilder: (BuildContext context, index) {
            return Stack(alignment: Alignment.topRight, children: [
              PatientDetails(
                patientId: state.patientsList[index]['id'],
                patientFullName: state.patientsList[index]['firstName'] +
                    state.patientsList[index]['lastName'],
                dateofBirth: state.patientsList[index]['dateOfBirth'],
                patientNumber: state.patientsList[index]['patientNumber'],
              ),
            ]);
          });
    });
  }
}
