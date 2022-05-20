part of 'clinical_note_cubit.dart';

enum CLINCIALNOTESTATE { init, inprogress, saved, created, error }

enum LOADCLINICALNOTE { init, inprogress, loaded, loading, error }

class ClinicalnoteState extends Equatable {
  const ClinicalnoteState(
      {this.medicalPersonnelId = '',
      this.patientId = '',
      this.text = '',
      this.title = '',
      this.clinicalNoteID = '',
      this.errorMessage = '',
      this.loadclinicalnote=LOADCLINICALNOTE.init,
      this.type = ''});

  final String type;
  final String patientId;
  final String medicalPersonnelId;
  final String title;
  final String text;
  final String clinicalNoteID;
  final String errorMessage;
  final LOADCLINICALNOTE loadclinicalnote;
  @override
  List<Object> get props => [
        errorMessage,
        type,
        patientId,
        medicalPersonnelId,
        title,
        text,
        clinicalNoteID
      ];

  ClinicalnoteState copyWith(
      {String? type,
      String? patientId,
      String? medicalId,
      String? title,
      String? clinicalNoteId,
      String? errorMessage,
      LOADCLINICALNOTE? loadclinicalnote,
      String? text}) {
    return ClinicalnoteState(
      loadclinicalnote: loadclinicalnote ?? this.loadclinicalnote,
        errorMessage: errorMessage ?? this.errorMessage,
        type: type ?? this.type,
        title: title ?? this.title,
        text: text ?? this.text,
        clinicalNoteID: clinicalNoteId ?? clinicalNoteID,
        medicalPersonnelId: medicalId ?? medicalPersonnelId,
        patientId: patientId ?? this.patientId);
  }
}
