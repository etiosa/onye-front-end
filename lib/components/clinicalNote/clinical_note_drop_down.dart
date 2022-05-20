import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/components/clinicalNote/clinical_note_cubit.dart';
import 'package:onye_front_ened/pages/auth/state/login_bloc.dart';
import 'package:onye_front_ened/session/authSession.dart';

class ClinicalNoteDropDown extends StatefulWidget {
  const ClinicalNoteDropDown(
      {Key? key, required this.label, required this.options, this.registration})
      : super(
          key: key,
        );
  final String label;
  final List<String> options;
  final dynamic registration;

  @override
  _ClinicalNoteDropDownState createState() => _ClinicalNoteDropDownState();
}

class _ClinicalNoteDropDownState extends State<ClinicalNoteDropDown> {
  String? clinicalType;

  //
  String dropdownValue = 'CONSULTATION_NOTE';
  String? clinicalNoteId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<ClinicalnoteCubit>().setClinicalNoteType(dropdownValue);
  }

  final AuthSession authsession = AuthSession();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClinicalnoteCubit, ClinicalnoteState>(
      listener: (context, state) {
        if (context.read<ClinicalnoteCubit>().state.type.isNotEmpty) {
          dropdownValue = context.read<ClinicalnoteCubit>().state.type;
        }
      },
      child: BlocBuilder<ClinicalnoteCubit, ClinicalnoteState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(widget.label),
              ),
              Container(
                  // width: 200,
                  height: 50,
                  padding: const EdgeInsets.all(10.0),
                  color: const Color.fromARGB(255, 205, 226, 226),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text("Select Note Type"),
                      dropdownColor: const Color.fromARGB(255, 205, 226, 226),
                      value: dropdownValue,
                      // icon: const Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged:
                          context.read<LoginBloc>().state.role == 'DOCTOR'
                              ? (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                    context
                                        .read<ClinicalnoteCubit>()
                                        .setClinicalNoteType(dropdownValue);
                                  });
                                }
                              : null,
                      items: <String>[
                        'CONSULTATION_NOTE',
                        'DISCHARGE_SUMMARY_NOTE',
                        'PROCEDURE_NOTE',
                        'PROGRESS_NOTE',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
