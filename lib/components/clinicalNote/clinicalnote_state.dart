part of 'clinicalnote_cubit.dart';

enum CLINCIALNOTESTATE { init, inprogress, saved, created, error }

class ClinicalnoteState extends Equatable {
  const ClinicalnoteState(
      {this.medicalPersonnelId = '',
      this.patientId = '',
      this.text = '',
      this.title = '',
      this.clinicalNoteID='',
      this.type = ''});

  final String type;
  final String patientId;
  final String medicalPersonnelId;
  final String title;
  final String text;
  final String clinicalNoteID;

  @override
  List<Object> get props => [type, patientId, medicalPersonnelId, title, text, clinicalNoteID];

  ClinicalnoteState copyWith(
      {String? type,
      String? patientId,
      String? medicalId,
      String? title,
      String? clinicalNoteId,
      String? text}) {
    return ClinicalnoteState(
        type: type ?? this.type,
        title: title ?? this.title,
        text: text ?? this.text,
        clinicalNoteID: clinicalNoteId?? clinicalNoteID,
        medicalPersonnelId: medicalId ?? medicalPersonnelId,
        patientId: patientId ?? this.patientId);
  }
}
