

part of 'clinicalnote_cubit.dart';

enum CLINCIALNOTESTATE { init, inprogress, saved, created, error }

class ClinicalnoteState extends Equatable {
  const ClinicalnoteState({this.noteModel,  this.medicalPersonnelId, this.patientId, this.text, this.title,  this.type});
    final ClinicalNoteModel? noteModel;
    final String? type;
    final String? patientId;
    final String? medicalPersonnelId;
    final String? title;
    final String? text;

  @override
  List<Object> get props => [noteModel!, type!, patientId!, medicalPersonnelId!,title!,title!,text!];

  /* ClinicalnoteState copywith({ClinicalNoteModel? noteModel}) {
    return ClinicalnoteState(noteModel: noteModel ?? this.noteModel);
  } */

  void set(){
    
  }
}
