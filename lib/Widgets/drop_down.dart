// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DropDown extends StatefulWidget {
  DropDown(
      {Key? key,
      required this.label,
      required this.options,
      this.initValue,
      required this.setValue})
      : super(key: key);
  final String label;
  final List<String> options;
  final String? initValue;

  Function setValue;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? dropDownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.initValue!.isNotEmpty) {
      setState(() {
        dropDownValue = widget.initValue!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.initValue!.isEmpty);

    if (widget.initValue!.isNotEmpty) {
      setState(() {
        dropDownValue = widget.initValue!;
      });
    }
    print(dropDownValue);
    print(dropDownValue != null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(widget.label),
        ),
        Formdropdown(context),
      ],
    );
  }

  SizedBox Formdropdown(BuildContext context) {
    if (dropDownValue != null) {
      return SizedBox(
        width: 320,
        child: FormBuilderDropdown<String>(
          initialValue: dropDownValue!,
          name: widget.label,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 205, 226, 226),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          items: widget.options.map((
            String value,
          ) {
            //print("drop value re-render");
            // print(widget.initValue);
            return DropdownMenuItem<String>(
              key: Key(value),
              value: value,
              child: Text(value),
              onTap: () {
                print("was tap");
              },
            );
          }).toList(),
          hint: Text("Select ${widget.label}"),
          //initialValue: 'Test',
          onChanged: (String? val) {
            widget.setValue(val);
          },
          validator: FormBuilderValidators.required(context,
              errorText: '${widget.label} is required'),
        ),
      );
    } else {
      return SizedBox(
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
          items: widget.options.map((
            String value,
          ) {
            //print("drop value re-render");
            // print(widget.initValue);
            return DropdownMenuItem<String>(
              key: Key(value),
              value: value,
              child: Text(value),
              onTap: () {
                print("was tap");
              },
            );
          }).toList(),
          hint: Text("Select ${widget.label}"),
          //initialValue: 'Test',
          onChanged: (String? val) {
            widget.setValue(val);
          },
          validator: FormBuilderValidators.required(context,
              errorText: '${widget.label} is required'),
        ),
      );
    }
  }
}
