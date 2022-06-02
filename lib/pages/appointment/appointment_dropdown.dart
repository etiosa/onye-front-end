import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/pages/appointment/state/appointment_cubit.dart';

class AppointmentDropDown extends StatefulWidget {
  AppointmentDropDown(
      {Key? key, required this.label, required this.options, this.initialValue})
      : super(
          key: key,
        );
  final String label;
  final List<String> options;
  final String? initialValue;

  @override
  _AppointmentDropDownState createState() => _AppointmentDropDownState();
}

class _AppointmentDropDownState extends State<AppointmentDropDown> {
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
