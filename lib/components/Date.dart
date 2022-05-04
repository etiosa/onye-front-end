import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

import '../pages/registration/state/registration_cubit.dart';

class Date extends StatelessWidget {
  String rangeDate;
  String type;
  Date({Key? key, required this.rangeDate, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterationCubit, RegistrationState>(
        builder: ((context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Date"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 20),
            child: InkWell(
              onTap: (() {
                datePicker(context, rangeDate, type);
              }),
              child: Container(
                color: const Color.fromARGB(255, 205, 226, 226),
                constraints: const BoxConstraints(maxWidth: 150, maxHeight: 35),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Center(
                        child: Text(
                          rangeDate == "start"
                              ? state.registrationDate
                              : state.registrationEndDate,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                              fontSize: 15),
                        ),
                      ),
                    ),
                    width: 600,
                    height: 500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }));
  }
}

Future datePicker(BuildContext context, String dateRange, String type) async {
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
  switch (type) {
    case 'registeration':
      if (dateRange == 'start') {
        context.read<RegisterationCubit>().setRegistrationDate(formattedDate);
        print(context.read<RegisterationCubit>().state.registrationDate);
      }
      if (dateRange == 'end') {
        context
            .read<RegisterationCubit>()
            .setRegistrationEndDate(formattedDate);
      }
      break;
    case 'appointment':
      if (dateRange == 'start') {
        context.read<AppointmentCubit>().setFromTime(formattedDate);
      }
      if (dateRange == 'end') {
        context.read<AppointmentCubit>().setToTime(formattedDate);
      }
      break;
  }
}
