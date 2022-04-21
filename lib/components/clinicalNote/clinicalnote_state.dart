part of 'clinicalnote_cubit.dart';

enum CLINCIALNOTESTATE { init, inprogress, saved, created, error }

class ClinicalnoteState extends Equatable {
  const ClinicalnoteState(
      {this.medicalPersonnelId = '',
      this.patientId = '',
      this.text = '',
      this.title = '',
      this.clinicalNoteID = '',
      this.errorMessage='',
      this.type = ''});

  final String type;
  final String patientId;
  final String medicalPersonnelId;
  final String title;
  final String text;
  final String clinicalNoteID;
  final String errorMessage;
  @override
  List<Object> get props =>
      [errorMessage,  type, patientId, medicalPersonnelId, title, text, clinicalNoteID];

  ClinicalnoteState copyWith(
      {String? type,
      String? patientId,
      String? medicalId,
      String? title,
      String? clinicalNoteId,
      String? errorMessage,
      String? text}) {
    return ClinicalnoteState(
      errorMessage: errorMessage?? this.errorMessage,
        type: type ?? this.type,
        title: title ?? this.title,
        text: text ?? this.text,
        clinicalNoteID: clinicalNoteId ?? clinicalNoteID,
        medicalPersonnelId: medicalId ?? medicalPersonnelId,
        patientId: patientId ?? this.patientId);
  }
}
