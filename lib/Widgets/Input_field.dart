// ignore: file_names
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.label,
      required this.setValue,
      required this.isRequired})
      : super(key: key);
  final String label;
  final Function setValue;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Text(label),
        ),
        SizedBox(
          width: 320,
          child: TextFormField(
            onChanged: (firstName) {
              setValue(firstName);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Color.fromARGB(255, 205, 226, 226),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            validator: isRequired
                ? FormBuilderValidators.required(context,
                    errorText: '$label is required')
                : null,
          ),
        ),
      ],
    );
  }
}
