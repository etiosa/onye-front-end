import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/pages/patient/state/patient_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';
import 'package:shimmer/shimmer.dart';

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
      context.read<AppointmentCubit>().searchRegistrations(
          token: context.read<LoginCubit>().state.homeToken,
          searchParams: context.read<AppointmentCubit>().state.searchParams);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20, bottom: 20),
                  child: Text(
                    'Registrations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 170,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ElevatedButton(
                        autofocus: true,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 56, 155, 152)),
                        ),
                        child: const Text(
                          'Create Registration',
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              '/dashboard/appointment/createRegistration');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10),
            child: Text("Search",
                style: TextStyle(color: Color.fromARGB(255, 56, 155, 152))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350, maxHeight: 40),
              child: TextFormField(
                onChanged: (search) =>
                    context.read<AppointmentCubit>().setSearchParams(search),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              width: 100,
              margin: const EdgeInsets.only(left: 15),
              constraints: const BoxConstraints(maxWidth: 170),
              child: ElevatedButton(
                autofocus: true,
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 56, 155, 152)),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  context.read<AppointmentCubit>().searchRegistrations(
                      token: context.read<LoginCubit>().state.homeToken,
                      searchParams:
                          context.read<AppointmentCubit>().state.searchParams);
                },
              ),
            ),
          ),
          registrationBody(),
        ],
      ),
    );
  }

  Widget registrationBody() {
    return (const Appointment());
  }
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
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state.searchState == SEARCHSTATE.notFound) {
          return (const Center(
              child: Card(
            child: Text('Not found'),
          )));
        }

        if (state.registrationList.isEmpty) {
          return Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 1.5,
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 1.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 48,
                                  height: 48,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 1.0),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 10.0,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 10.0,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 10.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )))
              ]));
        } else {
          return Expanded(
            flex: 1,
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemCount: state.registrationList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 140,
                      width: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 248, 254, 254),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppointmentConfirmed(
                          appointmentList: state.registrationList,
                          selectedIndex: index,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      state.registrationList[index]['patient']
                                          ['firstName'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.registrationList[index]['patient']
                                        ['lastName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      (state.registrationList[index]
                                              .containsKey(
                                                  'appointmentDateTime'))
                                          ? dateFormat.format(DateTime.parse(
                                              state.registrationList[index]
                                                  ['appointmentDateTime']))
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 2.0, 8.0, 2.0),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Number: ${state.registrationList[index]['patient']['patientNumber']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Phone: ${state.registrationList[index]['patient']['phoneNumber']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
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
          );
        }
      },
    );
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
    if (appointmentList[selectedIndex].containsKey('registrationDateTime')) {
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

class Confirmation extends StatelessWidget {
  Confirmation(
      {Key? key, required this.appointmentList, required this.selectedIndex})
      : super(key: key);
  List<dynamic> appointmentList;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 120,
          height: 30,
          child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    (appointmentList[selectedIndex]
                            .containsKey('registrationDateTime'))
                        ? const Color.fromARGB(255, 56, 155, 152)
                        : Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () => {
              (appointmentList[selectedIndex]
                      .containsKey('registrationDateTime'))
                  ? showDialogConfirmation(
                      context, appointmentList[selectedIndex])
                  : null
            },
            child: const Text('clinical note'),
          ),
        ),
        SizedBox(
          width: 120,
          height: 30,
          child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    (!appointmentList[selectedIndex]
                            .containsKey('registrationDateTime'))
                        ? const Color.fromARGB(255, 56, 155, 152)
                        : Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () => {
              (!appointmentList[selectedIndex]
                      .containsKey('registrationDateTime'))
                  ? showDialogConfirmation(
                      context, appointmentList[selectedIndex])
                  : null
            },
            child: const Text('Register'),
          ),
        ),
      ],
    );
  }

  Future<String?> showDialogConfirmation(
      BuildContext context, dynamic appointment) {
    final _patientName = appointment['patient']['firstName'] +
        ' ' +
        appointment['patient']['lastName'];
    //final patientId =
    final AuthSession authsession = AuthSession();
    var hometoken;

    authsession.getHomeToken()?.then((value) => hometoken = value);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Add clinical Note'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropDown(label: 'Note Type', options: const [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  "Title",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 155, 152),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (title) => context
                    .read<AppointmentCubit>()
                    .setClinicalNoteTitle(title),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color.fromARGB(255, 205, 226, 226),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  "Note",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 155, 152),
                  ),
                ),
              ),
              TextFormField(
                maxLines: 7,
                onChanged: (note) =>
                    context.read<AppointmentCubit>().setClinicalNote(note),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color.fromARGB(255, 205, 226, 226),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a note';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              TextButton(
                onPressed: () => {
                  Navigator.pop(context, 'Cancel'),
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    var response = context
                        .read<AppointmentCubit>()
                        .createClinicalNote(
                            token: hometoken,
                            medicalId: context.read<LoginCubit>().state.id,
                            note: context
                                .read<AppointmentCubit>()
                                .state
                                .clinicalNote,
                            title: context
                                .read<AppointmentCubit>()
                                .state
                                .clinicalNoteTitle,
                            clinicalNoteType: context
                                .read<AppointmentCubit>()
                                .state
                                .clinicalNoteType,
                            patientId: appointment['patient']['id']);

                    response.then((value) => {
                      if (value != null && value.statusCode == 201)
                            {
                              Messages.showMessage(
                                  const Icon(
                                    IconData(0xf635,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.green,
                                  ),
                                  'Clinical Note created'),
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const Registration())),
                                  ModalRoute.withName('/dashboard'))
                            }
                          else if (value != null && value.statusCode == 400)
                            {
                              Messages.showMessage(
                                  const Icon(
                                    IconData(0xe237,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.red,
                                  ),
                                  'Could not create Clinical Note'),
                            }
                    });
                    //Navigator.pop(context, 'Add');
                  },
                  child: const Text('Add')),
            ],
          ),
        ],
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  DropDown({Key? key, required this.label, required this.options})
      : super(
          key: key,
        );
  String label;
  List<String> options;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? _selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(widget.label),
        ),
        SizedBox(
          height: 45,
          width: 300,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: const Color.fromARGB(255, 205, 226, 226),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color.fromARGB(255, 205, 226, 226),
                isExpanded: true,
                value: _selectedText,
                hint: const Text("Select Note Type"),
                items: widget.options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedText = val.toString();

                    context
                        .read<AppointmentCubit>()
                        .setClinicalNoteType(_selectedText);
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
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
  @override
  Widget build(BuildContext context) {
    if (widget.registrationList[widget.selectedIndex]
        .containsKey('registrationDateTime')) {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Confirmation(
            appointmentList: widget.registrationList,
            selectedIndex: widget.selectedIndex,
          ));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 120,
        height: 30,
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 56, 155, 152)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () {
              context.read<AppointmentCubit>().createRegistration(
                    token: context.read<LoginCubit>().state.homeToken,
                    patientID: widget.registrationList[widget.selectedIndex]
                        ['patient']['id'],
                    medicalId: widget.registrationList[widget.selectedIndex]
                        ['medicalPersonnel']['id'],
                    appointmentId: widget.registrationList[widget.selectedIndex]
                        ['id'],
                    reasons: widget.registrationList[widget.selectedIndex]
                        ['reasonForVisit'],
                    typeOfVisit: widget.registrationList[widget.selectedIndex]
                        ['typeOfVisit'],
                  );
            },
            child: const Text('Register')),
      ),
    );
  }
}
