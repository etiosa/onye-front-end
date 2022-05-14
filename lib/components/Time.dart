import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

import '../pages/registration/state/registration_cubit.dart';

class Time extends StatelessWidget {
  String rangeLabel;
  String type;
  Time({Key? key, required this.rangeLabel, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == 'registeration') {
      return BlocBuilder<RegisterationCubit, RegistrationState>(
          builder: ((context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 20),
          child: InkWell(
            onTap: (() {
              dateTimePicker(
                  context: context, timedateRange: rangeLabel, type: type);
            }),
            child: Container(
              color: const Color.fromARGB(255, 205, 226, 226),
              constraints: const BoxConstraints(maxWidth: 150, maxHeight: 35),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Center(
                    child: Text(
                        rangeLabel == 'start'
                            ? state.registrationStartTime
                            : state.registrationEndTime,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins',
                            fontSize: 15)),
                  ),
                  width: 600,
                  height: 500,
                ),
              ),
            ),
          ),
        );
      }));
    } else {
      return BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: ((context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 20),
          child: InkWell(
            onTap: (() {
              dateTimePicker(
                  context: context, timedateRange: rangeLabel, type: type);
            }),
            child: Container(
              color: const Color.fromARGB(255, 205, 226, 226),
              constraints: const BoxConstraints(maxWidth: 150, maxHeight: 35),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Center(
                    child: Text(
                        rangeLabel == 'start'
                            ? state.fromTime
                            : state.toTime,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins',
                            fontSize: 15)),
                  ),
                  width: 600,
                  height: 500,
                ),
              ),
            ),
          ),
        );
      }));
    }
  }
}

Future dateTimePicker(
    {required BuildContext context,
    required String timedateRange,
    required String type}) async {
  final newTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;

  String formatTime = newTime.format(context);

  switch (type) {
    case 'registeration':
      if (timedateRange == 'end') {
        context.read<RegisterationCubit>().setRegistrationEndTime(formatTime);
      }
      if (timedateRange == 'start') {
        context.read<RegisterationCubit>().setRegistrationTime(formatTime);
      }
      break;
    case 'appointment':
      if (timedateRange == 'end') {
        context.read<AppointmentCubit>().setToTime(formatTime);
      }
      if (timedateRange == 'start') {
        context.read<AppointmentCubit>().setFromTime(formatTime);
      }
      break;
  }
}
