import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
import 'package:onye_front_ened/Widgets/Loading.dart';
import 'package:onye_front_ened/Widgets/RegisterationCard.dart';
import 'package:onye_front_ened/components/clinicalNote/clinicalnote_cubit.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';

import '../../../Widgets/HomepageHeader.dart';
import '../../../Widgets/Pagination.dart';
import '../../../components/clinicalNote/ClinicalNoteDropDown.dart';
import '../../../components/clinicalNote/ClinicalNoteField.dart';
import '../../../components/clinicalNote/ClinicalNoteTitleField .dart';
import '../../../components/util/Messages.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<LoginCubit>().state.homeToken.isEmpty) {
      //redirect to home
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/login");
      });
    }
    if (context.read<LoginCubit>().state.homeToken.isNotEmpty) {
      context.read<RegisterationCubit>().searchRegistrations(
          token: context.read<LoginCubit>().state.homeToken,
          searchParams: context.read<AppointmentCubit>().state.searchParams);
    }
  }

  int? initPageSelected = 0;

  @override
  Widget build(BuildContext context) {
    final fieldText = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: HomepageHeader(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10),
              child: Text("Search",
                  style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 10, bottom: 20),
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: 550, maxHeight: 40),
                  child: TextFormField(
                    controller: fieldText,
                    onChanged: (search) => context
                        .read<RegisterationCubit>()
                        .setSearchParams(search),
                    obscureText: false,
                    autofocus: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 205, 226, 226),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid query';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ),
            Button(
                height: 50,
                width: 100,
                label: "Search",
                onPressed: () {
                  context.read<RegisterationCubit>().searchRegistrations(
                      token: context.read<LoginCubit>().state.homeToken,
                      searchParams: context
                          .read<RegisterationCubit>()
                          .state
                          .searchParams);
                  fieldText.clear();
                }),
            registrationBody(),
          ],
        ),
      ),
    );
  }

  //
//TODO: move the pagination to the main scafolding bottom of the page
  Widget registrationBody() {
    return BlocBuilder<RegisterationCubit, RegistrationState>(
      builder: (context, state) {
        return Column(
          children: const [Appointment()],
        );
      },
    );
  }
}

//TODO: change  use the regisetrationCubit here
class Appointment extends StatefulWidget {
  const Appointment({
    Key? key,
  }) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var dateFormat = DateFormat('MM/dd/yyyy hh:mm a');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterationCubit, RegistrationState>(
      builder: (context, state) {
        if (state.searchState == SEARCHSTATE.notFound) {
          return (const Center(
              child: Card(
            child: Text('Not found'),
          )));
        }

        if (state.registrationList.isEmpty) {
          return const Loading();
        } else {
          //need to move it to won container

          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width < 600
                  ? double.infinity
                  : 600,
              child: ListView.builder(
                  itemCount: state.registrationList.length,
                  itemBuilder: ((context, index) {
                    if (state.registrationList[index]['type'] ==
                        'registration') {
                      return RegisterationCard(
                        addRegisteration: () => {
                          createRegistration(
                              token: context.read<LoginCubit>().state.homeToken,
                              patientId: state.registrationList[index]
                                  ['patient']['id'],
                              medicalPersonnelId: state.registrationList[index]
                                  ['medicalPersonnel']['id'],
                              appointmentId: state.registrationList[index]
                                  ['id'],
                              reasons: state.registrationList[index]
                                  ['reasonForVisit'],
                              typeofVist: state.registrationList[index]
                                  ['typeOfVisit'],
                              context: context)
                        },
                        clinicalNote: () => {
                          showDialogConfirmation(
                              context, state.registrationList[index])
                        },
                        firstName: state.registrationList[index]['patient']
                            ['firstName'],
                        lastName: state.registrationList[index]['patient']
                            ['lastName'],
                        type: state.registrationList[index]['type'],
                        dateTime: state.registrationList[index]['dateTime'],
                        patientNumber: state.registrationList[index]['patient']
                            ['patientNumber'],
                        role: context.read<LoginCubit>().state.role,
                        appointmentId: state.registrationList[index]['id'],
                      );
                    } else {
                      return const SizedBox(
                        height: 0,
                        width: 0,
                      );
                    }
                  })),
            ),
          );

          /*  
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      (state.registrationList[index]
                                              .containsKey('dateTime'))
                                          ? dateFormat.format(DateTime.parse(
                                              state.registrationList[index]
                                                  ['dateTime']))
                                          : dateFormat.format(DateTime.parse(
                                              state.registrationList[index]
                                                  ['registrationDateTime'])),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                       
                            
                            RegisterPatient(
                              registrationList: state.registrationList,
                              selectedIndex: index,
                            ),
                          ],
                        ), 
                      ]),
                    ),
                  );
                }),
          ); */
        }
      },
    );
  }
}

class RegisterationList extends StatelessWidget {
  final String type;
  const RegisterationList({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// ignore: must_be_immutable
class AppointmentConfirmed extends StatelessWidget {
  AppointmentConfirmed({
    required this.appointmentList,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);
  List<dynamic> appointmentList;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (appointmentList[selectedIndex]['type'] == 'registration') {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else {
      return const Icon(
        Icons.check_circle,
        color: Colors.transparent,
      );
    }
  }
}

/*TODO:Move this to ClinicalNote */

Future<String?> showDialogConfirmation(
    BuildContext context, dynamic appointment) {
  print("test");

  final _patientName = appointment['patient']['firstName'] +
      ' ' +
      appointment['patient']['lastName'];
  final clincialNoteid = appointment['clinicalNoteId'];
  final AuthSession authsession = AuthSession();

  var hometoken;
  authsession.getHomeToken()?.then((value) => {
        hometoken = value,
        if (appointment.containsKey('clinicalNoteId'))
          {
            context
                .read<ClinicalnoteCubit>()
                .getPatientClinicalNote(id: clincialNoteid, token: hometoken)
          }
      });

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: const Text('Add clinical Note'),
      actions:
          clinicalNoteForm(appointment, _patientName, context, '', hometoken),
    ),
  );
}

List<Widget> clinicalNoteForm(
    appointment, _patientName, BuildContext context, String? note, homeToken) {
  return <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClinicalNoteDropDown(
            label: 'Note Type',
            registration: appointment,
            options: const [
              'CONSULTATION_NOTE',
              'DISCHARGE_SUMMARY_NOTE',
              'PROCEDURE_NOTE',
              'PROGRESS_NOTE',
            ]),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            "Patient",
            style: TextStyle(
              color: Color.fromARGB(255, 56, 155, 152),
            ),
          ),
        ),
        TextFormField(
          readOnly: true,
          initialValue: _patientName,
          onChanged: (username) =>
              context.read<LoginCubit>().setUserName(username),
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 205, 226, 226),
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
    ClinicalNoteTitleField(
      appointment: appointment,
    ),
    ClinicalNoteField(
      appointment: appointment,
    ),
    const SizedBox(height: 20),
    Row(
      children: [
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Cancel'),
            context.read<ClinicalnoteCubit>().clearClinicalNoteState()
          },
          child: const Text('Cancel'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              if (appointment.containsKey('clinicalNoteId')) {
                var response = updateClinicalNoteData(
                    clinicalNoteId: appointment['clinicalNoteId'],
                    homeToken: homeToken,
                    context: context);
                      response!.then((value) => {
                      if (value != null && value.statusCode == 202)
                        {
                          Messages.showMessage(
                              const Icon(
                                IconData(0xf635, fontFamily: 'MaterialIcons'),
                                color: Colors.green,
                              ),
                              'Clinical Note updated'),
                          //clearState after update
                          context
                              .read<ClinicalnoteCubit>()
                              .clearClinicalNoteState(),
                          context
                              .read<ClinicalnoteCubit>()
                              .getPatientClinicalNote(
                                  token: homeToken,
                                  id: appointment['clinicalNoteId']),
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: ((context) => const Registration())),
                              ModalRoute.withName('/dashboard'))
                        }
                      else if (value != null && value.statusCode == 400)
                        {
                          Messages.showMessage(
                              const Icon(
                                IconData(0xe237, fontFamily: 'MaterialIcons'),
                                color: Colors.red,
                              ),
                              'Could not update Clinical Note'),
                        }
                    });
              } else {
                var response = createClinicalNoteData(
                    homeToken: homeToken,
                    registerationId: appointment['id'],
                    medicalPersonnelId: context.read<LoginCubit>().state.id,
                    note: context.read<ClinicalnoteCubit>().state.text,
                    noteTitle: context.read<ClinicalnoteCubit>().state.title,
                    clinicalNoteType:
                        context.read<ClinicalnoteCubit>().state.type,
                    context: context,
                    patientId: appointment['patient']['id']);

                response!.then((value) => {
                      if (value != null && value.statusCode == 201)
                        {
                          context
                              .read<ClinicalnoteCubit>()
                              .clearClinicalNoteState(),
                          Messages.showMessage(
                              const Icon(
                                IconData(0xf635, fontFamily: 'MaterialIcons'),
                                color: Colors.green,
                              ),
                              'Clinical Note created'),
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: ((context) => const Registration())),
                              ModalRoute.withName('/dashboard'))
                        }
                      else if (value != null && value.statusCode == 400)
                        {
                          Messages.showMessage(
                              const Icon(
                                IconData(0xe237, fontFamily: 'MaterialIcons'),
                                color: Colors.red,
                              ),
                              'Could not create Clinical Note'),
                        }
                    });
              }
            },
            child: Text(
                appointment.containsKey('clinicalNoteId') ? 'save' : 'add')),
      ],
    ),
  ];
}

//TODO:ClinicalNote Function moved to ClinicalNote component
Future<Response?>? updateClinicalNoteData(
    {required BuildContext context,
    required String homeToken,
    required String clinicalNoteId}) {
  var response = context.read<ClinicalnoteCubit>().updateClinicalNote(
        token: homeToken,
        id: clinicalNoteId,
        type: context.read<ClinicalnoteCubit>().state.type,
        noteText: context.read<ClinicalnoteCubit>().state.text,
        title: context.read<ClinicalnoteCubit>().state.title,
      );
  return response;
}

Future<Response?>? createClinicalNoteData(
    {required String homeToken,
    required String registerationId,
    required String medicalPersonnelId,
    required String note,
    required String noteTitle,
    required String clinicalNoteType,
    required String patientId,
    required BuildContext context}) {
  var response = context.read<ClinicalnoteCubit>().createClinicalNote(
      token: homeToken,
      registrationId: registerationId,
      medicalId: medicalPersonnelId,
      note: note,
      title: noteTitle,
      clinicalNoteType: clinicalNoteType,
      patientId: patientId);
  return response;
}

// ignore: must_be_immutable
class RegisterPatient extends StatefulWidget {
  RegisterPatient(
      {Key? key, required this.registrationList, required this.selectedIndex})
      : super(key: key);

  List<dynamic> registrationList;
  int selectedIndex;

  @override
  State<RegisterPatient> createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  late final String token = context.read<LoginCubit>().state.homeToken;

  late final String patientId =
      widget.registrationList[widget.selectedIndex]['patient']['id'];
  late final String medicalPersonnelId =
      widget.registrationList[widget.selectedIndex]['medicalPersonnel']['id'];
  late final String appointmentId =
      widget.registrationList[widget.selectedIndex]['id'];
  late final String reasons =
      widget.registrationList[widget.selectedIndex]['reasonForVisit'];
  late final String typeofVist =
      widget.registrationList[widget.selectedIndex]['typeOfVisit'];
  @override
  Widget build(BuildContext context) {
    if (widget.registrationList[widget.selectedIndex]['type'] ==
        'registration') {
      return const Padding(
          padding: EdgeInsets.all(10.0), child: Text("add clincical note"));

      /*  Confirmation(
            appointmentList: widget.registrationList,
            selectedIndex: widget.selectedIndex,
          )); */
    }

    return Button(
        height: 30,
        width: 120,
        label: 'Register',
        onPressed: () => {
              createRegistration(
                  appointmentId: appointmentId,
                  token: token,
                  medicalPersonnelId: medicalPersonnelId,
                  reasons: reasons,
                  typeofVist: typeofVist,
                  context: context,
                  patientId: patientId)
            });
  }
}

Future<Response?> createRegistration(
    {required String token,
    required String patientId,
    required String medicalPersonnelId,
    required String appointmentId,
    required String reasons,
    required String typeofVist,
    required BuildContext context}) {
  var reponse = context.read<RegisterationCubit>().createRegistration(
      token: token,
      patientID: patientId,
      medicalId: medicalPersonnelId,
      appointmentId: appointmentId,
      reasons: reasons,
      typeOfVisit: typeofVist);
  return reponse;
}
