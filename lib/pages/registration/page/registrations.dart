import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
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

  int? initPageSelected = 0;

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
    const int heightOffset = 300;
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - heightOffset,
          child: Column(
            children: [
              (const Appointment()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var index = 0;
                      index <=
                          context.read<AppointmentCubit>().state.maxPageNumber;
                      index++)
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            initPageSelected = index;
                          });

                          context.read<AppointmentCubit>().setNextPage(
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
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                                child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: initPageSelected == index
                                      ? Colors.white
                                      : const Color.fromARGB(
                                          255, 56, 155, 152)),
                            ))),
                      ),
                    )
                ],
              )
            ],
          ),
        );
      },
    );
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
              height: MediaQuery.of(context).size.height / 1.8,
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
                                  width: 20,
                                  height: 20,
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
                                      dateFormat.format(DateTime.parse(
                                          state.registrationList[index]
                                              ['dateTime'])),
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
                    (appointmentList[selectedIndex]['type'] == 'registration')
                        ? const Color.fromARGB(255, 56, 155, 152)
                        : Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () => {
              (appointmentList[selectedIndex]['type'] == 'registration')
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
                    (!(appointmentList[selectedIndex]['type'] == 'registration'))
                        ? const Color.fromARGB(255, 56, 155, 152)
                        : Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () => {
              (!(appointmentList[selectedIndex]['type'] == 'registration'))
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
    final clincialNoteid = appointment['clinicalNoteId'];
    final AuthSession authsession = AuthSession();

    String? title;
    String? noteType;

    var hometoken;
    authsession.getHomeToken()?.then((value) => {
          hometoken = value,
          if (appointment.containsKey('clinicalNoteId'))
            {
              context
                  .read<AppointmentCubit>()
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

  List<Widget> clinicalNoteForm(appointment, _patientName, BuildContext context,
      String? note, homeToken) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropDown(
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
            },
            child: const Text('Cancel'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                if (appointment.containsKey('clinicalNoteId')) {
                  var response =
                      context.read<AppointmentCubit>().updateClinicalNote(
                            token: homeToken,
                            id: appointment['clinicalNoteId'],
                            type: context
                                .read<AppointmentCubit>()
                                .state
                                .clinicalNoteType,
                            noteText: context
                                .read<AppointmentCubit>()
                                .state
                                .clinicalNote,
                            title: context
                                .read<AppointmentCubit>()
                                .state
                                .clinicalNoteTitle,
                          );
                  response.then((value) => {
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
                                .read<AppointmentCubit>()
                                .clearClinicalNoteState(),
                            context
                                .read<AppointmentCubit>()
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
                            Messages.showMessage(
                                const Icon(
                                  IconData(0xe237, fontFamily: 'MaterialIcons'),
                                  color: Colors.red,
                                ),
                                'Could not update Clinical Note'),
                          }
                      });
                } else {
                  var response = context
                      .read<AppointmentCubit>()
                      .createClinicalNote(
                          token: homeToken,
                          registrationId: appointment['id'],
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
                            context
                                .read<AppointmentCubit>()
                                .clearClinicalNoteState(),
                            Messages.showMessage(
                                const Icon(
                                  IconData(0xf635, fontFamily: 'MaterialIcons'),
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
}

class ClinicalNoteTitleField extends StatefulWidget {
  ClinicalNoteTitleField({
    required this.appointment,
    Key? key,
  }) : super(key: key);
  dynamic appointment;

  @override
  State<ClinicalNoteTitleField> createState() => _ClinicalNoteTitleFieldState();
}

class _ClinicalNoteTitleFieldState extends State<ClinicalNoteTitleField> {
  String? _selectedText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.text = context.read<AppointmentCubit>().state.clinicalNoteTitle;
    _selectedText = context.read<AppointmentCubit>().state.clinicalNoteTitle;
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
      if (state.clinicalNoteTitle.isNotEmpty &&
          state.clinicalNoteTitle != _controller.text) {
        _controller.text =
            context.read<AppointmentCubit>().state.clinicalNoteTitle;
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          controller: _controller,
          onChanged: (title) =>
              context.read<AppointmentCubit>().setClinicalNoteTitle(title),
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
      ]);
    });
  }
}

class ClinicalNoteField extends StatefulWidget {
  ClinicalNoteField({
    required this.appointment,
    this.title,
    Key? key,
  }) : super(key: key);
  dynamic appointment;
  var title;

  @override
  State<ClinicalNoteField> createState() => _ClinicalNoteFieldState();
}

class _ClinicalNoteFieldState extends State<ClinicalNoteField> {
  String? _selectedText;

  // String t= context.read();

  final TextEditingController _controller = TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.text = context.read<AppointmentCubit>().state.clinicalNote;
    _selectedText = context.read<AppointmentCubit>().state.clinicalNote;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state.clinicalNote.isNotEmpty &&
            state.clinicalNote != _controller.text) {
          _controller.text =
              context.read<AppointmentCubit>().state.clinicalNote;
        }
        return (Column(
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
              controller: _controller,
              maxLines: 7,
              onChanged: (note) {
                setState(() {
                  _selectedText = note;
                  context.read<AppointmentCubit>().setClinicalNote(note);
                });
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
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter a note';
                }
                return null;
              },
            ),
          ],
        ));
      },
    );
  }
}

class DropDown extends StatefulWidget {
  DropDown(
      {Key? key, required this.label, required this.options, this.registration})
      : super(
          key: key,
        );
  String label;
  List<String> options;
  dynamic registration;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? clinicalType;

  //
  String dropdownValue = 'CONSULTATION_NOTE';
  String? clinicalNoteId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AppointmentCubit>().setClinicalNoteType(dropdownValue);
  }

  final AuthSession authsession = AuthSession();

  @override
  Widget build(BuildContext context) {
    // run get clincial note // by check if  the current selected wiget has the clinicalNoted id
    if (widget.registration.containsKey('clinicalNoteId')) {
      clinicalNoteId = widget.registration['clinicalNoteId'];

      authsession.getHomeToken()?.then((value) => {
            {
              context
                  .read<AppointmentCubit>()
                  .getPatientClinicalNote(id: clinicalNoteId, token: value)
                  .then((value) {
                context.read<AppointmentCubit>().setclinicalNoteID(
                      clinicalNoteId!,
                    );
                //
              })
            }
          });
      // print("fetch the current clincial note");
    } else {
      //check if the clincialnote state is not empty if its empty the clincial note
      if (context.read<AppointmentCubit>().state.clinicalNoteID.isNotEmpty) {
        context.read<AppointmentCubit>().clearClinicalNoteState();
      }
    }

    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: ((context, state) {
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
                      hint: const Text("Select Note Type"),
                      dropdownColor: const Color.fromARGB(255, 205, 226, 226),
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          context
                              .read<AppointmentCubit>()
                              .setClinicalNoteType(dropdownValue);
                        });
                      },
                      items: <String>[
                        'CONSULTATION_NOTE',
                        'DISCHARGE_SUMMARY_NOTE',
                        'PROCEDURE_NOTE',
                        'PROGRESS_NOTE',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )

                  /* DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: const Color.fromARGB(255, 205, 226, 226),
                    isExpanded: true,

                  value: state.clinicalNoteType.isEmpty &&
                            widget.registration.containsKey('clinicalNoteId')
                        ? _selectedText
                        : state.clinicalNoteType,
                    hint: const Text("Select Note Type"),
                    items: <String>[
                      'CONSULTATION_NOTE',
                      'DISCHARGE_SUMMARY_NOTE',
                      'PROCEDURE_NOTE',
                      'PROGRESS_NOTE',
                    ].map((String value) {
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
                ), */
                  ),
            ),
          ],
        );
      }),
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
    if (widget.registrationList[widget.selectedIndex]['type'] == 'registration') {
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
