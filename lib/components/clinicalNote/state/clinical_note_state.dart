part of 'clinical_note_bloc.dart';

class ClinicalNoteState extends Equatable {
  const ClinicalNoteState(
      {this.medicalPersonnelId = '',
      this.patientId = '',
      this.text = '',
      this.title = '',
      this.clinicalNoteID = '',
      this.errorMessage = '',
      this.type = ''});
  final String type;
  final String patientId;
  final String medicalPersonnelId;
  final String title;
  final String text;
  final String clinicalNoteID;
  final String errorMessage;
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
  ClinicalNoteState copyWith(
      {String? type,
      String? patientId,
      String? medicalId,
      String? title,
      String? clinicalNoteId,
      String? errorMessage,
      String? text}) {
    return ClinicalNoteState(
        errorMessage: errorMessage ?? this.errorMessage,
        type: type ?? this.type,
        title: title ?? this.title,
        text: text ?? this.text,
        clinicalNoteID: clinicalNoteId ?? clinicalNoteID,
        medicalPersonnelId: medicalId ?? medicalPersonnelId,
        patientId: patientId ?? this.patientId);
  }
}
