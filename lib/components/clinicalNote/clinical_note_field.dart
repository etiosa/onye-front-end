import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/components/clinicalNote/clinical_note_cubit.dart';

import '../../pages/auth/state/login_bloc.dart';
class ClinicalNoteField extends StatefulWidget {
  ClinicalNoteField({
    required this.appointment,
    this.title,
    Key? key,
  }) : super(key: key);
  dynamic appointment;
  var title;

  @override
  State<ClinicalNoteField> createState() => _ClinicalNoteFieldState();
}

class _ClinicalNoteFieldState extends State<ClinicalNoteField> {
  String? _selectedText;

  // String t= context.read();

  final TextEditingController _controller = TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.text = context.read<ClinicalnoteCubit>().state.text;
    _selectedText = context.read<ClinicalnoteCubit>().state.text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicalnoteCubit, ClinicalnoteState>(
      builder: (context, state) {
        if (state.text.isNotEmpty && state.text != _controller.text) {
          _controller.text = context.read<ClinicalnoteCubit>().state.text;
        }
        return (Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "Note",
                style: TextStyle(
                  color: Color.fromARGB(255, 56, 155, 152),
                ),
              ),
            ),
            TextFormField(
              readOnly: context.read<LoginBloc>().state.role != 'DOCTOR',
              controller: _controller,
              maxLines: 7,
              onChanged: (note) {
                setState(() {
                  _selectedText = note;
                  context.read<ClinicalnoteCubit>().setClinicalNote(note);
                });
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
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter a note';
                }
                return null;
              },
            ),
          ],
        ));
      },
    );
  }
}
