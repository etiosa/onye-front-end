// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DropDown extends StatefulWidget {
  DropDown(
      {Key? key,
      required this.label,
      required this.options,
      required this.setValue})
      : super(key: key);
  final String label;
  final List<String> options;

  Function setValue;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
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
          width: 320,
          child: FormBuilderDropdown<String>(
            name: widget.label,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 205, 226, 226),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            items: widget.options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            hint: Text("Select ${widget.label}"),
            onChanged: (String? val) {
              widget.setValue(val);
            },
            validator: FormBuilderValidators.required(context,
                errorText: '${widget.label} is required'),
          ),
        ),
      ],
    );
  }
}
