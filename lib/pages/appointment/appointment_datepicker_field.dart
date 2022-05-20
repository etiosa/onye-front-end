import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

class AppointmentDatePickerField extends StatelessWidget {
  const AppointmentDatePickerField({Key? key, required this.label})
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
                  child: LabelContent(
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
Future datePicker(BuildContext context, String label) async {
  var dateFormat = DateFormat('yyyy-MM-dd');

  DateTime initDate = DateTime.now();

  final newDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 5));

  String formattedDate = dateFormat.format(newDate!);

  // ignore: unnecessary_null_comparison
  if (newDate == null) return;
  context.read<AppointmentCubit>().setAppointmentDate(formattedDate);
}
class LabelContent extends StatelessWidget {
  const LabelContent({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5.0),
      child: Text(context.read<AppointmentCubit>().state.appointmentDate,
          style: const TextStyle(fontSize: 12)),
    );
  }
}
