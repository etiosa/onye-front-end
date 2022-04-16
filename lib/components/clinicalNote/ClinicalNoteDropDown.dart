import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onye_front_ened/components/clinicalNote/clinicalnote_cubit.dart';
import 'package:onye_front_ened/session/authSession.dart';


class ClinicalNoteDropDown extends StatefulWidget {
  ClinicalNoteDropDown(
      {Key? key, required this.label, required this.options, this.registration})
      : super(
          key: key,
        );
  String label;
  List<String> options;
  dynamic registration;

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
    // run get clincial note // by check if  the current selected wiget has the clinicalNoted id
    if (widget.registration.containsKey('clinicalNoteId')) {
      clinicalNoteId = widget.registration['clinicalNoteId'];

      authsession.getHomeToken()?.then((value) => {
            {
              context
                  .read<ClinicalnoteCubit>()
                  .getPatientClinicalNote(id: clinicalNoteId, token: value)
                  .then((value) {
                context.read<ClinicalnoteCubit>().setclinicalNoteID(
                      clinicalNoteId!,
                    );
                //
              })
            }
          });
    } else {
      //check if the clincialnote state is not empty if its empty the clincial note
      if (context.read<ClinicalnoteCubit>().state.clinicalNoteID.isNotEmpty) {
        context.read<ClinicalnoteCubit>().clearClinicalNoteState();
      }
    }

    return BlocBuilder<ClinicalnoteCubit, ClinicalnoteState>(
      builder: ((context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(widget.label),
            ),
            SizedBox(
              height: 45,
              width: 300,
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: const Color.fromARGB(255, 205, 226, 226),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text("Select Note Type"),
                      dropdownColor: const Color.fromARGB(255, 205, 226, 226),
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          context
                              .read<ClinicalnoteCubit>()
                              .setClinicalNoteType(dropdownValue);
                        });
                      },
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
            ),
          ],
        );
      }),
    );
  }
}
