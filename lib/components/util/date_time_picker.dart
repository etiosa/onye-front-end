import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Future datePicker(
    BuildContext context, String label, Function(String) cubitMethod) async {
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
  cubitMethod(formattedDate);
}

class DatePickerField extends StatelessWidget {
  const DatePickerField(
      {Key? key, required this.label, required this.cubitSetMethod, required this.cubitGetMethod})
      : super(key: key);
  final String label;
  final Function(String) cubitSetMethod;
  final String Function() cubitGetMethod;

  @override
  Widget build(BuildContext context) {
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
                datePicker(context, label, cubitSetMethod);
              },
              child: Container(
                height: 45,
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextContent(
                    label: label,
                    cubitGetMethod: cubitGetMethod,
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
  const TextContent({Key? key, required this.label, required this.cubitGetMethod}) : super(key: key);
  final String label;
  final String Function() cubitGetMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
      child: Text(
        cubitGetMethod.call(),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

Future dateTimePicker(BuildContext context, String label, Function(String) cubitSetMethod) async {
  final newTime =
  await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (newTime == null) return;

  String formatTime = newTime.format(context);

  cubitSetMethod(formatTime);
}

class DateTimePickerField extends StatelessWidget {
  const DateTimePickerField({Key? key, required this.label, required this.cubitSetMethod, required this.cubitGetMethod}) : super(key: key);
  final String label;
  final Function(String) cubitSetMethod;
  final String Function() cubitGetMethod;

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
                dateTimePicker(context, label, cubitSetMethod);
              },
              child: Container(
                height: 45,
                width: 100,
                color: const Color.fromARGB(255, 205, 226, 226),
                child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TimeContent(
                      label: label,
                      cubitGetMethod: cubitGetMethod,
                    )),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class TimeContent extends StatelessWidget {
  const TimeContent({Key? key, required this.label, required this.cubitGetMethod}) : super(key: key);
  final String label;
  final String Function() cubitGetMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
      child: Text(
        cubitGetMethod.call(),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
