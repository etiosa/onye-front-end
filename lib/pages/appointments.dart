import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';
import 'package:shimmer/shimmer.dart';

import '../components/util/Messages.dart';
import 'appointment/state/appointment_cubit.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
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
      context.read<AppointmentCubit>().searchAppointments(
          token: context.read<LoginCubit>().state.homeToken);
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
                    'Appointment',
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
                          'Create Appointment',
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              '/dashboard/appointment/createApppointment');
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
                onChanged: (searchParams) => context
                    .read<AppointmentCubit>()
                    .setSearchParams(searchParams),
                obscureText: false,
                autofocus: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 205, 226, 226),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
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
                  context.read<AppointmentCubit>().searchAppointments(
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
            child: SizedBox(
                height: 50,
                width: 200,
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('NOT FOUND'),
                ))),
          ));
        }

        if (state.appointmentList.isEmpty) {
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
                itemCount: state.appointmentList.length,
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
                        /* AppointmentConfirmed(
                          appointmentList: state.appointmentList,
                          selectedIndex: index,
                        ), */
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
                                      state.appointmentList[index]['patient']
                                          ['firstName'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.appointmentList[index]['patient']
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
                                          state.appointmentList[index]
                                              ['appointmentDateTime'])),
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
                                      'Number: ${state.appointmentList[index]['patient']['patientNumber']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Phone: ${state.appointmentList[index]['patient']['phoneNumber']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                CancelAppointmentButton(
                                  id: state.appointmentList[index]['id'],
                                ),
                                RescheduleAppointmentButton(
                                  appointment: state.appointmentList[index],
                                ),
                              ],
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

class CancelAppointmentButton extends StatelessWidget {
  CancelAppointmentButton({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 120,
        height: 30,
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(128, 0, 0, 1.0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () {
              var response = context.read<AppointmentCubit>().cancelAppointment(
                    id: id,
                    token: context.read<LoginCubit>().state.homeToken,
                  );

              response.then((value) => {
                    if (value != null && value.statusCode == 200)
                      {
                        Messages.showMessage(
                            const Icon(
                              IconData(0xf635, fontFamily: 'MaterialIcons'),
                              color: Colors.green,
                            ),
                            'Appointment cancelled'),
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => const Appointments())),
                            ModalRoute.withName('/dashboard'))
                      }
                    else if (value != null && value.statusCode == 400)
                      {
                        Messages.showMessage(
                            const Icon(
                              IconData(0xe237, fontFamily: 'MaterialIcons'),
                              color: Colors.red,
                            ),
                            'Could not cancel appointment'),
                      }
                  });
            },
            child: const Text('Cancel')),
      ),
    );
  }
}

class RescheduleAppointmentButton extends StatelessWidget {
  RescheduleAppointmentButton({Key? key, required this.appointment})
      : super(key: key);

  var appointment;

  @override
  Widget build(BuildContext context) {
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
              showDialogConfirmation(context, appointment);
            },
            child: const Text('Edit')),
      ),
    );
  }

  Future<String?> showDialogConfirmation(
      BuildContext context, dynamic appointment) {
    final AuthSession authsession = AuthSession();
    var hometoken;

    authsession.getHomeToken()?.then((value) => hometoken = value);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Edit appointment'),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              DropDown(
                  label: 'Language Preference',
                  initialValue: 'EN',
                  options: const ['EN']),
              const SizedBox(height: 25),
              DropDown(
                  label: 'Type of Visit',
                  initialValue: appointment['typeOfVisit'],
                  options: const ['Follow-up', 'Consultation']),
              const SizedBox(height: 25),
              DropDown(
                  label: 'Reason for Visit',
                  initialValue: appointment['reasonForVisit'],
                  options: const [
                    'Headache',
                    'Follow-up',
                    'Malaria',
                    'Fever',
                    'Injection',
                    'Test Result',
                    'Lab Test',
                    'PUD',
                    'Check Up',
                    'Consultation'
                  ]),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  DatePickerField(
                    label: 'Date',
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DateTimePickerField(
                    label: 'Time',
                  ),
                ],
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
                        .updateAppointment(
                          id: appointment['id'],
                          date:
                              context.read<AppointmentCubit>().state.startDate,
                          time:
                              context.read<AppointmentCubit>().state.startTime,
                          languagePreference: 'en',
                          typeOfVisit: context
                              .read<AppointmentCubit>()
                              .state
                              .typeOfVisit,
                          reasonForVisit: context
                              .read<AppointmentCubit>()
                              .state
                              .reasonForVisit,
                          token: hometoken,
                        );

                    response.then((value) => {
                          if (value != null && value.statusCode == 202)
                            {
                              context.read<AppointmentCubit>().clearState(),
                              Messages.showMessage(
                                  const Icon(
                                    IconData(0xf635,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.green,
                                  ),
                                  'Appointment updated'),
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const Appointments())),
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
                                  'Could not update appointment'),
                            }
                        });
                  },
                  child: const Text('Save')),
            ],
          ),
        ],
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  DropDown(
      {Key? key, required this.label, required this.options, this.initialValue})
      : super(
          key: key,
        );
  String label;
  List<String> options;
  String? initialValue;

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
          width: 320,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: const Color.fromARGB(255, 205, 226, 226),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color.fromARGB(255, 205, 226, 226),
                isExpanded: true,
                value: setValue(),
                items: widget.options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedText = val.toString();
                    if (widget.label == 'Type of Visit') {
                      context
                          .read<AppointmentCubit>()
                          .setTypeOfVisit(_selectedText);
                    }

                    if (widget.label == 'Reason for Visit') {
                      context
                          .read<AppointmentCubit>()
                          .setReasonForVisit(_selectedText);
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? setValue() {
    if (widget.label == 'Type of Visit' && _selectedText == null) {
      context.read<AppointmentCubit>().setTypeOfVisit(widget.initialValue);
    }

    if (widget.label == 'Reason for Visit' && _selectedText == null) {
      context.read<AppointmentCubit>().setReasonForVisit(widget.initialValue);
    }

    return _selectedText ?? widget.initialValue;
  }
}

class DateTimePickerField extends StatelessWidget {
  const DateTimePickerField({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                dateTimePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TimeContent(
                      label: label,
                    )),
              ),
            ),
          ],
        ));
      },
    );
  }
}

Future dateTimePicker(BuildContext context, String label) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;

  String formatTime = newTime.format(context);

  context.read<AppointmentCubit>().setStartTime(formatTime);
}

class DatePickerField extends StatelessWidget {
  const DatePickerField({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () {
                datePicker(context, label);
              },
              child: Container(
                height: 45,
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextContent(
                    label: label,
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label == 'From') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(
          context.read<AppointmentCubit>().state.startDate,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
      child: Text(context.read<AppointmentCubit>().state.startDate,
          style: const TextStyle(fontSize: 12)),
    );
  }
}

class TimeContent extends StatelessWidget {
  const TimeContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label == 'From') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(
          context.read<AppointmentCubit>().state.startTime,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    if (label == 'To') {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 5.0),
        child: Text(context.read<AppointmentCubit>().state.startTime,
            style: const TextStyle(fontSize: 12)),
      );
    }
    return Text(context.read<AppointmentCubit>().state.startTime);
  }
}

Future datePicker(BuildContext context, String label) async {
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
  context.read<AppointmentCubit>().setStartDate(formattedDate);
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
    if (!appointmentList[selectedIndex].containsKey("registrationDateTime")) {
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
    return SizedBox(
      width: 120,
      height: 30,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                (appointmentList[selectedIndex]
                        .containsKey("registrationDateTime"))
                    ? const Color.fromARGB(255, 56, 155, 152)
                    : Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ))),
        onPressed: () => {
          (appointmentList[selectedIndex].containsKey("registrationDateTime"))
              ? showDialogConfirmation(context)
              : null
        },
        child: const Text('Checkin'),
      ),
    );
  }

  Future<String?> showDialogConfirmation(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Do you want to check this patient in'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class CheckInPatient extends StatelessWidget {
  CheckInPatient(
      {Key? key, required this.appointmentList, required this.selectedIndex})
      : super(key: key);
  List<dynamic> appointmentList;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (!appointmentList[selectedIndex].containsKey("registrationDateTime")) {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Confirmation(
            appointmentList: appointmentList,
            selectedIndex: selectedIndex,
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
            onPressed: () {},
            child: const Text('Create new New registeration')),
      ),
    );
  }
}
