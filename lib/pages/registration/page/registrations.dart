import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
import 'package:onye_front_ened/Widgets/GenericLoadingContainer.dart';
import 'package:onye_front_ened/Widgets/RegisterationCard.dart';
import 'package:onye_front_ened/components/Date.dart';
import 'package:onye_front_ened/components/Time.dart';
import 'package:onye_front_ened/components/clinicalNote/clinicalnote_cubit.dart';
import 'package:onye_front_ened/components/util/Modal.dart';
import 'package:onye_front_ened/pages/auth/repository/auth_repositories.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/pages/registration/state/registration_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';

import '../../../Widgets/HomepageHeader.dart';
import '../../../Widgets/Pagination.dart';
import '../../../components/clinicalNote/ClinicalNoteDropDown.dart';
import '../../../components/clinicalNote/ClinicalNoteField.dart';
import '../../../components/clinicalNote/ClinicalNoteTitleField .dart';

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

    final AuthSession authsession = AuthSession();

    var hometoken;
    if (context.read<LoginBloc>().state.loginStatus != LoginStatus.home) {
      final AuthRepository _authRepository = AuthRepository();
      final LoginBloc _loginbloc = LoginBloc(_authRepository);
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        //  Navigator.of(context).pop();
        authsession.getHomeToken()?.then((value) async {
          hometoken = value;
          var res = _loginbloc.home(homeToken: value);
          res.then((res) {
            if (res.statusCode != 200) {
              Modal(
                  inclueAction: true,
                  actionButtons: TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                        Navigator.of(context).pushNamed("/login");
                      }),
                  context: context,
                  modalType: 'failed',
                  modalBody: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        height: 40,
                      ),
                      Text('Token expires, relogin'),
                      SizedBox(height: 20),
                      Icon(
                        Icons.error,
                        color: Colors.redAccent,
                        size: 100,
                      )
                    ],
                  ),
                  progressDetails: 'relogin');
            } else {
              context.read<RegisterationCubit>().searchRegistrations(
                  nextPage: 0,
                  token: value,
                  searchParams:
                      context.read<RegisterationCubit>().state.searchParams);
            }
          });
        });
      });
    }
  }

  int? initPageSelected = 0;

  @override
  Widget build(BuildContext context) {
    final fieldText = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: HomepageHeader(),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 300.0, top: 10),
                  child: Text("Search",
                      style:
                          TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 420, maxHeight: 35),
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
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 15, top: 15),
                  child: Text(
                    " Start Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text("Time"),
                        ),
                        Time(
                          rangeLabel: 'start',
                          type: 'registeration',
                        ),
                      ],
                    ),
                    Date(
                      rangeDate: 'start',
                      type: 'registeration',
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 15, top: 15),
                  child: Text(
                    "End Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text("Time"),
                        ),
                        Time(
                          rangeLabel: 'end',
                          type: 'registeration',
                        ),
                      ],
                    ),
                    Date(
                      rangeDate: 'end',
                      type: 'registeration',
                    ),
                  ],
                ),
                Center(
                  child: Button(
                      height: 50,
                      width: 100,
                      label: "Search",
                      onPressed: () {
                        searchDateTimeFilter(
                          context: context,
                          startDate: context
                              .read<RegisterationCubit>()
                              .state
                              .registrationStartDate,
                          startTime: context
                              .read<RegisterationCubit>()
                              .state
                              .registrationStartTime,
                          endDate: context
                              .read<RegisterationCubit>()
                              .state
                              .registrationEndDate,
                          endTime: context
                              .read<RegisterationCubit>()
                              .state
                              .registrationEndTime,
                        );
                        fieldText.clear();
                      }),
                ),
              ],
            ),
            //registrationBody(),
            const Body(),
            const Footer()
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterationCubit, RegistrationState>(
      builder: (context, state) {
        return const Appointment();
      },
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterationCubit, RegistrationState>(
      builder: (context, state) {
        return Pagination(
          maxPageCounter:
              context.read<RegisterationCubit>().state.maxPageNumber,
          typeofSearch: 'registration',
        );
      },
    );
  }
}

void searchDateTimeFilter({
  required BuildContext context,
  String? startDate,
  String? startTime,
  String? endDate,
  String? endTime,
}) {
  DateTime? startdateTime;
  DateTime? enddateTime;
  if (startDate!.trim() != '' && startTime!.trim() != '') {
    startdateTime = DateFormat('yyyy-MM-dd h:mm aa')
        .parse(startDate + " " + startTime, true);
  }
  if (endDate!.trim() != '' && endTime!.trim() != '') {
    enddateTime =
        DateFormat('yyyy-MM-dd h:mm aa').parse(endDate + " " + endTime);
  }

  context.read<RegisterationCubit>().searchRegistrations(
      token: context.read<LoginBloc>().state.homeToken,
      startDateTime: startdateTime?.toIso8601String(),
      endDateTime: enddateTime?.toIso8601String(),
      searchParams: context.read<RegisterationCubit>().state.searchParams);
}

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
    return BlocListener<RegisterationCubit, RegistrationState>(
      listener: (context, state) {
        if (state.registerState == REGISTRATIONSTATE.failed) {
          Modal(
              inclueAction: true,
              actionButtons: TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                    Navigator.of(context, rootNavigator: true).pop(true);
                    context.read<RegisterationCubit>().setRegisterState();
                  }),
              context: context,
              modalType: 'failed',
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(state.registrationError),
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.error,
                    color: Colors.redAccent,
                    size: 100,
                  )
                ],
              ),
              progressDetails: state.registrationError);
        }
        if (state.registerState == REGISTRATIONSTATE.inprogress) {
          Modal(
              context: context,
              modalType: '',
              inclueAction: false,
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Registering In Progress'),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.grey[500],
                        strokeWidth: 4,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 56, 155, 152)),
                      )),
                ],
              ),
              progressDetails: 'Registering In Progress');
        }
        if (state.registerState == REGISTRATIONSTATE.sucessful) {
          Modal(
              context: context,
              modalType: '',
              inclueAction: true,
              actionButtons: TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                    Navigator.of(context, rootNavigator: true).pop(true);
                    context.read<RegisterationCubit>().setRegisterState();
                  }),
              modalBody: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text('Sucessful register a patient'),
                  SizedBox(height: 30),
                  Icon(
                    Icons.check,
                    size: 100,
                    color: Color.fromARGB(255, 56, 155, 152),
                  )
                ],
              ),
              progressDetails: 'Sucessful register a patient');
        }
      },
      child: BlocBuilder<RegisterationCubit, RegistrationState>(
        builder: (context, state) {
          if (state.registerstateload == REGISTERSTATELOAD.failed) {
            return const Center(
              child: Text("No result, please try again"),
            );
          }

          if (state.registerstateload == REGISTERSTATELOAD.loading) {
            return Column(
              children: [
                for (var index = 0; index <= 20; index++)
                  const GenericLoadingContainer(height: 100, width: 500),
              ],
            );
          }
          if (state.registerstateload == REGISTERSTATELOAD.loaded) {
            return Column(
              children: [
                for (var index = 0;
                    index <= state.registrationList.length - 1;
                    index++)
                  RegisterList(
                    index: index,
                    state: state,
                  )
              ],
            );
          }
          return Column(
            children: [
              for (var index = 0; index <= 20; index++)
                const GenericLoadingContainer(height: 100, width: 500),
            ],
          );
        },
      ),
    );
  }
}

class RegistersList extends StatelessWidget {
  final dynamic state;
  const RegistersList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          for (var index = 0;
              index <= state.registrationList.length - 1;
              index++)
            RegisterationCard(
              key: Key(state.registrationList[index]['id']),
              addRegisteration: () => {
                Modal(
                    context: context,
                    modalType: 'Unkown',
                    inclueAction: true,
                    actionButtons: RegisterButton(
                      state: state,
                      index: index,
                    ),
                    modalBody:
                        const Text('Do you want to register this patient?'),
                    progressDetails: 'Do you want to register this patient?'),
              },
              clinicalNote: () => {
                showDialogConfirmation(context, state.registrationList[index])
              },
              firstName: state.registrationList[index]['patient']['firstName'],
              lastName: state.registrationList[index]['patient']['lastName'],
              type: state.registrationList[index]['type'],
              dateTime: state.registrationList[index]['dateTime'],
              patientNumber: state.registrationList[index]['patient']
                  ['patientNumber'],
              role: context.read<LoginBloc>().state.role,
              appointmentId: state.registrationList[index]['id'],
            )
        ],
      ),
    );
  }
}

class RegisterList extends StatelessWidget {
  final dynamic state;
  final int index;
  const RegisterList({Key? key, required this.index, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterationCard(
      key: Key(state.registrationList[index]['id']),
      addRegisteration: () => {
        Modal(
            context: context,
            modalType: 'Unkown',
            inclueAction: true,
            actionButtons: RegisterButton(
              state: state,
              index: index,
            ),
            modalBody: const Text('Do you want to register this patient?'),
            progressDetails: 'Do you want to register this patient?'),
      },
      clinicalNote: () =>
          {showDialogConfirmation(context, state.registrationList[index])},
      firstName: state.registrationList[index]['patient']['firstName'],
      lastName: state.registrationList[index]['patient']['lastName'],
      type: state.registrationList[index]['type'],
      dateTime: state.registrationList[index]['dateTime'],
      patientNumber: state.registrationList[index]['patient']['patientNumber'],
      role: context.read<LoginBloc>().state.role,
      appointmentId: state.registrationList[index]['id'],
    );
  }
}

class RegisterButton extends StatelessWidget {
  final dynamic state;
  final int index;
  const RegisterButton({Key? key, required this.state, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => {Navigator.pop(context, false)},
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => {
            createRegistration(
                index: index,
                token: context.read<LoginBloc>().state.homeToken,
                patientId: state.registrationList[index]['patient']['id'],
                appointmentId: state.registrationList[index]['id'],
                reasons: state.registrationList[index]['reasonForVisit'],
                typeofVist: state.registrationList[index]['typeOfVisit'],
                context: context),
            Navigator.pop(context, false)
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

Future<String?> showDialogConfirmation(
    BuildContext context, dynamic appointment) {
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
//to here is the issue
  return clinicalNotePopUp(context, appointment, _patientName, hometoken);
}

Future<String?> clinicalNotePopUp(
    BuildContext context, appointment, _patientName, hometoken) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ClinicalnoteCubit, ClinicalnoteState>(
          builder: (context, state) {
            if (state.loadclinicalnote == LOADCLINICALNOTE.loading) {
              return const AlertDialog(
                content: Text('Loading'),
              );
            }
            if (state.loadclinicalnote == LOADCLINICALNOTE.loaded) {
              return AlertDialog(
                content: const Text('Add clinical Note'),
                actions: clinicalNoteForm(
                    appointment, _patientName, context, '', hometoken),
              );
            }
            return AlertDialog(
              content: const Text('Add clinical Note'),
              actions: clinicalNoteForm(
                  appointment, _patientName, context, '', hometoken),
            );
          },
        );
      });
}

//TODO: changed this to a wiget of it's own
List<Widget> clinicalNoteForm(
    appointment, _patientName, BuildContext context, String? note, homeToken) {
  final AuthSession authsession = AuthSession();

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
    const SizedBox(
      height: 20,
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
          onChanged: (username) {
            context.read<LoginBloc>().add(LoginUserNameChanged(username));
          },
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
    //Move the clinicalNote to it's full screen/it's own screen/page
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
            context.read<ClinicalnoteCubit>().clearClinicalNoteState(),
            Navigator.pop(context, 'Cancel'),
          },
          child: const Text('Cancel'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              if (appointment.containsKey('clinicalNoteId')) {
                authsession.getHomeToken()?.then((value) {
                  if (appointment.containsKey('clinicalNoteId')) {
                    var response = updateClinicalNoteData(
                        clinicalNoteId: appointment['clinicalNoteId'],
                        homeToken: value,
                        context: context);
                    response!.then((value) => {
                          if (value != null && value.statusCode == 202)
                            {
                              /* Messages.showMessage(
                              const Icon(
                                IconData(0xf635, fontFamily: 'MaterialIcons'),
                                color: Colors.green,
                              ),
                              'Clinical Note updated'), */
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
                                      builder: ((context) =>
                                          const Registration())),
                                  ModalRoute.withName('/dashboard'))
                            }
                          else if (value != null && value.statusCode == 400)
                            {
                              /*  Messages.showMessage(
                              const Icon(
                                IconData(0xe237, fontFamily: 'MaterialIcons'),
                                color: Colors.red,
                              ),
                              'Could not update Clinical Note'), */
                            }
                        });
                  } 
                });
              }
              else {
                authsession.getHomeToken()?.then((value) {
                  var response = createClinicalNoteData(
                      homeToken: value,
                      registerationId: appointment['id'],
                      medicalPersonnelId: context.read<LoginBloc>().state.id,
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
                            /*      Messages.showMessage(
                              const Icon(
                                IconData(0xf635, fontFamily: 'MaterialIcons'),
                                color: Colors.green,
                              ),
                              'Clinical Note created'), */
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const Registration())),
                                ModalRoute.withName('/dashboard'))
                          }
                        else if (value != null && value.statusCode == 400)
                          {
                            /*  Messages.showMessage(
                              const Icon(
                                IconData(0xe237, fontFamily: 'MaterialIcons'),
                                color: Colors.red,
                              ),
                              'Could not create Clinical Note'), */
                          }
                      });
                });
              }
            },
            child: context.read<LoginBloc>().state.role == 'DOCTOR'
                ? Text(
                    appointment.containsKey('clinicalNoteId') ? 'save' : 'add')
                : const SizedBox()),
      ],
    ),
  ];
}

String getToken() {
  final AuthSession authsession = AuthSession();
  authsession.getHomeToken()?.then((value) {
    return value;
  });
  return '';
}

Future dateTimePicker(BuildContext context, String? timedateRange) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;

  String formatTime = newTime.format(context);

  if (timedateRange == 'end') {
    context.read<RegisterationCubit>().setRegistrationEndTime(formatTime);
  }
  if (timedateRange == 'start') {
    context.read<RegisterationCubit>().setRegistrationTime(formatTime);
  }
}

Future datePicker(BuildContext context, String dateRange) async {
  var dateFormat = DateFormat('yyyy-MM-dd');

  final initDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 5));

  String formattedDate = dateFormat.format(newDate!);

  // ignore: unnecessary_null_comparison
  if (newDate == null) return;
  if (dateRange == 'start') {
    context.read<RegisterationCubit>().setRegistrationDate(formattedDate);
  }
  if (dateRange == 'end') {
    context.read<RegisterationCubit>().setRegistrationEndDate(formattedDate);
  }
}

//TODO:ClinicalNote Function moved to ClinicalNote component
Future<Response?>? updateClinicalNoteData(
    {required BuildContext context,
    required String homeToken,
    required String clinicalNoteId}) {
  print("updated clinical note");
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

Future<String?> showDialogCFeedback(BuildContext context,
    {required String token,
    required String patientId,
    required String appointmentId,
    required String reasons,
    required String typeofVist,
    required int index}) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            content: const Text('Do you want to register this patient?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => {Navigator.pop(context, 'Cancel')},
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => {
                  createRegistration(
                      index: index,
                      appointmentId: appointmentId,
                      token: token,
                      patientId: patientId,
                      reasons: reasons,
                      typeofVist: typeofVist,
                      context: context),
                  Navigator.pop(context, 'OK')
                },
                child: const Text('OK'),
              ),
            ],
          ));
}

Future<Response?> createRegistration(
    {required String token,
    required int index,
    required String patientId,
    required String appointmentId,
    required String reasons,
    required String typeofVist,
    required BuildContext context}) {
  var reponse = context.read<RegisterationCubit>().createRegistration(
      token: token,
      patientID: patientId,
      appointmentId: appointmentId,
      reasons: reasons,
      typeOfVisit: typeofVist);
  return reponse;
}
