import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/Widgets/Button.dart';
import 'package:onye_front_ened/Widgets/Pagination.dart';
import 'package:onye_front_ened/components/Date.dart';
import 'package:onye_front_ened/components/Time.dart';
import 'package:onye_front_ened/pages/appointment/RescheduleAppointmentButton.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';

import '../Widgets/AppointmentCard.dart';
import '../Widgets/GenericLoadingContainer.dart';
import '../components/util/Modal.dart';
import '../session/authSession.dart';
import 'appointment/state/appointment_cubit.dart';
import 'auth/repository/auth_repositories.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  void initState() {
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
              final AuthSession authsession = AuthSession();
                 authsession.getHomeToken()?.then((value) async {
                _loginbloc.home(homeToken: value).then((res) {
                  context
                      .read<LoginBloc>()
                      .setLoginData(value, jsonDecode(res.body));
                });
                context.read<AppointmentCubit>().searchAppointments(
                    token: value);
              });
              
             
            }
          });
        });
      });
    }

    if (context.read<LoginBloc>().state.homeToken.isNotEmpty) {
      context
          .read<AppointmentCubit>()
          .searchAppointments(token: context.read<LoginBloc>().state.homeToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldText = TextEditingController();
    int initPageSelected = 0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Button(
                      height: 50,
                      width: 170,
                      label: 'Create Appointment',
                      onPressed: () => Navigator.of(context).pushNamed(
                          '/dashboard/appointment/createAppointment'))
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
                  controller: fieldText,
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
                      type: 'appointment',
                    ),
                  ],
                ),
                Date(
                  rangeDate: 'start',
                  type: 'appointment',
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
                      type: 'appointment',
                    ),
                  ],
                ),
                Date(
                  rangeDate: 'end',
                  type: 'appointment',
                ),
              ],
            ),
            Button(
                height: 50,
                width: 100,
                label: 'Search',
                onPressed: () {
                  searchAppointments(
                      context: context,
                      startDate:
                          context.read<AppointmentCubit>().state.fromDate,
                      startTime:
                          context.read<AppointmentCubit>().state.fromTime,
                      endDate: context.read<AppointmentCubit>().state.toDate,
                      endTime: context.read<AppointmentCubit>().state.toTime);

                  fieldText.clear();
                }),
            registrationBody(nextPageCounter: initPageSelected),
          ],
        ),
      ),
    );
  }

  Widget registrationBody({required int nextPageCounter}) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return Column(
          children: [
            (const Appointment()),
            Pagination(
              maxPageCounter:
                  context.read<AppointmentCubit>().state.maxPageNumber,
              typeofSearch: 'appointment',
            )
          ],
        );
      },
    );
  }

  void searchAppointments(
      {required BuildContext context,
      String? startDate,
      String? startTime,
      String? endDate,
      String? endTime}) {
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

    context.read<AppointmentCubit>().searchAppointments(
        token: context.read<LoginBloc>().state.homeToken,
        startDateTime: startdateTime?.toIso8601String(),
        endDateTime: enddateTime?.toIso8601String(),
        searchParams: context.read<AppointmentCubit>().state.searchParams);
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
        if (state.apploadState == APPOINTMENTLOADSTATE.failed) {
          return const Center(
            child: Text("No result, please try again"),
          );
        }

        if (state.apploadState == APPOINTMENTLOADSTATE.loading) {
          return Column(
            children: [
              for (var index = 0; index <= 20; index++)
                const GenericLoadingContainer(height: 100, width: 500),
            ],
          );
        }
        if (state.apploadState == APPOINTMENTLOADSTATE.loaded) {
          return Column(
            children: [
              for (var index = 0;
                  index < state.appointmentList.length - 1;
                  index++)
                AppointmentList(index: index, state: state)
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
    );
  }
}

class AppointmentList extends StatelessWidget {
  final dynamic state;
  final int index;
  const AppointmentList({Key? key, required this.index, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.appointmentList[index]['type'] == 'appointment') {
      return AppointmentCard(
        key: Key(state.appointmentList[index]['id']),
        appointmentId: state.appointmentList[index]['id'],
        firstName: state.appointmentList[index]['patient']['firstName'],
        lastName: state.appointmentList[index]['patient']['lastName'],
        type: state.appointmentList[index]['type'],
        dateTime: state.appointmentList[index]['dateTime'],
        patientNumber: state.appointmentList[index]['patient']['patientNumber'],
        role: context.read<LoginBloc>().state.role,
        button: RescheduleAppointmentButton(
            appointment: state.appointmentList[index]),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}

class AppointmentsList extends StatelessWidget {
  final dynamic state;
  const AppointmentsList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.6,
      width: MediaQuery.of(context).size.width < 600 ? double.infinity : 600,
      child: ListView.builder(
          itemCount: state.appointmentList.length,
          itemBuilder: ((context, index) {
            if (state.appointmentList[index]['type'] == 'appointment') {
              return AppointmentCard(
                key: Key(state.appointmentList[index]['id']),
                appointmentId: state.appointmentList[index]['id'],
                firstName: state.appointmentList[index]['patient']['firstName'],
                lastName: state.appointmentList[index]['patient']['lastName'],
                type: state.appointmentList[index]['type'],
                dateTime: state.appointmentList[index]['dateTime'],
                patientNumber: state.appointmentList[index]['patient']
                    ['patientNumber'],
                role: context.read<LoginBloc>().state.role,
                button: RescheduleAppointmentButton(
                    appointment: state.appointmentList[index]),
              );
            } else {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            }
          })),
    );
  }
}
