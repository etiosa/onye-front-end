import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/components/clinicalNote/clinicalnote_cubit.dart';

class ClinicalNoteTitleField extends StatefulWidget {
  ClinicalNoteTitleField({
    required this.appointment,
    Key? key,
  }) : super(key: key);
  dynamic appointment;

  @override
  State<ClinicalNoteTitleField> createState() => _ClinicalNoteTitleFieldState();
}

class _ClinicalNoteTitleFieldState extends State<ClinicalNoteTitleField> {
  String? _selectedText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.text = context.read<ClinicalnoteCubit>().state.title;
    _selectedText = context.read<ClinicalnoteCubit>().state.title;
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicalnoteCubit, ClinicalnoteState>(
        builder: (context, state) {
      if (state.title.isNotEmpty && state.title != _controller.text) {
        _controller.text = context.read<ClinicalnoteCubit>().state.title;
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            "Title",
            style: TextStyle(
              color: Color.fromARGB(255, 56, 155, 152),
            ),
          ),
        ),
        TextFormField(
          controller: _controller,
          onChanged: (title) =>
              context.read<ClinicalnoteCubit>().setClinicalNoteTitle(title),
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromARGB(255, 205, 226, 226),
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
      ]);
    });
  }
}
