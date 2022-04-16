import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointment/state/appointment_cubit.dart';

class AppointmentDateTimePickerField extends StatelessWidget {
  const AppointmentDateTimePickerField({Key? key, required this.label})
      : super(key: key);
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

  context.read<AppointmentCubit>().setAppointmentTime(formatTime);
}
class TimeContent extends StatelessWidget {
  const TimeContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(context.read<AppointmentCubit>().state.appointmentTime);
  }
}
